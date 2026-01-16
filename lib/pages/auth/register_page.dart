import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/bac_sections.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String? _selectedSection;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Complete your profile to unlock your specific Baccalaureate curriculum.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 32),

              _buildTextField(_firstNameCtrl, "First Name", Icons.person_outline),
              const SizedBox(height: 16),
              _buildTextField(_lastNameCtrl, "Surname", Icons.person_outline),
              const SizedBox(height: 16),
              _buildTextField(_phoneCtrl, "Phone Number (+216)", Icons.phone_android, isPhone: true),
              const SizedBox(height: 24),

              // Section Dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedSection,
                hint: const Text("Select your Bac Section"),
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  prefixIcon: const Icon(Icons.school_outlined),
                ),
                items: BacSections.all.map((section) {
                  return DropdownMenuItem(
                    value: section,
                    child: Text(section, style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedSection = val),
                validator: (v) => v == null ? "Please select a section" : null,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: _submit,
                child: const Text("Start Studying", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String label, IconData icon, {bool isPhone = false}) {
    return TextFormField(
      controller: ctrl,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      validator: (v) => v!.isEmpty ? "Required" : null,
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Access your AuthNotifier to save the user data
      // This will trigger the app to switch from 'Unauthenticated' to 'Authenticated'
      // and redirect to the Home Page automatically.
      
      // ref.read(authProvider.notifier).registerUser(
      //   firstName: _firstNameCtrl.text,
      //   lastName: _lastNameCtrl.text,
      //   phone: _phoneCtrl.text,
      //   section: _selectedSection!,
      // );

      context.go('/'); 
    }
  }
}