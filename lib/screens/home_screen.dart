import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_app/screens/employee_screen.dart';
import 'package:employee_app/services/database.dart';
import 'package:employee_app/widgets/employee_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // textediting controller
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // fetching employee details from cloud firestore
  final Stream<QuerySnapshot> employee =
      FirebaseFirestore.instance.collection('employee').snapshots();

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Employee",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 5.0),
            Text(
              "App",
              style: TextStyle(
                color: Colors.yellow.shade900,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: employee,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              // data
              Map<String, dynamic> data =
                  snapshot.data!.docs[index].data()! as Map<String, dynamic>;

              return EmployeeCard(
                data: data,
                onTap: () {
                  // display the information already present
                  // inside the textfields
                  nameController.text = data['Name'];
                  ageController.text = data['Age'];
                  locationController.text = data['Location'];

                  // edit employee details wrt Id
                  editEmployeeDetails(data['Id']);
                },
                onDel: () {
                  // delete employee

                  // show alert dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete Employee?'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                'This will delete the overall information of this employee permanently.',
                              ),
                              Text(
                                'Would you like to delete it?',
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                              ),
                            ),
                            onPressed: () async {
                              // delete employee wrt id
                              await DatabaseMethods()
                                  .deleteDetails(data["Id"])
                                  .then((value) {
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigate to employee screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmployeeScreen(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ), //
    );
  }

  // edit details
  Future editEmployeeDetails(String id) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 5.0),
                Text(
                  "Details",
                  style: TextStyle(
                    color: Colors.yellow.shade900,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Text(
              "Name",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Add your name!";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            const SizedBox(height: 18.0),
            Text(
              "Age",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: ageController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Add your age!";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            const SizedBox(height: 18.0),
            Text(
              "Location",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: locationController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Add your location!";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12.0),
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  // update details wrt id
                  Map<String, dynamic> updateInfo = {
                    "Id": id,
                    "Name": nameController.text,
                    "Age": ageController.text,
                    "Location": locationController.text,
                  };

                  await DatabaseMethods()
                      .updateDetails(id, updateInfo)
                      .then((value) {
                    Navigator.pop(context);
                  });
                },
                child: const Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12.0),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

We can also use ListView instead of ListView.builder

children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                // data
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                return EmployeeCard(data: data);
              },
            ).toList(),

 */
