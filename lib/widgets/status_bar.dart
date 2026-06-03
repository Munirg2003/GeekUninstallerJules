import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_service.dart';

class GeekStatusBar extends StatelessWidget {
  const GeekStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<AppService>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        color: Colors.grey.shade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${service.totalCount} programs of ${service.totalSize} size in total',
            style: const TextStyle(fontSize: 12),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 14),
                SizedBox(width: 4),
                Text(
                  'Upgrade to PRO version',
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
