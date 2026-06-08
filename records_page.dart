import 'package:flutter/material.dart';

class RecordsPage extends StatefulWidget {
  final Map<String, dynamic> patient;
  final Function(Map<String, dynamic>) onUpdate;

  const RecordsPage({
    super.key,
    required this.patient,
    required this.onUpdate,
  });

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  late Map<String, dynamic> patient;

  @override
  void initState() {
    super.initState();
    patient = Map<String, dynamic>.from(widget.patient);
  }


  Future<void> addRecord() async {
    TextEditingController diagnosisCtrl = TextEditingController();
    TextEditingController notesCtrl = TextEditingController();
    TextEditingController medCtrl = TextEditingController();
    TextEditingController followUpCtrl = TextEditingController();

    List<String> meds = [];

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFCFEED1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            "Add Medical Record",
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: diagnosisCtrl,
                      decoration: InputDecoration(
                        labelText: "Diagnosis",
                        labelStyle: TextStyle(color: Colors.teal.shade700),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: notesCtrl,
                      decoration: InputDecoration(
                        labelText: "Notes",
                        labelStyle: TextStyle(color: Colors.teal.shade700),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 2,
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: followUpCtrl,
                      decoration: InputDecoration(
                        labelText: "Follow-up Date",
                        labelStyle: TextStyle(color: Colors.teal.shade700),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: medCtrl,
                            decoration: InputDecoration(
                              labelText: "Medication",
                              labelStyle: TextStyle(color: Colors.teal.shade700),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),IconButton(
                          icon: Icon(Icons.add_circle,
                              color: Colors.teal.shade700, size: 32),
                          onPressed: () {
                            if (medCtrl.text.isNotEmpty) {
                              setStateDialog(() {
                                meds.add(medCtrl.text);
                                medCtrl.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    if (meds.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 80,
                        child: ListView(
                          children: meds
                              .map((m) => Text("- $m",
                              style: TextStyle(
                                  color: Colors.teal.shade800,
                                  fontSize: 14)))
                              .toList(),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child:
              Text("Cancel", style: TextStyle(color: Colors.red.shade400)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  patient["records"].add({
                    "diagnosis": diagnosisCtrl.text,
                    "notes": notesCtrl.text,
                    "medications": meds,
                    "date": DateTime.now().toString().split(' ').first,
                    "followUp": followUpCtrl.text,
                  });
                });

                widget.onUpdate(patient);
                Navigator.pop(dialogContext);
              },
              style:
              ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade700),
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }


  Future<void> editRecord(int recordIndex) async {
    final record = patient["records"][recordIndex];

    TextEditingController diagnosisCtrl =
    TextEditingController(text: record["diagnosis"]);
    TextEditingController notesCtrl =
    TextEditingController(text: record["notes"]);
    TextEditingController followUpCtrl =
    TextEditingController(text: record["followUp"] ?? "");
    TextEditingController medCtrl = TextEditingController();

    List<String> meds = List<String>.from(record["medications"] ?? []);

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFCFEED1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            "Edit Medical Record",
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: diagnosisCtrl,
                      decoration: InputDecoration(labelText: "Diagnosis",
                        labelStyle: TextStyle(color: Colors.teal.shade700),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: notesCtrl,
                      decoration: InputDecoration(
                        labelText: "Notes",
                        labelStyle: TextStyle(color: Colors.teal.shade700),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 2,
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: followUpCtrl,
                      decoration: InputDecoration(
                        labelText: "Follow-up Date",
                        labelStyle: TextStyle(color: Colors.teal.shade700),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: medCtrl,
                            decoration: InputDecoration(
                              labelText: "Add Medication",
                              labelStyle: TextStyle(color: Colors.teal.shade700),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.add_circle,
                              color: Colors.teal.shade700, size: 32),
                          onPressed: () {
                            if (medCtrl.text.isNotEmpty) {
                              setStateDialog(() {
                                meds.add(medCtrl.text);
                                medCtrl.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    if (meds.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 100,
                        child: ListView.builder(
                          itemCount: meds.length,
                          itemBuilder: (context, i) {
                            return Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text("- ${meds[i]}",
                                    style: TextStyle(
                                        color: Colors.teal.shade800,
                                        fontSize: 14)),
                                IconButton(
                                  icon: const Icon(Icons.close,
                                      size: 18, color: Colors.red),onPressed: () {
                                  setStateDialog(() {
                                    meds.removeAt(i);
                                  });
                                },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child:
              Text("Cancel", style: TextStyle(color: Colors.red.shade400)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  patient["records"][recordIndex] = {
                    "diagnosis": diagnosisCtrl.text,
                    "notes": notesCtrl.text,
                    "medications": meds,
                    "date": record["date"],
                    "followUp": followUpCtrl.text,
                  };
                });

                widget.onUpdate(patient);
                Navigator.pop(dialogContext);
              },
              style:
              ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade700),
              child: const Text("Save"),
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
          patient["name"],
          style: TextStyle(color: Colors.teal.shade900),
        ),
        backgroundColor: const Color(0xFFCDE7E6),
        elevation: 0,
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.shade700,
        onPressed: addRecord,
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: patient["records"].length,
        itemBuilder: (context, i) {
          final record = patient["records"][i];
          final meds = List<String>.from(record["medications"] ?? []);

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFCFEED1),
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
            child: ListTile(
              leading: Icon(
                Icons.folder_special_rounded,
                color: Colors.teal.shade700,
                size: 40,
              ),
              title: Text(
                record["diagnosis"],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade900,
                ),
              ),
              subtitle: Text(
                "${record["notes"]}\n"
                    "Medications:\n${meds.map((m) => "- $m").join("\n")}\n"
                    "Date: ${record["date"]}\n"
                    "Follow-up: ${record["followUp"] ?? "-"}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.teal.shade700,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit_rounded, color: Colors.teal.shade700),
                onPressed: () => editRecord(i),
              ),
            ),
          );
        },
      ),
    );
  }
}