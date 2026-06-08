import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookAppointmentScreen(),
    );
  }
}

class BookAppointmentScreen extends StatefulWidget {
  @override
  _BookAppointmentScreenState createState() =>
      _BookAppointmentScreenState();
}

class _BookAppointmentScreenState
    extends State<BookAppointmentScreen> {

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],

      appBar: AppBar(
        title: Text("حجز موعد"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // عنوان
            Text(
              "اختر تاريخ ووقت الموعد",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),

            SizedBox(height: 30),

            // اختيار التاريخ
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.teal),
                title: Text(
                  selectedDate == null
                      ? "اختار التاريخ"
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                ),
                onTap: () async {

                  DateTime now = DateTime.now();

                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now, // من اليوم وطالع
                    lastDate: DateTime(2100), // حل المشكلة
                  );

                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
              ),
            ),

            SizedBox(height: 20),

            // اختيار الوقت
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.access_time, color: Colors.teal),
                title: Text(
                  selectedTime == null
                      ? "اختار الوقت"
                      : selectedTime!.format(context),
                ),
                onTap: () async {

                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (picked != null) {
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
              ),
            ),

            SizedBox(height: 40),

            // زر تأكيد
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {

                  if (selectedDate == null || selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("يرجى اختيار التاريخ والوقت"),
                      ),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("تم حجز الموعد بنجاح"),
                    ),
                  );

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "تأكيد الحجز",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}