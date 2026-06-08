import 'package:flutter/material.dart';
import 'records_page.dart';

class DoctorMedicalRecords extends StatefulWidget {
  const DoctorMedicalRecords({super.key});

  @override
  State<DoctorMedicalRecords> createState() => _DoctorMedicalRecordsState();
}

class _DoctorMedicalRecordsState extends State<DoctorMedicalRecords> {
  List<Map<String, dynamic>> patients = [];
  List<Map<String, dynamic>> filteredPatients = [];

  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final searchCtrl = TextEditingController();

  String gender = "Male";

  @override
  void initState() {
    super.initState();
    filteredPatients = patients;
  }

  void addPatient() {
    if (nameCtrl.text.isEmpty || ageCtrl.text.isEmpty) return;

    setState(() {
      final newPatient = {
        "name": nameCtrl.text,
        "age": ageCtrl.text,
        "gender": gender,
        "records": [],
      };

      patients.insert(0, newPatient);
      filteredPatients = patients;

      nameCtrl.clear();
      ageCtrl.clear();
      gender = "Male";
    });
  }

  void searchPatient(String query) {
    final results = patients.where((patient) {
      final name = patient["name"].toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredPatients = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0F0C0),

      appBar: AppBar(
        title: Text(
          "Medical Records",
          style: TextStyle(color: Colors.teal.shade900),
        ),
        backgroundColor: const Color(0xFFCDE7E6),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // 🟢 ADD PATIENT
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFCFEED1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF7AB8A6)),
              ),
              child: Column(
                children: [

                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: "Patient Name",
                    ),
                  ),

                  TextField(
                    controller: ageCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Age",
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Text("Gender: "),
                      DropdownButton<String>(
                        value: gender,
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("Male")),
                          DropdownMenuItem(value: "Female", child: Text("Female")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: addPatient,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade700,
                    ),
                    child: const Text("Add Patient"),
                  ),
                ],
              ),
            ),
          ),

          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: searchCtrl,
              onChanged: searchPatient,
              decoration: InputDecoration(
                hintText: "Search patient by name...",
                prefixIcon: Icon(Icons.search, color: Colors.teal.shade700),
                filled: true,
                fillColor: const Color(0xFFCFEED1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: const Color(0xFF7AB8A6)),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 🟡 LIST
          Expanded(
            child: filteredPatients.isEmpty
                ? Center(
              child: Text(
                "No patients found",
                style: TextStyle(color: Colors.teal.shade700),
              ),
            )
                : ListView.builder(
              itemCount: filteredPatients.length,
              itemBuilder: (context, index) {
                final patient = filteredPatients[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCFEED1),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFF7AB8A6)),
                  ),

                  child: ListTile(
                    leading: Icon(Icons.person,
                        color: Colors.teal.shade700),

                    title: Text(
                      patient["name"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      ),
                    ),

                    subtitle: Text(
                      "Age: ${patient["age"]} | Gender: ${patient["gender"]}",
                    ),

                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Colors.teal.shade700),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecordsPage(
                            patient: patient,
                            onUpdate: (updated) {
                              setState(() {
                                final originalIndex =
                                patients.indexOf(patient);
                                patients[originalIndex] = updated;
                                filteredPatients = patients;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}