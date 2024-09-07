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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
          const Text(
            'TimeSheet',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20,),
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
                    2:FlexColumnWidth(),
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
                            ' ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Manual Attendance',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Automated Attendance',
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
                          child: Text('Check-IN',
                            textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
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
                          child: Text('Check-OUT',textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
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
