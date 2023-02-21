// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan),
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? studentName, studentID, studyProgramID;
  double? studentGPA;
  CollectionReference colref =
      FirebaseFirestore.instance.collection('MyStudents');

  setStudentName(String name) {
    this.studentName = name;
  }

  String getStudentName() {
    String? res = studentName;
    if (res == null || res == "") {
      res = "No data";
    }
    return res;
  }

  setStudentID(String id) {
    this.studentID = id;
  }

  setStudyProgramID(String programID) {
    this.studyProgramID = programID;
  }

  setStudentGPA(String gpa) {
    this.studentGPA = double.parse(gpa);
  }

  createData() {
    print("Create");

    Map<String, dynamic> students_map = {
      "studentName": studentName,
      "studentID": studentID,
      "studentGPA": studentGPA,
      "studyProgramID": studyProgramID
    };

    colref
        .add(students_map)
        .then((value) => print("User added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  readData() async {
    print("Reads");
    await colref.get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  updateData() {
    print("Update");
    Map<String, dynamic> students_map = {
      "studentName": studentName,
      "studentID": studentID,
      "studentGPA": studentGPA,
      "studyProgramID": studyProgramID
    };
    colref.where("studentName", isEqualTo: "QukHtPdCzYzfiookf9Hv").get();
    colref
        .doc("John Cena")
        .set(students_map)
        .then((value) => print("User updated"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  deleteData() {
    print("Delete");
    colref.doc("John Cena").delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Airbase inc."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Student Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String name) {
                  setStudentName(name);
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Student ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String id) {
                  setStudentID(id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Course Code",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String programID) {
                  setStudyProgramID(programID);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "GPA",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String gpa) {
                  setStudentGPA(gpa);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      createData();
                    },
                    child: Text("Create")),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      readData();
                    },
                    child: Text("Read")),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.yellow)),
                    onPressed: () {
                      updateData();
                    },
                    child: Text("Update")),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () {
                      deleteData();
                    },
                    child: Text("Delete")),
              ],
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Text(getStudentName()),
                Text('Domestic life was never quite my style'),
                Text('When you smile, you knock me out, I fall apart'),
                Text('And I thought I was so smart'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
