import 'package:flutter/material.dart';
import 'package:mezink_challange/services/data_service.dart';
import 'package:provider/provider.dart';

import 'data_table.dart';

class MyTableData extends StatelessWidget {
  const MyTableData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// checking list condition
    if (context.watch<DataServices>().dropFilterList.isNotEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: MyDataTable(
          userLists: context.watch<DataServices>().dropFilterList,
        ),
      );
    } else if (context.watch<DataServices>().filteredList.isNotEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: MyDataTable(
          userLists: context.watch<DataServices>().filteredList,
        ),
      );
    } else if (context.watch<DataServices>().filteredList.isEmpty &&
        context.watch<DataServices>().query.isNotEmpty) {
      return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sentiment_dissatisfied, size: 80),
              SizedBox(height: 10),
              Text(
                'Data not found',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: MyDataTable(
          userLists: context.watch<DataServices>().usersList,
        ),
      );
    }
  }
}
