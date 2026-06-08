import 'package:flutter/material.dart';
import 'book_appointment_screen.dart';

class SearchClinicScreen extends StatefulWidget {
  @override
  _SearchClinicScreenState createState() => _SearchClinicScreenState();
}

class _SearchClinicScreenState extends State<SearchClinicScreen> {

  TextEditingController doctorController = TextEditingController();

  String? selectedSpecialty;

  List clinics = [
    {
      "clinic_name": "عيادة الشفاء",
      "doctor_name": "د. أحمد",
      "specialty": "طب الأطفال",
      "info": "خبرة 10 سنوات - استقبال أطفال - متوفر صباحاً"
    },
    {
      "clinic_name": "عيادة النور",
      "doctor_name": "د. سارة",
      "specialty": "طب الأسنان",
      "info": "تقويم - تنظيف - حشوات - دوام مسائي"
    },
    {
      "clinic_name": "عيادة الحياة",
      "doctor_name": "د. محمد",
      "specialty": "طب الباطنة",
      "info": "أمراض مزمنة - ضغط - سكري"
    },
  ];

  List filteredClinics = [];

  @override
  void initState() {
    super.initState();
    filteredClinics = clinics;
  }

  void search() {
    setState(() {
      filteredClinics = clinics.where((clinic) {
        final doctorMatch = doctorController.text.isEmpty ||
            clinic["doctor_name"]
                .toLowerCase()
                .contains(doctorController.text.toLowerCase());

        final specialtyMatch = selectedSpecialty == null ||
            clinic["specialty"] == selectedSpecialty;

        return doctorMatch && specialtyMatch;
      }).toList();
    });
  }

  // 🔥 نافذة معلومات الطبيب
  void showDoctorInfo(Map clinic) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(clinic["doctor_name"]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("الاختصاص: ${clinic["specialty"]}"),
              SizedBox(height: 10),
              Text("معلومات:"),
              SizedBox(height: 5),
              Text(clinic["info"]),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("إغلاق"),
            ),
          ],
        );
      },
    );
  }

  // 🔥 الانتقال للحجز (بدون باراميتر)
  void goToBooking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookAppointmentScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("البحث عن عيادة"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            // اسم الطبيب
            TextField(
              controller: doctorController,
              decoration: InputDecoration(
                labelText: "اسم الطبيب",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            // الاختصاص
            DropdownButtonFormField<String>(
              value: selectedSpecialty,
              hint: Text("اختر الاختصاص"),
              items: [
                "طب الأطفال",
                "طب الأسنان",
                "داخلية"
              ].map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSpecialty = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            // زر البحث
            ElevatedButton(
              onPressed: search,
              child: Text("بحث"),
            ),

            SizedBox(height: 20),

            // النتائج
            Expanded(
              child: ListView.builder(
                itemCount: filteredClinics.length,
                itemBuilder: (context, index) {
                  var clinic = filteredClinics[index];

                  return Card(
                    child: ListTile(
                      title: Text(clinic["clinic_name"]),
                      subtitle: Text(
                          "${clinic["doctor_name"]} - ${clinic["specialty"]}"),

                      // 👇 الضغط = حجز موعد
                      onTap: () {
                        goToBooking();
                      },

                      // 👇 معلومات الطبيب
                      trailing: IconButton(
                        icon: Icon(Icons.info, color: Colors.teal),
                        onPressed: () {
                          showDoctorInfo(clinic);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}