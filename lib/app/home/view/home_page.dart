import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const Center(
        child: Text("Home"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(children: [
          const Expanded(
            child: SizedBox(),
          ),
          ElevatedButton(
            onPressed: () => context.go("/domain_register"),
            child: const Icon(Icons.add),
          )
        ]),
      ),
    );
  }
}
