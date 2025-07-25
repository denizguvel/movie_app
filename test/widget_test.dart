// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/common/functions/app_functions.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/main.dart';

void main() {
  testWidgets('Movie app smoke test', (WidgetTester tester) async {
    // Initialize the app
    await AppFunctions.instance.init();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed
    expect(find.text('Movie App'), findsOneWidget);
  });
}
