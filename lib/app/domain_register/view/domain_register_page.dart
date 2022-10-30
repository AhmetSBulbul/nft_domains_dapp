import 'package:flutter/material.dart';

class DomainRegisterPage extends StatelessWidget {
  const DomainRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Domain Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Expanded(
                child: Center(child: Text("Feed")),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TextField(
                      decoration: InputDecoration(
                    labelText: "Domain Name",
                  )),
                  const SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    child: const Text("Register"),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
