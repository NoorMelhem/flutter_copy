import 'package:flutter/material.dart';
import 'pending_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String role = "patient";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  // Doctor fields
  String? specialization;
  final clinicNameController = TextEditingController();

  // Patient fields (لسا موجودين بس ما عاد مستخدمين)
  final ageController = TextEditingController();
  String gender = "male";
  final healthStatusController = TextEditingController();

  final List<String> specializations = [
    "Cardiology",
    "Dermatology",
    "Neurology",
    "Pediatrics",
    "General"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              children: [

                Icon(Icons.local_hospital,
                    size: 100, color: Colors.teal),

                SizedBox(height: 20),

                Text(
                  "عيادات طبية",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),

                SizedBox(height: 30),

                buildField(nameController, "الاسم", Icons.person),
                SizedBox(height: 15),

                buildField(emailController, "البريد الإلكتروني", Icons.email),
                SizedBox(height: 15),

                buildField(phoneController, "رقم الهاتف", Icons.phone),
                SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: inputDecoration("كلمة المرور", Icons.lock),
                ),

                SizedBox(height: 20),

                // نوع الحساب
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text("نوع الحساب",
                          style: TextStyle(fontWeight: FontWeight.bold)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: "patient",
                            groupValue: role,
                            onChanged: (value) {
                              setState(() {
                                role = value.toString();
                              });
                            },
                          ),
                          Text("مريض"),

                          Radio(
                            value: "doctor",
                            groupValue: role,
                            onChanged: (value) {
                              setState(() {
                                role = value.toString();
                              });
                            },
                          ),
                          Text("طبيب"),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // 🧑‍⚕️ الطبيب
                if (role == "doctor") ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButton<String>(
                      value: specialization,
                      hint: Text("اختيار الاختصاص"),
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: Icon(Icons.arrow_drop_down, color: Colors.teal),
                      items: specializations.map((spec) {
                        return DropdownMenuItem(
                          value: spec,
                          child: Text(spec),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          specialization = value;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 15),

                  buildField(
                    clinicNameController,
                    "اسم العيادة",
                    Icons.local_hospital,
                  ),
                ],

                // 🧑 المريض (تم إخفاء الحقول بالكامل)
                if (role == "patient") ...[
                  // intentionally empty
                ],

                SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          phoneController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("يرجى تعبئة البيانات الأساسية")),
                        );
                        return;
                      }

                      if (role == "doctor") {
                        if (specialization == null ||
                            clinicNameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("يرجى تعبئة بيانات الطبيب")),
                          );
                          return;
                        }
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PendingScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[700],
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "إنشاء الحساب",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(
      TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: inputDecoration(label, icon),
    );
  }

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.teal),
      labelText: label,
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}