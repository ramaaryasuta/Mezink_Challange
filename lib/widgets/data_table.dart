import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:mezink_challange/services/data_service.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class MyDataTable extends StatefulWidget {
  final List<UserModel> userLists;

  const MyDataTable({super.key, required this.userLists});

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataServices>(
      builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DataTable2(
            sortColumnIndex: context.watch<DataServices>().sortColumnIndex,
            sortAscending: context.watch<DataServices>().sortAscending,
            columnSpacing: 12,
            horizontalMargin: 10,
            minWidth: 700,
            columns: [
              DataColumn(
                label: const Text(
                  'Full Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onSort: (columnIndex, ascending) {
                  context.read<DataServices>().sort(
                        (user) => user.firstName,
                        columnIndex,
                        ascending,
                      );
                },
              ),
              DataColumn(
                label: const Text(
                  'Role',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onSort: (columnIndex, ascending) {
                  context.read<DataServices>().sort(
                        (user) => user.role!,
                        columnIndex,
                        ascending,
                      );
                },
              ),
              DataColumn(
                label: const Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onSort: (columnIndex, ascending) {
                  context.read<DataServices>().sort(
                        (user) => user.email,
                        columnIndex,
                        ascending,
                      );
                },
              ),
              DataColumn(
                label: const Text(
                  'Username',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onSort: (columnIndex, ascending) {
                  context.read<DataServices>().sort(
                        (user) => user.lastName,
                        columnIndex,
                        ascending,
                      );
                },
              ),
              const DataColumn(
                label: Text(
                  'Action',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: [
              for (UserModel user in widget.userLists)
                _DataSource([user]).getRow(0)!
            ],
          ),
        );
      },
    );
  }
}

class _DataSource extends DataTableSource {
  final List<UserModel> _users;

  _DataSource(this._users);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _users.length) return null;
    final user = _users[index];
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(user.avatarImg),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text('${user.firstName} ${user.lastName}',
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
        DataCell(Text(user.role!)),
        DataCell(
            Text(user.email, maxLines: 1, overflow: TextOverflow.ellipsis)),
        DataCell(Text('${user.lastName}${user.id}')),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  int get rowCount => _users.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
