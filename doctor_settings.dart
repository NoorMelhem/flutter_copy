import 'package:flutter/material.dart';
import 'login_screen.dart';

class DoctorSettingsPage extends StatefulWidget {
  const DoctorSettingsPage({super.key});

  @override
  State<DoctorSettingsPage> createState() => _DoctorSettingsPageState();
}

class _DoctorSettingsPageState extends State<DoctorSettingsPage> {

  String clinicName = "My Clinic";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0F0C0),

      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.teal.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFCDE7E6),
        elevation: 0,
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          // 🟢 Edit Clinic Name
          _settingsItem(
            context,
            icon: Icons.edit,
            title: "Edit Clinic Name",
            onTap: () {
              _showEditClinicNameDialog(context);
            },
          ),

          // 🔒 Change Password
          _settingsItem(
            context,
            icon: Icons.lock,
            title: "Change Password",
            onTap: () {
              _showChangePasswordDialog(context);
            },
          ),

          // 🚪 Logout
          _settingsItem(
            context,
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // =======================
  // SETTINGS ITEM
  // =======================
  Widget _settingsItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFCFEED1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF7AB8A6),
          width: 1.5,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal.shade700, size: 30),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.teal.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.teal.shade700,
        ),
        onTap: onTap,
      ),
    );
  }

  // =======================
  // EDIT CLINIC NAME
  // =======================
  void _showEditClinicNameDialog(BuildContext context) {
    TextEditingController clinicCtrl =
    TextEditingController(text: clinicName);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFCFEED1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            "Edit Clinic Name",
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: clinicCtrl,
            decoration: const InputDecoration(
              labelText: "Clinic Name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red.shade400),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  clinicName = clinicCtrl.text;
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Clinic name updated")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
              ),
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // =======================
  // CHANGE PASSWORD
  // =======================
  void _showChangePasswordDialog(BuildContext context) {
    TextEditingController oldPass = TextEditingController();
    TextEditingController newPass = TextEditingController();
    TextEditingController confirmPass = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFCFEED1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            "Change Password",
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildField("Old Password", oldPass, obscure: true),
                const SizedBox(height: 10),
                _buildField("New Password", newPass, obscure: true),
                const SizedBox(height: 10),
                _buildField("Confirm Password", confirmPass, obscure: true),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red.shade400),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
              ),
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // =======================
  // TEXT FIELD
  // =======================
  Widget _buildField(String label, TextEditingController controller,
      {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.teal.shade700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade700),
        ),
      ),
    );
  }
}