import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods {
  // ---------- create a new employee ---------- //
  // Check is the user already exists by checking his usernam & email
  // display a snackbar showing an error
  Future addEmployeeDetails(
    Map<String, dynamic> employeeInfoMap,
    String id,
    BuildContext context,
  ) async {
    // create collection named 'employee'
    // add new employee

    // extract Email from employeeInfoMap
    // print(employeeInfoMap['Email']);

    try {
      // check wether username is already used
      QuerySnapshot checkUsernameSnapshot = await FirebaseFirestore.instance
          .collection('employee')
          .where('Username', isEqualTo: employeeInfoMap['Username'])
          .get();

      // check wether email is already used
      QuerySnapshot checkEmailSnapshot = await FirebaseFirestore.instance
          .collection('employee')
          .where('Email', isEqualTo: employeeInfoMap['Email'])
          .get();

      // check wether username & email is already used
      if (checkUsernameSnapshot.docs.isNotEmpty ||
          checkEmailSnapshot.docs.isNotEmpty) {
        // if username already exists
        if (checkUsernameSnapshot.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Username already exists. Please use an unique username.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        } else {
          // if email already exists
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Email already exists. Please use an unique email id.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }
      } else {
        // show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Added successfully!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );

        // add new employee in firestore
        return await FirebaseFirestore.instance
            .collection('employee')
            .doc(id)
            .set(employeeInfoMap);
      }
    } catch (e) {
      // display error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Oops! Some error occurred!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }

  // edit employee details
  Future updateDetails(String docId, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection('employee')
        .doc(docId)
        .update(updateInfo);
  }

  // delete employee details
  Future deleteDetails(String docId) async {
    return await FirebaseFirestore.instance
        .collection('employee')
        .doc(docId)
        .delete();
  }
}
