import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';

import 'search_clinic_screen.dart';
import 'book_appointment_screen.dart';
import 'my_appointments_screen.dart';
import 'profile_screen.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  XFile? analysisImage;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: const Text("لوحة المريض"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.local_hospital,
                  size: 90, color: Colors.teal),

              const SizedBox(height: 10),

              Text(
                "مرحباً بك",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),

              const SizedBox(height: 40),

              // 🔍 البحث عن عيادة
              buildCard(
                context,
                "البحث عن عيادة",
                Icons.search,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SearchClinicScreen()),
                  );
                },
              ),

              const SizedBox(height: 20),

              // 📅 حجز موعد (رجعناه)
              buildCard(
                context,
                "حجز موعد",
                Icons.calendar_today,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BookAppointmentScreen()),
                  );
                },
              ),

              const SizedBox(height: 20),

              // ⏰ مواعيدي
              buildCard(
                context,
                "مواعيدي",
                Icons.schedule,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MyAppointmentsScreen()),
                  );
                },
              ),

              const SizedBox(height: 20),

              // 👤 حسابي
              buildCard(
                context,
                "حسابي",
                Icons.person,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProfileScreen()),
                  );
                },
              ),

              const SizedBox(height: 20),

              // 📁 سجل المريض
              buildCard(
                context,
                "سجل المريض",
                Icons.folder_open,
                onTap: () {
                  _showMedicalRecordDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= CARD =================
  Widget buildCard(
      BuildContext context,
      String title,
      IconData icon, {
        VoidCallback? onTap,
      }) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.teal),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
      ),
    );
  }

  // ================= MEDICAL RECORD =================
  void _showMedicalRecordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: Colors.teal[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                "السجل الطبي",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfo("التشخيص", "Flu"),
                    _buildInfo("ملاحظات الطبيب", "راحة + سوائل"),
                    _buildInfo("الأدوية", "Panadol"),
                    _buildInfo("موعد المراجعة", "2026-05-10"),

                    const SizedBox(height: 15),

                    Text(
                      "التحاليل",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.teal),
                      ),
                      child: analysisImage == null
                          ? const Center(child: Text("لا يوجد تحليل بعد"))
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: PhotoView(
                          imageProvider: FileImage(
                            File(analysisImage!.path),
                          ),
                          backgroundDecoration:
                          const BoxDecoration(color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: () async {
                        final picked = await picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (picked != null) {
                          setStateDialog(() {
                            analysisImage = picked;
                          });
                        }
                      },
                      icon: const Icon(Icons.upload),
                      label: const Text("رفع تحليل"),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text(
                    "إغلاق",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal[900],
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}