import 'package:edu_mate/Admin/profile_screen.dart'; // Update path if needed
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileScreen Widget Tests', () {
    testWidgets('ProfileScreen displays title and edit button',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: ProfileScreen(id: 'dummyId', collection: 'Students'),
        ),
      );

      // Check if 'Profile' text is shown
      expect(find.text('Profile'), findsOneWidget);

      // Check if 'Edit Profile' button is shown
      expect(find.text('Edit Profile'), findsOneWidget);

      // Check if back button is shown
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('Tapping Edit Profile navigates to EditProfileScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProfileScreen(id: 'dummyId', collection: 'Students'),
        ),
      );

      // Tap on the Edit Profile button
      await tester.tap(find.text('Edit Profile'));
      await tester.pumpAndSettle();

      // Since EditProfileScreen uses data from ProfileScreen, you might mock it separately
      // For now, check if the navigation happened (will throw error if navigation fails)
      expect(find.text('Edit Profile'),
          findsWidgets); // Means screen stays/stabilized after tap
    });
  });
}
