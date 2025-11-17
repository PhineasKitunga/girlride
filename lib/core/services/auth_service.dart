import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Authentication service handling user login, registration, and session management
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Check if user is logged in
  bool get isLoggedIn => currentUser != null;

  /// Sign up with email and password
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String userType, // 'rider' or 'driver'
  }) async {
    try {
      print('Starting signup for: $email');
      print('Firestore instance: $_firestore');
      
      // Create user in Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      print('Firebase Auth user created: ${user.uid}');
      print('User email verified: ${user.emailVerified}');
      
      // Get auth token to ensure authentication is complete
      final token = await user.getIdToken();
      print('Auth token obtained: ${token?.substring(0, 20)}...');
      
      // Wait a moment for auth state to propagate
      await Future.delayed(const Duration(milliseconds: 500));

      // Create user profile in Firestore
      print('Creating Firestore document for user: ${user.uid}');
      try {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'fullName': fullName,
          'phone': phone,
          'userType': userType,
          'createdAt': FieldValue.serverTimestamp(),
          'profileImageUrl': '',
          'rating': 5.0,
          'totalRides': 0,
          'isVerified': false,
        }).timeout(
          const Duration(seconds: 15),
          onTimeout: () {
            throw Exception('Firestore operation timed out after 15 seconds. Check your internet connection and Firestore rules.');
          },
        );
        print('Firestore document created successfully');
      } catch (firestoreError) {
        print('Firestore error details: $firestoreError');
        print('Error type: ${firestoreError.runtimeType}');
        rethrow;
      }

      // Update display name
      await user.updateDisplayName(fullName);
      print('Display name updated');

      // Cache user data locally
      await _cacheUserData(user.uid, fullName, email, phone, userType);
      print('User data cached locally');

      return {
        'success': true,
        'message': 'Account created successfully',
        'user': user,
      };
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      return {
        'success': false,
        'message': _getAuthErrorMessage(e.code),
      };
    } catch (e) {
      print('Error during signup: $e');
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  /// Sign in with email and password
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;

      // Fetch user data from Firestore
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      
      if (userDoc.exists) {
        final userData = userDoc.data()!;
        
        // Cache user data locally
        await _cacheUserData(
          user.uid,
          userData['fullName'] ?? '',
          userData['email'] ?? email,
          userData['phone'] ?? '',
          userData['userType'] ?? 'rider',
        );
      }

      return {
        'success': true,
        'message': 'Signed in successfully',
        'user': user,
      };
    } on FirebaseAuthException catch (e) {
      return {
        'success': false,
        'message': _getAuthErrorMessage(e.code),
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred. Please try again.',
      };
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _clearUserCache();
  }

  /// Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data();
    } catch (e) {
      return null;
    }
  }

  /// Update user profile
  Future<bool> updateUserProfile({
    required String uid,
    String? fullName,
    String? phone,
    String? profileImageUrl,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (fullName != null) updates['fullName'] = fullName;
      if (phone != null) updates['phone'] = phone;
      if (profileImageUrl != null) updates['profileImageUrl'] = profileImageUrl;
      
      if (updates.isEmpty) return true;

      await _firestore.collection('users').doc(uid).update(updates);

      // Update cached data
      final prefs = await SharedPreferences.getInstance();
      if (fullName != null) await prefs.setString('user_name', fullName);
      if (phone != null) await prefs.setString('user_phone', phone);

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Cache user data locally
  Future<void> _cacheUserData(
    String uid,
    String name,
    String email,
    String phone,
    String userType,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_uid', uid);
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_phone', phone);
    await prefs.setString('user_type', userType);
    await prefs.setBool('is_logged_in', true);
  }

  /// Get cached user data
  Future<Map<String, String?>> getCachedUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'uid': prefs.getString('user_uid'),
      'name': prefs.getString('user_name'),
      'email': prefs.getString('user_email'),
      'phone': prefs.getString('user_phone'),
      'userType': prefs.getString('user_type'),
    };
  }

  /// Clear user cache
  Future<void> _clearUserCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_uid');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('user_phone');
    await prefs.remove('user_type');
    await prefs.setBool('is_logged_in', false);
  }

  /// Get friendly error messages
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'weak-password':
        return 'Password is too weak (min 6 characters)';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-credential':
        return 'Invalid email or password';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      default:
        return 'Authentication error. Please try again';
    }
  }
}
