import 'package:flutter/material.dart';

class MyAppointmentsScreen extends StatefulWidget {
  @override
  _MyAppointmentsScreenState createState() =>
      _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState
    extends State<MyAppointmentsScreen> {

  // بيانات مؤقتة (لاحقاً من Django)
  List appointments = [
    {
      "doctor": "د. أحمد",
      "specialty": "قلبية",
      "date": "12/5/2026",
      "time": "10:00",
      "status": "Pending"
    },
    {
      "doctor": "د. سارة",
      "specialty": "أطفال",
      "date": "15/5/2026",
      "time": "12:00",
      "status": "Confirm"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],

      appBar: AppBar(
        title: Text("مواعيدي"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),

      body: appointments.isEmpty
          ? Center(
        child: Text(
          "لا يوجد مواعيد حالياً",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: appointments.length,
        itemBuilder: (context, index) {

          var appointment = appointments[index];

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.only(bottom: 20),

            child: Padding(
              padding: EdgeInsets.all(15),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // اسم الطبيب + الاختصاص
                  Text(
                    "${appointment["doctor"]} - ${appointment["specialty"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),

                  SizedBox(height: 10),

                  // الاختصاص
                  Row(
                    children: [
                      Icon(Icons.medical_services,
                          color: Colors.teal),
                      SizedBox(width: 10),
                      Text(
                        "الاختصاص: ${appointment["specialty"]}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // التاريخ
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: Colors.teal),
                      SizedBox(width: 10),
                      Text(
                        "التاريخ: ${appointment["date"]}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),

                  // الوقت
                  Row(
                    children: [
                      Icon(Icons.access_time,
                          color: Colors.teal),
                      SizedBox(width: 10),
                      Text(
                        "الوقت: ${appointment["time"]}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // حالة الموعد
                  Row(
                    children: [
                      Icon(
                        appointment["status"] == "Confirm"
                            ? Icons.check_circle
                            : Icons.pending,
                        color:
                        appointment["status"] == "Confirm"
                            ? Colors.green
                            : Colors.orange,
                      ),

                      SizedBox(width: 10),

                      Text(
                        "الحالة: ${appointment["status"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                          appointment["status"] == "Confirm"
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  // زر إلغاء
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {

                        setState(() {
                          appointments.removeAt(index);
                        });

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            content:
                            Text("تم إلغاء الموعد"),
                          ),
                        );
                      },
                      child: Text(
                        "إلغاء الموعد",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}