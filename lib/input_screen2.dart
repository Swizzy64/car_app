import 'package:flutter/material.dart';
import 'package:car_app/database_helper.dart'; // Import your database helper class
import 'package:intl/intl.dart';

class InputScreen2 extends StatefulWidget {
  final Map<String, dynamic>? editData;

  InputScreen2({Key? key, this.editData}) : super(key: key);

  @override
  _InputScreenState2 createState() => _InputScreenState2();
}

class _InputScreenState2 extends State<InputScreen2> {
  late TextEditingController costController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController dateController = TextEditingController();
  late String buttonText;

  @override
  void initState() {
    super.initState();

    costController = TextEditingController(
        text: widget.editData != null
            ? widget.editData!['cost'].toString()
            : '');
    descriptionController = TextEditingController(
        text: widget.editData != null
            ? widget.editData!['description'].toString()
            : '');
    dateController = TextEditingController(
        text: widget.editData != null
            ? widget.editData!['date'].toString()
            : '');
    buttonText = widget.editData != null ? 'Edit' : 'Save';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input maintenance data'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Cost'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date (Optional: DD-MM-YYYY)'),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _insertData();
                },
                child: Text(buttonText),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _insertData() async {
    double cost = double.parse(costController.text);
    String description = descriptionController.text;

    String date = dateController.text.isEmpty
        ? DateFormat('dd-MM-yyyy').format(DateTime.now().toLocal())
        : dateController.text;

    Map<String, dynamic> row = {
      'cost': cost,
      'description': description,
      'date': date,
    };

    if (widget.editData != null) {
      row['id'] = widget.editData!['id'];
      int updateResult = await DatabaseHelper().update('carApp2', row);
      if (updateResult != 0) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data updated'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.blue,
          ),
        );
      } else {
        print('Failed to update data');
      }
    } else {
      int insertResult = await DatabaseHelper().insert('carApp2', row);
      if (insertResult != 0) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data added'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green[300],
          ),
        );
      } else {
        print('Failed to insert data');
      }
    }
  }

}
