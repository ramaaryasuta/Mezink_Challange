import 'package:flutter/material.dart';
import 'package:mezink_challange/widgets/drop_down.dart';
import 'package:provider/provider.dart';

import '../services/data_service.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({
    super.key,
  });

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      context.read<DataServices>().searchQuery(value);
                    });
                  },
                  controller: searchController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const FilterDropdown(),
            ],
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                /// refresh user data by calling getUserData function
                setState(() {
                  context.read<DataServices>().getUserData();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Data Refreshed'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Refresh'),
            ),
          )
        ],
      ),
    );
  }
}
