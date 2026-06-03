import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_service.dart';

class GeekSearchBar extends StatelessWidget {
  const GeekSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.read<AppService>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: TextField(
        onChanged: service.setSearchQuery,
        decoration: const InputDecoration(
          hintText: 'Type to find a program',
          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          isDense: true,
        ),
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}
