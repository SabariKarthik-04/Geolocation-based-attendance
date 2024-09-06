import 'package:flutter/material.dart';
import 'package:flutter_application_1/model.dart';

class Timesheet extends StatefulWidget {
  final MyData data;
  const Timesheet({super.key, required this.data});

  @override
  State<Timesheet> createState() => _TimesheetState();
}

class _TimesheetState extends State<Timesheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Timesheet',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 77, 79, 79),
        leading: Container(),
        leadingWidth: 12,
        elevation: 6,
        shadowColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date Row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Date: 2024-09-06',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.0),
            // Actual Table
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    // Headers Row
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Header 1',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Header 2',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    // Data Rows
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Row 1, Col 1'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Row 1, Col 2'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Row 2, Col 1'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Row 2, Col 2'),
                        ),
                      ],
                    ),
                    // Add more rows as needed
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
