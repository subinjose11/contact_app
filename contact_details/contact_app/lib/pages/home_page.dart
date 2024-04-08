import 'dart:math';
import 'package:contact_app/moduels/user.dart';
import 'package:contact_app/pages/add_contact.dart';
import 'package:contact_app/service/userAPI.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User>? users;
  var isLoaded = false;

  @override
  void initState() {
    getRecord();
  }

  getRecord() async {
    users = await UserAPI().getAllUsers();
    if (users != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text(
            'Phone',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              tooltip: "Add Contact",
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const addContact())).then((data) {
                  if (data != null) {
                    getRecord();
                  }
                });
              },
              icon: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ]),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        child: ListView.builder(
            itemCount: users?.length,
            itemBuilder: (context, index) {
              return Container(
                child: ListTile(
                  title: Text(users![index].name),
                  subtitle: Text(users![index].contact),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            User user =
                                await UserAPI().deleteUser(users![index].id);
                            getRecord();
                          },
                          icon: const Icon(Icons.delete_rounded)),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
