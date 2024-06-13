import 'package:flutter/material.dart';
import 'package:mezink_challange/services/data_service.dart';
import 'package:provider/provider.dart';

import '../widgets/filter_section.dart';
import '../widgets/mytable.dart';
import '../widgets/paginate_button.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  void initState() {
    context.read<DataServices>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Influencer Repository',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Column(
        children: [
          FilterSection(),
          MyTableData(),
          PaginationButtonWidget(),
        ],
      ),
    );
  }
}
