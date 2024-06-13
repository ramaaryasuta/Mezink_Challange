import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/data_service.dart';

class FilterDropdown extends StatefulWidget {
  const FilterDropdown({super.key});

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataServices>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value.filter,
              items: <String>['All', 'Influencer', 'New Commer']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  value.setFilter(newValue ?? 'All');
                  value.usersListFilter();
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              dropdownColor: Colors.white,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
