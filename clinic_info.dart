import 'package:flutter/material.dart';

class ClinicInfo extends StatefulWidget {
  const ClinicInfo({super.key});

  @override
  State<ClinicInfo> createState() => _ClinicInfoState();
}

class _ClinicInfoState extends State<ClinicInfo> {

  Map<String, dynamic>? clinic;


  Future<void> editClinic() async {
    TextEditingController nameCtrl =
    TextEditingController(text: clinic?["name"] ?? "");
    TextEditingController phoneCtrl =
    TextEditingController(text: clinic?["phone"] ?? "");
    TextEditingController hoursCtrl =
    TextEditingController(text: clinic?["hours"] ?? "");

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFCFEED1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            clinic == null ? "Add Clinic" : "Edit Clinic",
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildField("Clinic Name", nameCtrl),
                const SizedBox(height: 10),
                _buildField("Phone", phoneCtrl),
                const SizedBox(height: 10),
                _buildField("Working Hours", hoursCtrl),
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
                  clinic = {
                    "name": nameCtrl.text,
                    "phone": phoneCtrl.text,
                    "hours": hoursCtrl.text,
                  };
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
          "Clinic Info",
          style: TextStyle(color: Colors.teal.shade900),
        ),
        backgroundColor: const Color(0xFFCDE7E6),
        elevation: 0,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: clinic == null
            ? _noClinicView()
            : _clinicDetailsView(),
      ),
    );
  }


  Widget _noClinicView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No clinic added yet.",
          style: TextStyle(
            fontSize: 18,
            color: Colors.teal.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: editClinic,style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.shade700,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
          child: const Text("Add Clinic"),
        ),
      ],
    );
  }


  Widget _clinicDetailsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoTile("Clinic Name", clinic!["name"]),
        _infoTile("Phone", clinic!["phone"]),
        _infoTile("Working Hours", clinic!["hours"]),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: editClinic,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade700,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text("Edit Clinic"),
          ),
        ),
      ],
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