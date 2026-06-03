import 'package:flutter/material.dart';
import '../widgets/app_list.dart';
import '../widgets/geek_search_bar.dart';
import '../widgets/status_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _MenuButton(label: 'File'),
                    _MenuButton(label: 'Action'),
                    _MenuButton(label: 'View'),
                    _MenuButton(label: 'Help'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: const Column(
        children: [
          Expanded(child: AppList()),
          GeekSearchBar(),
          GeekStatusBar(),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String label;
  const _MenuButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {},
        child: Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 13),
        ),
      ),
    );
  }
}
