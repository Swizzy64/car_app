import 'package:flutter/material.dart';
import 'package:car_app/database_helper.dart'; // Import your database helper class

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late Future<List<Map<String, dynamic>>> futureDataList;
  late Future<List<Map<String, dynamic>>> futureDataList2;

  @override
  void initState() {
    super.initState();
    futureDataList = _getDatas('carApp');
    futureDataList2 = _getDatas('carApp2');
  }

  Future<List<Map<String, dynamic>>> _getDatas(String tableName) async {
    return await DatabaseHelper().queryAll(tableName);
  }

  Color getTotalCostColor(double value) {
    if (value <= 1000.0) {
      return Colors.green;
    }
    else if (value > 1000.0 && value <= 3000.0) {
      return Colors.orange;
    }
    else {
      return Colors.red;
    }
  }

  Color getFuelEconomyColor(double value) {
    if (value <= 6.0) {
      return Colors.green;
    }
    else if (value > 6.0 && value <= 12) {
      return Colors.orange;
    }
    else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder(
        future: futureDataList,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> dataList = snapshot.data!;
            return FutureBuilder(
                future: futureDataList2,
                builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot2.hasError) {
                    return Text('Error: ${snapshot2.error}');
                  } else {
                    List<Map<String, dynamic>> dataList2 = snapshot2.data!;

                    // Calculate averages and other statistics
                    int numberOfEntries = dataList.length;
                    int numberOfEntries2 = dataList2.length;
                    double totalCost = dataList.fold(0.0, (sum, data) => sum + (data['cost'] ?? 0.0));
                    double totalCost2 = dataList2.fold(0.0, (sum, data) => sum + (data['cost'] ?? 0.0));
                    double totalTotalCost = totalCost + totalCost2;
                    double totalDist = dataList.fold(0.0, (sum, data) => sum + (data['dist'] ?? 0.0));
                    double totalFuel = dataList.fold(0.0, (sum, data) => sum + (data['fuel'] ?? 0.0));
                    double totalFuelEconomy =
                    dataList.fold(0.0, (sum, data) => sum + (data['avg_f_com'] ?? 0.0));

                    double averageCost = numberOfEntries > 0 ? totalCost / numberOfEntries : 0.0;
                    double averageCost2 = numberOfEntries2 > 0 ? totalCost2 / numberOfEntries2 : 0.0;
                    double averageDist = numberOfEntries > 0 ? totalDist / numberOfEntries : 0.0;
                    double averageFuel = numberOfEntries > 0 ? totalFuel / numberOfEntries : 0.0;
                    double averageFuelEconomy =
                    numberOfEntries > 0 ? totalFuelEconomy / numberOfEntries : 0.0;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bar with number of entries
                        Card(
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Container(
                            height: 50.0, // Adjust the height as needed
                            child: Center(
                              child: Text(
                                'Number of fuelling entries: $numberOfEntries',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        // Two boxes with average cost and total cost
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 5.0,
                                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: Container(
                                  height: 100.0, // Adjust the height as needed
                                  child: Center(
                                    child: Text(
                                      'Average fuelling cost\n$averageCost PLN',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                elevation: 5.0,
                                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                color: getTotalCostColor(totalCost),
                                child: Container(
                                  height: 100.0, // Adjust the height as needed
                                  child: Center(
                                    child: Text(
                                      'Total fuelling cost\n$totalCost PLN',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 5.0,
                                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: Container(
                                  height: 100.0, // Adjust the height as needed
                                  child: Center(
                                    child: Text(
                                      'Average mainteneance cost\n$averageCost2 PLN',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                elevation: 5.0,
                                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: Container(
                                  height: 100.0, // Adjust the height as needed
                                  child: Center(
                                    child: Text(
                                      'Total maintenance cost\n$totalCost2 PLN',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Card(
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Container(
                            height: 50.0, // Adjust the height as needed
                            child: Center(
                              child: Text(
                                'Total cost (fuelling + maintenance): $totalTotalCost',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        // Two boxes with average distance and total distance
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 5.0,
                                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: Container(
                                  height: 100.0, // Adjust the height as needed
                                  child: Center(
                                    child: Text(
                                      'Average Distance\n$averageDist KM',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                elevation: 5.0,
                                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: Container(
                                  height: 100.0, // Adjust the height as needed
                                  child: Center(
                                    child: Text(
                                      'Total Distance\n$totalDist KM',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Two boxes with average fuel and total fuel
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 5.0,
                                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: Container(
                                  height: 100.0, // Adjust the height as needed
                                  child: Center(
                                    child: Text(
                                      'Average Fuel\n$averageFuel L',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                elevation: 5.0,
                                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: Container(
                                  height: 100.0, // Adjust the height as needed
                                  child: Center(
                                    child: Text(
                                      'Total Fuel\n$totalFuel L',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Bar with average fuel economy
                        Card(
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          color: getFuelEconomyColor(averageFuelEconomy),
                          child: Container(
                            height: 50.0, // Adjust the height as needed
                            child: Center(
                              child: Text(
                                'Average Fuel Economy: $averageFuelEconomy L/100KM',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
            );
          }
        },
      ),
    );
  }
}
