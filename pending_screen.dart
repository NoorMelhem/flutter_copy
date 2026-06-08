import 'package:flutter/material.dart';
import 'doctor_dashboard.dart';
import 'patient_dashboard.dart';

class PendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("قيد المراجعة"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "حسابك قيد المراجعة",
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorDashboard(),
                  ),
                );
              },
              child: Text("دخول كطبيب (تجربة)"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientDashboard(),
                  ),
                );
              },
              child: Text("دخول كمريض (تجربة)"),
            ),

          ],
        ),
      ),
    );
  }
}
