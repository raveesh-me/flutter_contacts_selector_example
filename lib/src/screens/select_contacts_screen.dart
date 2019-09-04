import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class SelectContactsScreen extends StatefulWidget {
  @override
  _SelectContactsScreenState createState() => _SelectContactsScreenState();
}

class _SelectContactsScreenState extends State<SelectContactsScreen> {
  List<Contact> availableContacts;
  List<Contact> selectedContacts;

  toggleContact(Contact contact) {
    if (selectedContacts.contains(contact))
      selectedContacts.remove(contact);
    else
      selectedContacts.add(contact);
    setState(() {});
  }

  getContacts() async {
    try {
      print('GETTING CONTACTS__________________________________');

      var contacts = await ContactsService.getContacts();
      availableContacts =
          contacts.where((contact) => contact.displayName != null).toList()
            ..sort(
              (a, b) => a.displayName.compareTo(b.displayName),
            );
      print('GOT CONTACTS_________________________________');
      setState(() {});
    } catch (err) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(err)));
    }
  }

  @override
  void initState() {
    super.initState();
    selectedContacts = [];
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: availableContacts == null
                ? LinearProgressIndicator()
                : ListView.builder(
                    itemBuilder: (context, position) {
                      Contact contact = availableContacts[position];
                      return SelectableContactTile(
                        onTap: () {
                          return toggleContact(contact);
                        },
                        contact: contact,
                        isSelected: selectedContacts.contains(contact),
                      );
                    },
                    itemCount: availableContacts.length,
                  ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context, selectedContacts);
            },
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Center(
                  child: Text("Done"),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SelectableContactTile extends StatelessWidget {
  final bool isSelected;
  final Contact contact;
  final Function onTap;

  const SelectableContactTile(
      {Key key,
      @required this.isSelected,
      @required this.contact,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: MaterialButton(
        onPressed: onTap,
        child: Column(
          children: <Widget>[
            Text('name: ${contact.givenName}'),
            Text('phone: ${contact.phones.toList()[0].value}'),
            Text('isSelected: $isSelected'),
          ],
        ),
      ),
    );
  }
}
