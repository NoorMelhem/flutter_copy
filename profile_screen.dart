import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // بيانات مؤقتة (لاحقاً من Django)
  String name = "محمد أحمد";
  String email = "test@gmail.com";
  String phone = "0999999999";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],

      appBar: AppBar(
        title: Text("حسابي"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            SizedBox(height: 20),

            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),

            SizedBox(height: 20),

            Text(
              name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),

            SizedBox(height: 30),

            buildInfoCard(Icons.email, "الإيميل", email),
            SizedBox(height: 15),
            buildInfoCard(Icons.phone, "رقم الهاتف", phone),

            SizedBox(height: 30),

            // زر تعديل
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showEditDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: Text("تعديل المعلومات"),
              ),
            ),

            SizedBox(height: 15),

            // تسجيل الخروج
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text("تسجيل الخروج"),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(IconData icon, String title, String value) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }

  void showEditDialog() {
    TextEditingController nameController =
    TextEditingController(text: name);

    TextEditingController phoneController =
    TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("تعديل المعلومات"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "الاسم"),
              ),

              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "رقم الهاتف"),
              ),

            ],
          ),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("إلغاء"),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  phone = phoneController.text;
                });

                Navigator.pop(context);
              },
              child: Text("حفظ"),
            ),

          ],
        );
      },
    );
  }
}