import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timagra_new/main.dart';
import 'package:timagra_new/view/homepage.dart';
import 'package:timagra_new/view/registration/login.dart';

void main() {
  testWidgets('App navigates to Homepage when logged in', (WidgetTester tester) async {
    // Simulate a logged-in user
    await tester.pumpWidget(const MyApp(isLoggedIn: true));

    // Check if Homepage is displayed
    expect(find.byType(Homepage), findsOneWidget);
    expect(find.byType(SignInPage), findsNothing);
  });

  testWidgets('App navigates to SignInPage when not logged in', (WidgetTester tester) async {
    // Simulate a new user (not logged in)
    await tester.pumpWidget(const MyApp(isLoggedIn: false));

    // Check if SignInPage is displayed
    expect(find.byType(SignInPage), findsOneWidget);
    expect(find.byType(Homepage), findsNothing);
  });
}
