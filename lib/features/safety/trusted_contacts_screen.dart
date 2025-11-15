import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/text_fields.dart';

class TrustedContactsScreen extends StatefulWidget {
  const TrustedContactsScreen({Key? key}) : super(key: key);

  @override
  State<TrustedContactsScreen> createState() => _TrustedContactsScreenState();
}

class _TrustedContactsScreenState extends State<TrustedContactsScreen> {
  final List<Map<String, String>> _contacts = [
    {'name': 'Mom', 'phone': '+1 (555) 123-4567', 'relation': 'Mother'},
    {'name': 'Sarah Johnson', 'phone': '+1 (555) 987-6543', 'relation': 'Friend'},
  ];

  void _addContact() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _AddContactSheet(),
    ).then((contact) {
      if (contact != null) {
        setState(() {
          _contacts.add(contact);
        });
      }
    });
  }

  void _removeContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Contact removed'),
        backgroundColor: AppColors.royalPurple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Trusted Contacts', style: AppTextStyles.headlineLarge),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Header info
          Container(
            margin: const EdgeInsets.all(AppConstants.spacingL),
            padding: const EdgeInsets.all(AppConstants.spacingL),
            decoration: BoxDecoration(
              color: AppColors.paleLavender,
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.royalPurple,
                  size: AppConstants.iconSizeL,
                ),
                const SizedBox(width: AppConstants.spacingM),
                Expanded(
                  child: Text(
                    'These contacts will be notified during emergencies and can track your rides.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.darkCharcoal,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Contacts list
          Expanded(
            child: _contacts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_add_outlined,
                          size: 64,
                          color: AppColors.greyDark.withOpacity(0.5),
                        ),
                        const SizedBox(height: AppConstants.spacingL),
                        Text(
                          'No trusted contacts yet',
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: AppColors.greyDark,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingS),
                        Text(
                          'Add contacts who can help in emergencies',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.greyDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingL,
                    ),
                    itemCount: _contacts.length,
                    itemBuilder: (context, index) {
                      final contact = _contacts[index];
                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: AppConstants.spacingM,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusL,
                          ),
                          border: Border.all(
                            color: AppColors.greyLight,
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(
                            AppConstants.spacingM,
                          ),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.paleLavender,
                            child: Text(
                              contact['name']![0].toUpperCase(),
                              style: AppTextStyles.headlineMedium.copyWith(
                                color: AppColors.royalPurple,
                              ),
                            ),
                          ),
                          title: Text(
                            contact['name']!,
                            style: AppTextStyles.headlineSmall,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: AppConstants.spacingXS),
                              Text(
                                contact['phone']!,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.greyDark,
                                ),
                              ),
                              const SizedBox(height: AppConstants.spacingXS),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppConstants.spacingS,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.lavender.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.radiusS,
                                  ),
                                ),
                                child: Text(
                                  contact['relation']!,
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.deepViolet,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: AppColors.error,
                            ),
                            onPressed: () => _removeContact(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          child: PrimaryButton(
            text: 'Add Trusted Contact',
            onPressed: _addContact,
            width: double.infinity,
            gradient: true,
            icon: Icons.person_add_rounded,
          ),
        ),
      ),
    );
  }
}

class _AddContactSheet extends StatefulWidget {
  const _AddContactSheet();

  @override
  State<_AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<_AddContactSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _relationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _relationController.dispose();
    super.dispose();
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'relation': _relationController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXL),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingXL),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Trusted Contact',
                    style: AppTextStyles.headlineLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingL),

              // Name field
              CustomTextField(
                label: 'Full Name',
                hint: 'Enter contact name',
                controller: _nameController,
                prefixIcon: const Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.royalPurple,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.spacingL),

              // Phone field
              CustomTextField(
                label: 'Phone Number',
                hint: '+1 (555) 000-0000',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(
                  Icons.phone_rounded,
                  color: AppColors.royalPurple,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.spacingL),

              // Relation field
              CustomTextField(
                label: 'Relationship',
                hint: 'e.g., Mother, Friend, Sister',
                controller: _relationController,
                prefixIcon: const Icon(
                  Icons.favorite_outline_rounded,
                  color: AppColors.royalPurple,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter relationship';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.spacingXL),

              // Save button
              PrimaryButton(
                text: 'Save Contact',
                onPressed: _saveContact,
                width: double.infinity,
                gradient: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
