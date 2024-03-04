import 'package:flutter/material.dart';
import 'package:car_app/database_helper.dart'; // Import your database helper class
import 'package:car_app/input_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<List<Map<String, dynamic>>> futureDataList;

  @override
  void initState() {
    super.initState();
    futureDataList = _getDataList();
  }

  Future<List<Map<String, dynamic>>> _getDataList() async {
    return await DatabaseHelper().queryAll('carApp');
  }

  void _deleteData(Map<String, dynamic> data) async {
    int id = data['id'];
    int result = await DatabaseHelper().delete('carApp', id);
    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data deleted'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        futureDataList = _getDataList();
      });
    } else {
      print('Failed to delete data');
    }
  }

  void _editData(Map<String, dynamic> data) async {
    // Navigate to the input page when the edit button is pressed
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InputScreen(editData: data),
      ),
    );
    // Refresh the list after editing
    setState(() {
      futureDataList = _getDataList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureDataList,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> dataList = snapshot.data!;
            return Stack(
              children: [
                ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = dataList.reversed.toList()[index];
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text('Date: ${data['date']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cost: ${data['cost']} PLN'),
                            Text('Distance: ${data['dist']} KM'),
                            Text('Fuel Economy: ${data['avg_f_com']} L/100KM'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _editData(data);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.indigo,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _deleteData(data);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 16.0,
                  right: 16.0,
                  child: FloatingActionButton(
                    onPressed: () async {
                      // Navigate to the input page when the button is pressed
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InputScreen()),
                      );
                      setState(() {
                        futureDataList = _getDataList();
                      });
                    },
                    backgroundColor: Colors.black87,
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
