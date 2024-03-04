import 'package:flutter/material.dart';
import 'package:car_app/database_helper.dart'; // Import your database helper class
import 'package:intl/intl.dart';

class InputScreen extends StatefulWidget {
  final Map<String, dynamic>? editData;

  InputScreen({Key? key, this.editData}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  late TextEditingController distController = TextEditingController();
  late TextEditingController costController = TextEditingController();
  late TextEditingController fuelController = TextEditingController();
  late TextEditingController dateController = TextEditingController();
  late String buttonText;

  @override
  void initState() {
    super.initState();

    distController = TextEditingController(
        text: widget.editData != null
            ? widget.editData!['dist'].toString()
            : '');
    fuelController = TextEditingController(
        text: widget.editData != null
            ? widget.editData!['fuel'].toString()
            : '');
    costController = TextEditingController(
        text: widget.editData != null
            ? widget.editData!['cost'].toString()
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
        title: Text('Input fuelling data'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            TextField(
              controller: distController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Distance'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: fuelController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Fuel'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Cost'),
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
    double dist = double.parse(distController.text);
    double cost = double.parse(costController.text);
    double fuel = double.parse(fuelController.text);

    String date = dateController.text.isEmpty
        ? DateFormat('dd.MM.yyyy').format(DateTime.now().toLocal())
        : dateController.text;

    double avgFCom = fuel / (dist / 100);
    avgFCom = double.parse(avgFCom.toStringAsFixed(2)); // Convert to string for rounding
    avgFCom = double.parse(avgFCom.toString()); // Convert back to double

    Map<String, dynamic> row = {
      'dist': dist,
      'fuel': fuel,
      'cost': cost,
      'avg_f_com': avgFCom,
      'date': date,
    };

    if (widget.editData != null) {
      row['id'] = widget.editData!['id'];
      int updateResult = await DatabaseHelper().update('carApp', row);
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
      int insertResult = await DatabaseHelper().insert('carApp', row);
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
