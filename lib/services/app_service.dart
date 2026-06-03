import 'package:flutter/material.dart';
import '../models/app_info.dart';

enum UninstallStatus { idle, uninstalling, scanning, cleaning, complete }

class AppService extends ChangeNotifier {
  List<AppInfo> _apps = [];
  String _searchQuery = '';
  bool _showStoreApps = false;

  UninstallStatus _status = UninstallStatus.idle;
  String? _currentlyProcessingId;

  AppService() {
    _loadMockData();
  }

  List<AppInfo> get apps {
    var filtered = _apps.where((app) => app.isStoreApp == _showStoreApps).toList();
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((app) =>
        app.name.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    return filtered;
  }

  String get searchQuery => _searchQuery;
  bool get showStoreApps => _showStoreApps;
  UninstallStatus get status => _status;
  String? get currentlyProcessingId => _currentlyProcessingId;

  int get totalCount => apps.length;
  String get totalSize {
    double total = apps.fold(0, (sum, item) => sum + item.sizeInMb);
    if (total >= 1024) {
      return '${(total / 1024).toStringAsFixed(1)} GB';
    }
    return '${total.toStringAsFixed(1)} MB';
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleStoreApps(bool value) {
    _showStoreApps = value;
    notifyListeners();
  }

  Future<void> uninstallApp(String id) async {
    _currentlyProcessingId = id;
    _status = UninstallStatus.uninstalling;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _status = UninstallStatus.scanning;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    _status = UninstallStatus.cleaning;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    _apps.removeWhere((app) => app.id == id);
    _status = UninstallStatus.complete;
    _currentlyProcessingId = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    _status = UninstallStatus.idle;
    notifyListeners();
  }

  Future<void> forceRemoveApp(String id) async {
    _currentlyProcessingId = id;
    _status = UninstallStatus.scanning;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));

    _status = UninstallStatus.cleaning;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    _apps.removeWhere((app) => app.id == id);
    _status = UninstallStatus.complete;
    _currentlyProcessingId = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    _status = UninstallStatus.idle;
    notifyListeners();
  }

  void _loadMockData() {
    _apps = [
      AppInfo(id: '1', name: '7+ Taskbar Tweaker v5.13', sizeInMb: 2.17, installedOn: DateTime(2020, 8, 13)),
      AppInfo(id: '2', name: '7-Zip 22.00 (x64)', sizeInMb: 5.53, installedOn: DateTime(2022, 7, 15)),
      AppInfo(id: '3', name: 'ACS Unified PC/SC Driver 4.0.0.7', sizeInMb: 2.02, installedOn: DateTime(2020, 10, 5)),
      AppInfo(id: '4', name: 'AMD Ryzen Master SDK', sizeInMb: 2.67, installedOn: DateTime(2022, 7, 11)),
      AppInfo(id: '5', name: 'AnyDesk (32-bit)', sizeInMb: 9.84, installedOn: DateTime(2022, 7, 23)),
      AppInfo(id: '6', name: 'AnyToISO (32-bit)', sizeInMb: 50.5, installedOn: DateTime(2021, 1, 10), isRecentlyInstalled: true),
      AppInfo(id: '7', name: 'Apple Mobile Device Support', sizeInMb: 53.5, installedOn: DateTime(2021, 2, 26)),
      AppInfo(id: '8', name: 'Axialis IconWorkshop 6.91 (32-bit)', sizeInMb: 25.2, installedOn: DateTime(2021, 11, 26)),
      AppInfo(id: '9', name: 'Battle.net (32-bit)', sizeInMb: 645, installedOn: DateTime(2021, 8, 24)),
      AppInfo(id: '10', name: 'Brave (32-bit)', sizeInMb: 685, installedOn: DateTime(2021, 8, 8)),
      AppInfo(id: '11', name: 'Cent Browser', sizeInMb: 396, installedOn: DateTime(2021, 2, 9)),
      AppInfo(id: '12', name: 'ClickOnce Bootstrapper Package for M...', sizeInMb: 252, installedOn: DateTime(2021, 3, 9)),
      AppInfo(id: '13', name: 'CMake', sizeInMb: 90.9, installedOn: DateTime(2022, 2, 11)),
      AppInfo(id: '14', name: 'Connective Signing Plugins (32-bit)', sizeInMb: 8.93, installedOn: DateTime(2021, 10, 21)),
      AppInfo(id: '15', name: 'Core Temp 1.17.1', sizeInMb: 2.19, installedOn: DateTime(2021, 10, 6)),
      AppInfo(id: '16', name: 'Cppcheck x64 2.4.1', sizeInMb: 49.2, installedOn: DateTime(2021, 6, 18)),
      AppInfo(id: '17', name: 'Dokan Library 1.4.0.1000 (x64)', sizeInMb: 10.9, installedOn: DateTime(2020, 8, 6)),
      AppInfo(id: '18', name: 'Dropbox (32-bit)', sizeInMb: 862, installedOn: DateTime(2022, 8, 2), isRecentlyInstalled: true),
      AppInfo(id: '19', name: 'Epic Games Launcher (32-bit)', sizeInMb: 1.71 * 1024, installedOn: DateTime(2021, 6, 12)),
      AppInfo(id: '20', name: 'Epic Online Services (32-bit)', sizeInMb: 249, installedOn: DateTime(2021, 10, 20)),
    ];
  }
}
