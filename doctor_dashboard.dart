import 'package:flutter/material.dart';
import 'doctor_features.dart';
import 'doctor_appointments.dart';
import 'doctor_medicalRecords.dart';
import 'doctor_profile.dart';
import 'doctor_settings.dart';
import 'lap_view.dart'; // 👈 مهم

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  int notificationCount = 3;

  List<Map<String, String>> labNotifications = [
    {
      "name": "Ahmed",
      "test": "CBC Test",
      "imageUrl": "https://via.placeholder.com/300"
    },
    {
      "name": "Sara",
      "test": "X-Ray",
      "imageUrl": "https://via.placeholder.com/300"
    },
    {
      "name": "Omar",
      "test": "Blood Sugar",
      "imageUrl": "https://via.placeholder.com/300"
    },
  ];

  Map<String, dynamic> doctorData = {
    "name": "Dr. Ahmad Ali",
    "specialty": "Cardiology",
    "work": "Heart surgeries • ECG • Follow-ups",
  };

  Widget buildCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFCDE7E6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF7AB8A6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.teal.shade700, size: 32),
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔔 نافذة الإشعارات
  void showNotifications() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Notifications"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: labNotifications.length,
              itemBuilder: (context, index) {
                final item = labNotifications[index];

                return ListTile(
                  leading: const Icon(Icons.science, color: Colors.teal),
                  title: Text(item["name"]!),
                  subtitle: Text(item["test"]!),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LabImagePage(
                          name: item["name"]!,
                          test: item["test"]!,
                          imageUrl: item["imageUrl"]!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0F0C0),

      appBar: AppBar(
        title: Text(
          "Doctor Dashboard",
          style: TextStyle(color: Colors.teal.shade900),
        ),
        backgroundColor: const Color(0xFFCDE7E6),
        elevation: 0,
        centerTitle: true,

        // 🔔 أيقونة الإشعارات
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.teal),
                onPressed: showNotifications,
              ),

              if (notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      notificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              /// 🔹 كرت الطبيب
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFCFEED1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF7AB8A6),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_circle_rounded,
                        color: Colors.teal.shade700, size: 55),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorData["name"],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade900,
                            ),
                          ),
                          const SizedBox(height: 4),

                          Text(
                            doctorData["specialty"],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.teal.shade700,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            doctorData["work"],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.teal.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// 🔹 الكروت
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.1,
                children: [
                  buildCard(
                    icon: Icons.star_rounded,
                    title: "My Features",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DoctorFeatures()));
                    },
                  ),
                  buildCard(
                    icon: Icons.calendar_month_rounded,
                    title: "Appointments",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DoctorAppointments()));
                    },
                  ),
                  buildCard(
                    icon: Icons.folder_special_rounded,
                    title: "Medical Records",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DoctorMedicalRecords()));
                    },
                  ),
                  buildCard(
                    icon: Icons.person_rounded,
                    title: "Profile",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DoctorProfile()));
                    },
                  ),
                  buildCard(
                    icon: Icons.settings,
                    title: "Settings",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DoctorSettingsPage()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}