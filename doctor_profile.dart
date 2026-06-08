import 'package:flutter/material.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {

  Map<String, dynamic> doctor = {
    "name": "Dr. John Doe",
    "specialty": "Cardiologist",
    "phone": "+963 999 999 999",
    "email": "doctor@example.com",
    "experience": "10 years",
  };


  Future<void> editProfile() async {
    TextEditingController nameCtrl =
    TextEditingController(text: doctor["name"]);
    TextEditingController specialtyCtrl =
    TextEditingController(text: doctor["specialty"]);
    TextEditingController phoneCtrl =
    TextEditingController(text: doctor["phone"]);
    TextEditingController emailCtrl =
    TextEditingController(text: doctor["email"]);
    TextEditingController expCtrl =
    TextEditingController(text: doctor["experience"]);

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFCFEED1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildField("Name", nameCtrl),
                const SizedBox(height: 10),
                _buildField("Specialty", specialtyCtrl),
                const SizedBox(height: 10),
                _buildField("Phone", phoneCtrl),
                const SizedBox(height: 10),
                _buildField("Email", emailCtrl),
                const SizedBox(height: 10),
                _buildField("Experience", expCtrl),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text("Cancel", style: TextStyle(color: Colors.red.shade400)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  doctor["name"] = nameCtrl.text;
                  doctor["specialty"] = specialtyCtrl.text;
                  doctor["phone"] = phoneCtrl.text;
                  doctor["email"] = emailCtrl.text;
                  doctor["experience"] = expCtrl.text;
                });
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

  Widget _buildField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0F0C0),
      appBar: AppBar(
        title: Text(
          "Doctor Profile",
          style: TextStyle(color: Colors.teal.shade900),
        ),
        backgroundColor: const Color(0xFFCDE7E6),
        elevation: 0,
        centerTitle: true,
      ),

      body: Padding(padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _infoTile("Name", doctor["name"]),
            _infoTile("Specialty", doctor["specialty"]),
            _infoTile("Phone", doctor["phone"]),
            _infoTile("Email", doctor["email"]),
            _infoTile("Experience", doctor["experience"]),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: editProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Edit Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFCFEED1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF7AB8A6),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal.shade900,
                fontWeight: FontWeight.bold,
              )),
          Text(value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal.shade700,
              )),
        ],
      ),
    );
  }
}