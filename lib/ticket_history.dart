import 'package:flutter/material.dart';


class TicketHistory extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ticket History'),),
        body: Center(
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text('Sl no.'),
                    ),
                    DataColumn(
                      label: Text('Date and Time'),
                    ),
                    DataColumn(
                      label: Text('remark'),
                    ),
                    DataColumn(
                      label: Text('Amount'),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Data')),
                        DataCell(Text('Data')),
                        DataCell(Text('Data')),
                        DataCell(Text('Data')),
                      ],
                    ),
                    // DataRow(
                    //   cells: <DataCell>[
                    //     DataCell(Text('Data')),
                    //     DataCell(Text('Data')),
                    //     DataCell(Text('Data')),
                    //     DataCell(Text('Data')),
                    //   ],
                    //   ),
                    // DataRow(
                    //   cells: <DataCell>[
                    //     DataCell(Text('Data')),
                    //     DataCell(Text('Data')),
                    //     DataCell(Text('Data')),
                    //     DataCell(Text('Data')),
                    //   ],
                    //   ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    
  }
}
