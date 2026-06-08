import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled9/doctor_dashboard.dart';
import 'package:untitled9/patient_dashboard.dart';
import 'register_screen.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:toastification/toastification.dart';


class Doctor {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String type;

  const Doctor({required this.id, required this.name,required this.email,required this.phone,required this.password,required this.type});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      { 'name': String name, 'email': String email, 'phone': String phone, 'password': String password, 'id': int id, 'type': String type} => Doctor(
        name: name,
        email: email,
        phone: phone,
        password: password,
        id: id,
        type: type,
      ),
      _ => throw const FormatException('Failed to load doctor.'),
    };
  }
}


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // الخلفية: Gradient من أعلى إلى أسفل
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal,
              Colors.tealAccent.shade100,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // شعار أو أيقونة
                  Icon(
                    Icons.local_hospital,
                    size: 100,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),

                  // البريد الإلكتروني
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.teal),
                      labelText: "البريد الإلكتروني",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),

                  // كلمة المرور
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.teal),
                      labelText: "كلمة المرور",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),

                  // زر تسجيل الدخول
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async{
                        print(emailController.text);
                        print(passwordController.text);


                        Future<Doctor> fetchDoctor() async {
                          String mail = emailController.text;
                          String pass = passwordController.text;
                          final response = await http.get(
                            Uri.parse('http://127.0.0.1:8000/gdoctor/$mail/$pass/'),
                            headers: {'Accept': 'application/json'},
                          );

                          if (response.statusCode == 200) {
                            // If the server did return a 200 OK response,
                            // then parse the JSON.
                            final List<dynamic> data = jsonDecode(response.body);

                            if (data.isEmpty) {
                              toastification.show(
                                context: context, // optional if you use ToastificationWrapper
                                title: Text('البريد الإلكتروني أو كلمة المرور غير صحيحة'),
                                type: ToastificationType.error,
                                autoCloseDuration: const Duration(seconds: 5),
                              );



                            }

                            return Doctor.fromJson(data[0]);
                          } else {
                            // If the server did not return a 200 OK response,
                            // then throw an exception.
                            throw Exception('Failed to load doctor');
                          }
                        }

                        Doctor doctor = await fetchDoctor();
                        if (doctor != null) {
                          // Load and obtain the shared preferences for this app.
                          final prefs = await SharedPreferences.getInstance();

                          // Save the counter value to persistent storage under the 'counter' key.
                          await prefs.setString('name', doctor.name);
                          await prefs.setString('email', doctor.email);
                          await prefs.setString('password', doctor.password);
                          await prefs.setString('phone', doctor.phone);
                          await prefs.setString('type', doctor.type);
                          await prefs.setInt('id', doctor.id);


                          print(doctor.type);



                          if (doctor.type == "DOCTOR") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDashboard(),
                              ),
                            );
                          } else if (doctor.type == "PATIENT") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PatientDashboard(),
                              ),
                            );
                          }
                        }





                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[700],
                      ),
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // زر إنشاء حساب جديد
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "إنشاء حساب جديد",
                      style: TextStyle(color: const Color.fromARGB(255, 67, 63, 63)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
