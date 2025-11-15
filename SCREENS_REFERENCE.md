# 📱 GirlRide Screen Reference Guide

Complete reference for all 20+ screens in the GirlRide app.

---

## 🎬 Authentication Flow

### 1. Splash Screen
**Route**: `/`  
**File**: `features/splash/splash_screen.dart`

**Elements**:
- Animated logo (120px circle with gradient)
- App name: "GirlRide" (48px, bold, white)
- Slogan: "Safe Rides. For Women. By Women."
- Loading indicator
- Purple gradient background

**Duration**: 3 seconds
**Navigation**: Auto-navigates to Onboarding

---

### 2. Onboarding Screens (5 Pages)
**Route**: `/onboarding`  
**File**: `features/onboarding/onboarding_screen.dart`

**Page 1: Women-Only Environment**
- Icon: woman_rounded (60px, royal purple)
- Title: "Women-Only Environment"
- Description: Explains the women-only community
- Skip button (top-right)
- Page indicators (bottom)
- "Next" button

**Page 2: Verified Female Drivers**
- Icon: verified_user_rounded (60px, lavender)
- Title: "Verified Female Drivers"
- Description: Background checks and verification process

**Page 3: Real-Time Safety Tools**
- Icon: gps_fixed_rounded (60px, medium purple)
- Title: "Real-Time Safety Tools"
- Description: Live tracking and monitoring

**Page 4: Panic Button Feature**
- Icon: emergency_rounded (60px, panic red)
- Title: "Panic Button Feature"
- Description: Emergency access explanation

**Page 5: Community & Trust**
- Icon: people_rounded (60px, deep violet)
- Title: "Community & Trust"
- Description: Rating and community standards
- "Get Started" button (final page)

---

### 3. Welcome Screen
**Route**: `/welcome`  
**File**: `features/auth/welcome_screen.dart`

**Elements**:
- Logo circle (140px, gradient)
- Welcome title
- App slogan
- "Sign In" button (gradient)
- "Create Account" button (outlined)
- Terms & Privacy links

**Colors**: Soft gradient background

---

### 4. Login Screen
**Route**: `/login`  
**File**: `features/auth/login_screen.dart`

**Elements**:
- Back button
- "Sign In" title
- Phone number input field
  - Label: "Phone Number"
  - Icon: phone_rounded
  - Placeholder: "+1 (555) 000-0000"
- "Continue" button (gradient, with loading state)
- Info card with verification message
- "Don't have an account? Sign Up" link

---

### 5. OTP Verification Screen
**Route**: `/otp-verification`  
**File**: `features/auth/otp_verification_screen.dart`

**Elements**:
- Back button
- SMS icon (100px circle)
- "Verification Code" title
- Phone number display
- 6 OTP input fields (50x60px each)
- Resend code button with countdown
- "Verify" button (gradient)

**Behavior**:
- Auto-focus next field
- Auto-submit when complete
- 60-second resend countdown

---

### 6. Registration Screen
**Route**: `/register`  
**File**: `features/auth/register_screen.dart`

**Elements**:
- Back button
- "Create Account" title
- User type selection:
  - "Get Rides" card
  - "Drive" card
- Input fields:
  - Full Name
  - Email Address
  - Phone Number
- Terms & Privacy checkbox
- "Continue" button (gradient)
- "Already have an account? Sign In" link

---

## 🏠 Main App Screens

### 7. Home Screen (Main Dashboard)
**Route**: `/home`  
**File**: `features/home/home_screen.dart`

**Top Bar**:
- User avatar (48px circle)
- Greeting: "Hello, [Name]!"
- Subtitle: "Where would you like to go?"
- Notifications icon

**Map Section**:
- Full-screen map placeholder
- Search bar overlay: "Where to?"
- Panic button (bottom-right, floating)

**Quick Actions** (Bottom):
- Safety Center
- Trusted Contacts
- Ride History

**Bottom Navigation**:
- Home (selected)
- Rides
- Safety
- Profile

---

### 8. Ride Request Screen
**Route**: `/ride-request`  
**File**: `features/ride/ride_request_screen.dart`

**Elements**:
- Back button
- "Request Ride" title
- Location inputs:
  - Pickup Location (purple dot icon)
  - Destination (red pin icon)
- Ride type cards:
  - **Standard Ride**: $12.50, 5 min ETA
  - **Night-Safe Ride**: $15.00, 7 min ETA
  - **Scheduled Ride**: $13.00, Later
- Fare estimate card:
  - Estimated fare range
  - Distance
  - Duration
- "Request Ride" button (gradient, arrow icon)

**Card Style**: Each ride type shows icon, title, description, price, and ETA badge

---

### 9. Matching Screen
**Route**: `/matching`  
**File**: `features/ride/matching_screen.dart`

**Elements**:
- Animated search icon (200px, pulsing)
- "Finding a verified female driver..." text
- Progress indicator
- Safety tips carousel:
  - Changes every 3 seconds
  - Icon: lightbulb
  - Title: "Safety Tip"
  - Tip text
- "Cancel Request" button

**Animation**: Pulse effect on search icon

**Duration**: ~5 seconds before navigating to Driver Assigned

---

### 10. Driver Assigned Screen
**Route**: `/driver-assigned`  
**File**: `features/ride/driver_assigned_screen.dart`

**Top Bar**:
- Close button (shows cancel confirmation)
- "Your Driver" title
- Share button

**Driver Card**:
- Driver photo (80px circle) with verified badge
- Name: "Sarah Johnson"
- Rating: 4.9 stars
- Stats: "1,234 rides • 3 years"
- Car details:
  - Icon: directions_car_rounded
  - Model: "Toyota Camry"
  - Color & Plate: "Silver • ABC 1234"

**ETA Card**:
- "Driver arriving in" label
- "3 minutes" (large, purple)
- Clock icon

**Action Buttons**:
- "Call" (secondary)
- "Message" (secondary)

**Bottom Button**:
- "Track Driver" (primary, gradient)

---

### 11. Live Tracking Screen
**Route**: `/tracking`  
**File**: `features/ride/live_tracking_screen.dart`

**Map View** (Full screen)

**Top Info Bar**:
- Back button
- "Arriving in 8 minutes"
- "3.5 km away"
- Share button

**Panic Button**: Right side, floating

**Bottom Sheet**:
- Progress timeline:
  - ✓ Pickup
  - → En Route (active)
  - ○ Dropoff
- Driver info:
  - Photo (56px)
  - Name
  - Car details
  - Call/Message buttons

---

### 12. Panic/Emergency Screen
**Route**: `/panic`  
**File**: `features/safety/panic_screen.dart`

**Countdown Phase**:
- Pulsing warning icon (150px)
- Large countdown number (72px)
- "Emergency Alert Activating" title
- Explanation text
- "Cancel Emergency" button

**Activated Phase** (Red background):
- White crisis icon (150px circle)
- "EMERGENCY ALERT ACTIVATED" (bold, white)
- Status cards (white overlay):
  - ✓ Emergency contacts notified
  - ✓ Live location sharing active
  - ✓ Safety team alerted
  - ✓ Audio recording started
- "Call Emergency Services" button (white bg, red text)
- "False Alarm - Deactivate" link

**Animation**: Pulse on warning icon during countdown

---

### 13. Ride Completion Screen
**Elements**:
- "You arrived safely?" modal
- Yes / No buttons
- Fare breakdown
- Driver rating (stars)
- Tip options
- "Add to Favorites" option
- Receipt option

---

## 👤 Profile & Settings

### 14. Profile Screen
**Route**: `/profile`  
**File**: `features/profile/profile_screen.dart`

**Header**:
- Profile photo (120px circle) with camera icon
- Name: "Sarah Mitchell"
- Verified badge

**Stats Cards** (3 columns):
- Trips: 47
- Rating: 4.9
- Favorites: 12

**Menu Items**:
- Personal Information
- Payment Methods
- Trusted Contacts
- Ride History
- Safety Center
- Notifications
- Help & Support
- About GirlRide

**Footer**:
- "Log Out" button (secondary)

---

## 🔒 Safety Features

### 15. Safety Center Screen
**Route**: `/safety-center`  
**File**: `features/safety/safety_center_screen.dart`

**Header**:
- "Your Safety Is Our Priority" (large, purple)

**Emergency Features**:
- Panic Button card
- Trusted Contacts card
- Live Location Sharing card

**Safety Guidelines** (numbered):
1. Verify Your Driver
2. Share Your Trip
3. Trust Your Instincts
4. Sit in the Back
5. Stay Connected

**Card Style**: Number badge (circle, gradient) + title + description

---

### 16. Trusted Contacts Screen
**Elements**:
- "Add Contact" button
- Contact list:
  - Name
  - Phone number
  - Notification preferences:
    - Trip start alerts
    - Off-route alerts
    - Panic alerts
- Edit/Remove options

---

## 💳 Payments & History

### 17. Payment Methods Screen
**Elements**:
- "Add Payment Method" card
- Saved cards list:
  - Card icon
  - Last 4 digits
  - Expiry date
  - Default badge
- Mobile money options

---

### 18. Ride History Screen
**Elements**:
- Date filters
- Ride cards:
  - Date & time
  - Route (pickup → destination)
  - Driver name
  - Fare
  - Safety score badge
  - "Report Issue" button

---

### 19. Chat Screen
**Elements**:
- Driver info header
- Chat bubbles (purple for user, white for driver)
- Text input
- Send button
- "Chat will be disabled after trip" notice

---

### 20. Report Safety Issue Screen
**Elements**:
- Issue categories:
  - Driver behavior
  - Route deviation
  - Suspicious activity
  - Inappropriate conversation
- Description field
- Photo/audio upload
- "Submit Report" button

---

## 🎨 Screen Patterns

### Common Header Pattern
```
Back Button + Title + Action Button
Height: 56px
Background: White
Shadow: 0px 2px 8px rgba(207, 169, 255, 0.15)
```

### Common Card Pattern
```
Padding: 24px
Border Radius: 24px
Background: White
Shadow: 0px 4px 16px rgba(207, 169, 255, 0.2)
```

### Common List Item Pattern
```
Icon Container (48px, pale lavender, rounded 12px)
+ Content (title + subtitle)
+ Arrow Icon (16px, grey)
Padding: 16px vertical
```

### Common Empty State Pattern
```
Icon (80-100px, lavender)
+ Title (18px, bold)
+ Description (14px, grey)
+ Action Button
```

---

## 🔄 Navigation Flow

```
Splash
  → Onboarding (first time)
    → Welcome
      → Login → OTP → Home
      → Register → Identity Verification → Home

Home
  → Ride Request → Matching → Driver Assigned → Live Tracking → Completion
  → Safety Center
  → Profile
    → Payment Methods
    → Trusted Contacts
    → Ride History
      → Report Issue
```

---

## 📏 Screen Dimensions

### Safe Areas
- Top: Status bar height + 16px
- Bottom: Navigation bar height + 16px
- Sides: 16-24px

### Scrollable Content
- Add padding-bottom: 80px for floating buttons
- Add padding-bottom: 100px for bottom sheets

---

## 🎯 Interaction Patterns

### Pull to Refresh
- Supported on: Ride History, Payments
- Indicator: Purple spinner

### Swipe Actions
- Ride History: Swipe left to report
- Payments: Swipe left to remove

### Long Press
- Driver photo: View full profile
- Ride card: Quick actions menu

### Haptic Feedback
- Panic button: Strong haptic
- Buttons: Light haptic
- Errors: Medium haptic

---

**Last Updated**: November 2025  
**Total Screens**: 20+  
**Design Version**: 1.0.0
