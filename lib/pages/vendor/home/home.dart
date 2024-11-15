import 'package:flutter/material.dart';
import 'package:wave_odc/pages/vendor/home/widgets/my_app_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          const Text("test"),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/client/home',
                  (route) => false,
                );
              },
              child: const Text("Mon Bouton")),
        ],
      ),
    );
  }
}
