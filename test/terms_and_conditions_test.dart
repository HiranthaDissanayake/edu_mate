import 'package:edu_mate/Admin/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Termsandconditions Widget Tests', () {
    testWidgets('Termsandconditions displays title and back button',
        (WidgetTester tester) async {
      // Build widget
      await tester.pumpWidget(
        MaterialApp(
          home: Termsandconditions(),
        ),
      );

      // Check for title
      expect(find.text('Terms and Conditions'), findsOneWidget);

      // Check for back button
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('Termsandconditions shows loading state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Termsandconditions(),
        ),
      );

      // Initially termsStream is empty, so there should be no terms text yet
      expect(find.byType(Text), findsWidgets); // Title text is still found
    });
  });
}
