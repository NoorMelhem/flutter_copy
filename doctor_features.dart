import 'package:flutter/material.dart';

class DoctorFeatures extends StatefulWidget {
  const DoctorFeatures({super.key});

  @override
  State<DoctorFeatures> createState() => _DoctorFeaturesState();
}

class _DoctorFeaturesState extends State<DoctorFeatures> {

  List<Map<String, dynamic>> features = [
    {"title": "Feature Title", "description": "Feature Description"},
  ];


  Future<void> addFeature() async {
    String title = "";
    String description = "";

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Feature"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Feature Title"),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Description"),
                onChanged: (value) => description = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    features.add({
                      "title": title,
                      "description": description,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }


  Future<void> editFeature(int index) async {
    String title = features[index]["title"];
    String description = features[index]["description"];

    TextEditingController titleController =
    TextEditingController(text: title);
    TextEditingController descriptionController =
    TextEditingController(text: description);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Feature"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Feature Title"),
                onChanged: (value) => title = value,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                onChanged: (value) => description = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  features[index]["title"] = title;
                  features[index]["description"] = description;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }


  Future<void> deleteFeature(int index) async {
    setState(() {
      features.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0F0C0), // Tea Green

      appBar: AppBar(
        title: Text(
          "Doctor Features",
          style: TextStyle(color: Colors.teal.shade900),
        ),
        backgroundColor: const Color(0xFFCDE7E6), // Tea Blue
        elevation: 0,
        centerTitle: true,
      ),floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.teal.shade700,
      onPressed: addFeature,
      child: const Icon(Icons.add, color: Colors.white),
    ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: features.isEmpty
            ? Center(
          child: Text(
            "No features added yet",
            style: TextStyle(
              fontSize: 18,
              color: Colors.teal.shade800,
            ),
          ),
        )
            : ListView.builder(
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
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
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),

                leading: Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.teal.shade700,
                  size: 40,
                ),

                title: Text(
                  feature["title"],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                  ),
                ),

                subtitle: Text(
                  feature["description"],
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.teal.shade700,
                  ),
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_rounded,
                        color: Colors.teal.shade600,
                      ),
                      onPressed: () => editFeature(index),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      ),
                      onPressed: () => deleteFeature(index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}