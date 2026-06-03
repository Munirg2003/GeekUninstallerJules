import 'package:intl/intl.dart';

class AppInfo {
  final String id;
  final String name;
  final double sizeInMb;
  final DateTime installedOn;
  final bool isStoreApp;
  final bool isRecentlyInstalled;

  AppInfo({
    required this.id,
    required this.name,
    required this.sizeInMb,
    required this.installedOn,
    this.isStoreApp = false,
    this.isRecentlyInstalled = false,
  });

  String get formattedSize {
    if (sizeInMb >= 1024) {
      return '${(sizeInMb / 1024).toStringAsFixed(2)} GB';
    }
    return '${sizeInMb.toStringAsFixed(2)} MB';
  }

  String get formattedDate {
    return DateFormat('MMM dd, yyyy').format(installedOn);
  }
}
