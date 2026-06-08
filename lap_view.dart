import 'package:flutter/material.dart';
import 'doctor_medicalRecords.dart';

class LabImagePage extends StatelessWidget {
  final String name;
  final String test;
  final String imageUrl;

  const LabImagePage({
    super.key,
    required this.name,
    required this.test,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {

    final safeName = name.isEmpty ? "Unknown" : name;
    final safeTest = test.isEmpty ? "Test" : test;
    final safeImage = imageUrl.isEmpty ? null : imageUrl;

    return Scaffold(
      backgroundColor: const Color(0xFFD0F0C0),

      appBar: AppBar(
        backgroundColor: const Color(0xFFCDE7E6),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal.shade900),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DoctorMedicalRecords()),
            );
          },
        ),

        title: Text(
          "$safeTest Result",
          style: TextStyle(color: Colors.teal.shade900),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Patient: $safeName",
              style: TextStyle(
                fontSize: 18,
                color: Colors.teal.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: safeImage == null
                  ? Text(
                "No image available",
                style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 18,
                ),
              )
                  : Image.network(
                safeImage,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}