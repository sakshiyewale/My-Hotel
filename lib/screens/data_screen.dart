import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedItemScreen extends StatefulWidget {
  const SelectedItemScreen({super.key});

  @override
  State<SelectedItemScreen> createState() => _SelectedItemScreenState();
}

class _SelectedItemScreenState extends State<SelectedItemScreen> {
  String? selectedItem;
  String? selectedItem1;

  @override
  void initState() {
    super.initState();
    _loadSelectedItems();
  }

  Future<void> _loadSelectedItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedItem = prefs.getString('selectedItem');
      selectedItem1 = prefs.getString('selectedItem1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Items'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Item: $selectedItem',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Selected Item 1: $selectedItem1',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
