import 'package:flutter/material.dart';
import 'package:wave_odc/pages/client/layouts/layout.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientLayout(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("test")
          ],
        ),
      ),
    );
  }
}
