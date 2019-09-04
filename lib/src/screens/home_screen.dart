import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart' as contacts;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<contacts.Contact> _selectedContacts;

  @override
  void initState() {
    super.initState();
    _selectedContacts = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              child: ListView.builder(
                itemBuilder: (_, position) => SelectedContactsTile(
                  contact: _selectedContacts[position],
                ),
                itemCount: _selectedContacts.length,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              var result =
                  await Navigator.pushNamed(context, '/select-contacts');
              _selectedContacts = result;
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        "Select Contacts",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SelectedContactsTile extends StatelessWidget {
  final contacts.Contact contact;

  const SelectedContactsTile({Key key, @required this.contact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(contact.givenName),
      subtitle: Text(
        contact.phones.toList()[0].value,
      ),
    ));
  }
}
