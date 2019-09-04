import 'package:flutter/material.dart';
import 'package:flutter_contacts_selector/src/screens/home_screen.dart';
import 'package:flutter_contacts_selector/src/screens/select_contacts_screen.dart';

class ContactsSelectorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Contacts Selector App",
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
        '/select-contacts': (_) => SelectContactsScreen(),
      },
    );
  }
}
