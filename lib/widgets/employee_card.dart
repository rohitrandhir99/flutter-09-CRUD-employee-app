import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.data,
    required this.onTap,
    required this.onDel,
  });

  final Map<String, dynamic> data;
  final VoidCallback onTap;
  final VoidCallback onDel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Name: ",
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data['Name']}",
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Age: ",
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data['Age']}",
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Email: ",
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data['Email']}",
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Username: ",
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data['Username']}",
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Location: ",
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data['Location']}",
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onTap,
                icon: Icon(
                  Icons.edit,
                  color: Colors.yellow.shade800,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onDel,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
