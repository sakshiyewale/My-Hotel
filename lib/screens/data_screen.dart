import 'package:flutter/material.dart';

class TableDetailsScreen extends StatelessWidget {
  final String tableName;

  const TableDetailsScreen({Key? key, required this.tableName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Details'),
      ),
      body: Center(
        child: Text(
          'Details for $tableName',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
