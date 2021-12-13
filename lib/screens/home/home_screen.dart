import 'package:flutter/material.dart';

import 'widgets/main_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     final repo = context.read<OutletRepository>();

        //     print(
        //         'Place Datails --------- ${await repo.getOutletFromPlaceId(placeId: 'ChIJh09POeRBfDkR7F3OBkKju7M')}');
        //   },
        // ),
        backgroundColor: Colors.black,
        body: Column(
          children: const [
            // Top section
            //   const TopBar(),

            SizedBox(height: 30.0),

            Expanded(child: MainContentLayout()),

            // const BottomToolbar(),
          ],
        ),
      ),
    );
  }
}
