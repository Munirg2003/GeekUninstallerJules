import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_service.dart';
import '../models/app_info.dart';

class AppList extends StatefulWidget {
  const AppList({super.key});

  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    final service = context.watch<AppService>();
    final apps = service.apps;

    return Column(
      children: [
        Container(
          color: Colors.white,
          child: const Row(
            children: [
              _HeaderCell(label: 'Program Name', flex: 3),
              _HeaderCell(label: 'Size', width: 100),
              _HeaderCell(label: 'Installed On', width: 120),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];
                return _AppRow(
                  app: app,
                  isSelected: _selectedId == app.id,
                  isProcessing: service.currentlyProcessingId == app.id,
                  status: service.status,
                  onTap: () => setState(() => _selectedId = app.id),
                  onUninstall: () => service.uninstallApp(app.id),
                  onForceRemove: () => service.forceRemoveApp(app.id),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final int? flex;
  final double? width;

  const _HeaderCell({required this.label, this.flex, this.width});

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
      ),
    );

    if (width != null) {
      return SizedBox(width: width, child: child);
    }
    return Expanded(flex: flex!, child: child);
  }
}

class _AppRow extends StatelessWidget {
  final AppInfo app;
  final bool isSelected;
  final bool isProcessing;
  final UninstallStatus status;
  final VoidCallback onTap;
  final VoidCallback onUninstall;
  final VoidCallback onForceRemove;

  const _AppRow({
    required this.app,
    required this.isSelected,
    required this.isProcessing,
    required this.status,
    required this.onTap,
    required this.onUninstall,
    required this.onForceRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) {
        onTap();
        _showContextMenu(context, details.globalPosition);
      },
      onTap: onTap,
      child: Container(
        color: isSelected
          ? const Color(0xFFCCE8FF)
          : (app.isRecentlyInstalled ? const Color(0xFFFFF4CE) : Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.apps, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            app.name,
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (isProcessing)
                            Text(
                              _getStatusText(status),
                              style: const TextStyle(fontSize: 11, color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  app.formattedSize,
                  style: const TextStyle(fontSize: 13),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  app.formattedDate,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(UninstallStatus status) {
    switch (status) {
      case UninstallStatus.uninstalling: return 'Uninstalling...';
      case UninstallStatus.scanning: return 'Scanning for leftovers...';
      case UninstallStatus.cleaning: return 'Cleaning traces...';
      case UninstallStatus.complete: return 'Completed!';
      default: return '';
    }
  }

  void _showContextMenu(BuildContext context, Offset position) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, position.dy),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          onTap: onUninstall,
          child: const Text('Uninstall...', style: TextStyle(fontSize: 13)),
        ),
        PopupMenuItem(
          onTap: onForceRemove,
          child: const Text('Force Removal', style: TextStyle(fontSize: 13, color: Colors.red)),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          child: Text('Remove Entry', style: TextStyle(fontSize: 13)),
        ),
        const PopupMenuItem(
          child: Text('Registry Entry', style: TextStyle(fontSize: 13)),
        ),
        const PopupMenuItem(
          child: Text('Installation Folder', style: TextStyle(fontSize: 13)),
        ),
        const PopupMenuItem(
          child: Text('Program Website', style: TextStyle(fontSize: 13)),
        ),
      ],
    );
  }
}
