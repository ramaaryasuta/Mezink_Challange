import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/data_service.dart';

class PaginationButtonWidget extends StatelessWidget {
  const PaginationButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DataServices>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            value.pages > 1
                ? IconButton(
                    onPressed: () {
                      context.read<DataServices>().previousPage();
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                  )
                : const SizedBox(width: 30),
            const SizedBox(width: 10),
            Text('Page ${value.pages.toString()}'),
            const SizedBox(width: 10),
            value.pages < value.maxPage
                ? IconButton(
                    onPressed: () {
                      context.read<DataServices>().nextPage();
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                  )
                : const SizedBox(width: 30),
          ],
        );
      },
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     context.read<DataServices>().pages > 1
    //         ? IconButton(
    //             onPressed: () {
    //               context.read<DataServices>().previousPage();
    //             },
    //             icon: const Icon(Icons.arrow_back_ios_rounded),
    //           )
    //         : const SizedBox(width: 30),
    //     const SizedBox(width: 10),
    //     Text('Page ${context.read<DataServices>().pages.toString()}'),
    //     const SizedBox(width: 10),

    //          IconButton(
    //             onPressed: () {
    //               context.read<DataServices>().nextPage();
    //             },
    //             icon: const Icon(Icons.arrow_forward_ios_rounded),
    //           )

    //   ],
    // );
  }
}
