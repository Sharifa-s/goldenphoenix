import 'package:flutter/material.dart';
import 'package:goldenphoenix/Router/TabNavigatorRoutes.dart';
import 'package:goldenphoenix/Screens/Home/dataBridge.dart';
import 'package:provider/provider.dart';

class PagesMenu extends StatelessWidget {
  const PagesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return DataBridge();
      },
      child: MaterialApp.router(
        routerConfig: AppNavigation.router,
      ),
    );
  }
}
