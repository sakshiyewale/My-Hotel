import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class KOTScreen extends StatefulWidget {
  final Map<dynamic, int> selectedItems; // Accept selected items and quantities

  const KOTScreen({Key? key, required this.selectedItems}) : super(key: key);

  @override
  State<KOTScreen> createState() => _KOTScreenState();
}

class _KOTScreenState extends State<KOTScreen> {
  late String currentDate;
  late String currentTime;
  String? selectedTable;
  String? selectedSection;
  Map<String, int> savedSelectedItems = {};

  @override
  void initState() {
    super.initState();
    _saveSelectedItems();
    _updateCurrentDateTime();
    _loadSelectedTable();
    _loadSelectedSection();
    _loadSelectedItems();
  }

  void _updateCurrentDateTime() {
    final DateTime now = DateTime.now();
    currentDate = "${now.day}-${now.month}-${now.year}";
    currentTime = "${now.hour}:${now.minute}:${now.second}";
  }

  Future<void> _saveSelectedItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, int> stringifiedMap = widget.selectedItems.map((key, value) => MapEntry(key['name'], value));
    prefs.setString('selectedItems', jsonEncode(stringifiedMap));
  }

  Future<void> _loadSelectedItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedItems = prefs.getString('selectedItems');
    if (savedItems != null) {
      setState(() {
        savedSelectedItems = Map<String, int>.from(jsonDecode(savedItems));
      });
    }
  }

  Future<void> _loadSelectedTable() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedTable = prefs.getString('selectedTableName');
    });
  }

  Future<void> _loadSelectedSection() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedSection = prefs.getString('selectedSection');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KOT Screen'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (selectedSection != null) ...[
              Text(
                'Section: $selectedSection',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
            ],
            if (selectedTable != null) ...[
              Text(
                'Selected Table: $selectedTable',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Date: $currentDate',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Current Time: $currentTime',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Sr", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Items", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: savedSelectedItems.length,
                itemBuilder: (context, index) {
                  var menuItemName = savedSelectedItems.keys.elementAt(index);
                  var quantity = savedSelectedItems[menuItemName];
                  return Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text((index + 1).toString()),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                menuItemName,
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$quantity'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
