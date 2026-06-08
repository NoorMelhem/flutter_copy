import 'package:flutter/material.dart';

class DoctorAppointments extends StatefulWidget {
  const DoctorAppointments({super.key});

  @override
  State<DoctorAppointments> createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointments> {

  List<Map<String, dynamic>> appointments = [
    {
      "patient": "Patient Name",
      "date": "2024-01-01",
      "time": "10:00 AM",
      "status": "Pending",
    },
  ];


  Future<void> confirmAppointment(int index) async {
    setState(() {
      appointments[index]["status"] = "Confirmed";
    });
  }


  Future<void> cancelAppointment(int index) async {
    setState(() {
      appointments[index]["status"] = "Cancelled";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0F0C0), // Tea Green

      appBar: AppBar(
        title: Text(
          "Appointments",
          style: TextStyle(color: Colors.teal.shade900),
        ),
        backgroundColor: const Color(0xFFCDE7E6), // Tea Blue
        elevation: 0,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: appointments.isEmpty
            ? Center(
          child: Text(
            "No appointments yet",
            style: TextStyle(
              fontSize: 18,
              color: Colors.teal.shade800,
            ),
          ),
        )
            : ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appt = appointments[index];

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFCFEED1), // Soft Mint
                borderRadius: BorderRadius.circular(18),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Icon(
                        Icons.person_rounded,
                        color: Colors.teal.shade700,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        appt["patient"],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade900,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),


                  Row(
                    children: [
                      Icon(Icons.calendar_month_rounded,
                          color: Colors.teal.shade600),
                      const SizedBox(width: 8),Text(
                        appt["date"],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Icon(Icons.access_time_rounded,
                          color: Colors.teal.shade600),
                      const SizedBox(width: 8),
                      Text(
                        appt["time"],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),


                  Row(
                    children: [
                      Icon(Icons.info_outline_rounded,
                          color: Colors.teal.shade600),
                      const SizedBox(width: 8),
                      Text(
                        appt["status"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: appt["status"] == "Confirmed"
                              ? Colors.green
                              : appt["status"] == "Cancelled"
                              ? Colors.red
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Confirm
                      ElevatedButton(
                        onPressed: () => confirmAppointment(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Confirm"),
                      ),

                      const SizedBox(width: 10),

                      // Cancel
                      ElevatedButton(
                        onPressed: () => cancelAppointment(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}