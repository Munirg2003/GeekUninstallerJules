import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:app/main.dart';
import 'package:app/services/app_service.dart';

void main() {
  testWidgets('App loads and shows titles', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppService(),
        child: const GeekUninstallerApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Program Name'), findsOneWidget);
    expect(find.text('Size'), findsOneWidget);
    expect(find.text('7-Zip 22.00 (x64)'), findsOneWidget);
  });

  testWidgets('Search filters apps', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppService(),
        child: const GeekUninstallerApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '7-Zip');
    await tester.pumpAndSettle();

    expect(find.text('7-Zip 22.00 (x64)'), findsOneWidget);
    expect(find.text('AnyDesk (32-bit)'), findsNothing);
  });
}
