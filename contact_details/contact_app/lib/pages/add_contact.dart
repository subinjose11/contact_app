import 'package:contact_app/service/userAPI.dart';
import 'package:flutter/material.dart';

class addContact extends StatefulWidget {
  const addContact({super.key});

  @override
  State<addContact> createState() => _addContactState();
}

class _addContactState extends State<addContact> {
  var _userName = TextEditingController();
  var _userContact = TextEditingController();

  bool _validateName = false;
  bool _validateContact = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Contact"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: [
                Text(
                  "Add new contact Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _userName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name value cant be empty' : null,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _userContact,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Contact Number',
                    labelText: 'Contact',
                    errorText:
                        _validateName ? 'Contact value cant be empty' : null,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            _userName.text.isEmpty
                                ? _validateName = true
                                : _validateName = false;
                            _userContact.text.isEmpty
                                ? _validateContact = true
                                : _validateContact = false;
                          });
                          if (_validateName == false &&
                              _validateContact == false) {
                            var result = await UserAPI()
                                .addUser(_userName.text, _userContact.text);
                            Navigator.pop(context, result);
                          }
                        },
                        child: Text('Save')),
                    TextButton(onPressed: () {}, child: Text('Clear')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
