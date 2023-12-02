import 'dart:convert';

import 'package:final_project/models/user.dart' as myuser;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<myuser.User> _loadedUser;
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  final user = FirebaseAuth.instance.currentUser!;
  final _passwordController = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();
  var _enteredFirstname = "";
  var _enteredLastname = "";
  var _enteredEmail = "";
  var _enteredPassword = "";
  var _userid = "";

  bool editEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadedUser = _loadUser();
  }

  /// Loads the user from the db
  Future<myuser.User> _loadUser() async {
    final url = Uri.https(
        'idata2503-finalproject-default-rtdb.europe-west1.firebasedatabase.app',
        'user.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception("Failed to fetc user. Please try again later.");
    }

    final Map<String, dynamic> loadedUsers = json.decode(response.body);
    late myuser.User user;
    for (final loadedUser in loadedUsers.entries) {
      _userid = loadedUser.key;
      if (loadedUser.value['email'] == userEmail) {
        user = myuser.User(
            firstname: loadedUser.value['firstname'],
            lastname: loadedUser.value['lastname'],
            email: loadedUser.value['email']);
      }
    }
    return user;
  }

// Validates and saves the password (is i more or equal to 6?)
  bool validatePassword() {
    if (_passwordController.currentState!.validate()) {
      _passwordController.currentState!.save();
      return true;
    } else {
      return false;
    }
  }

  /// Updates the user profile.
  /// Shows a alertdialog to confrim apssword to be able to update.
  /// Have a problem here as the Email had to be dofirmed before changing.
  /// Therefor new data of the user is stored in the realtime db before the email actually has been changed
  /// (a verification email is sent to the new email)
  void update() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(),
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              title: const Text(
                'Confirm password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              content: Form(
                key: _passwordController,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                  child: TextFormField(
                    obscureText: true,
                    enabled: editEnabled,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      label: Text("Firstname"),
                      filled: true,
                      fillColor: Color.fromARGB(255, 241, 244, 252),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide.none,

                        // Remove border color
                      ),
                      hintText: "Write here..",
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length < 6) {
                        return "Enter valid password";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _enteredPassword = value!;
                    },
                  ),
                ),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (validatePassword()) {
                        Navigator.pop(context);

                        final credential = EmailAuthProvider.credential(
                            email: user.email!, password: _enteredPassword);

                        try {
                          await user.reauthenticateWithCredential(credential);
                          await user.verifyBeforeUpdateEmail(_enteredEmail);
                        } catch (e) {}
                        await updateUser(
                            _enteredFirstname, _enteredLastname, _enteredEmail);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 1),
                      backgroundColor: const Color.fromARGB(255, 44, 55, 200),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  /// updates the user with a HTTP.patch. Correct user is accessed with the id of the user.
  Future updateUser(String firstname, String lastname, String email) async {
    final url = Uri.https(
        'idata2503-finalproject-default-rtdb.europe-west1.firebasedatabase.app',
        'user/$_userid.json');
    await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
        },
      ),
    );
  }

  /// Checks if email is valid or not with regexp
  bool emailIsValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  /// Returns a scaffold with the widgets. Shows different content based off the Future methods (using futurebuilder)
  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("Loading"),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(1000, 241, 244, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(1000, 241, 244, 252),
        title: const Text(
          "Profile",
          style:
              TextStyle(color: Color.fromARGB(255, 34, 67, 153), fontSize: 30),
        ),
      ),
      body: FutureBuilder(
        future: _loadedUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            content = const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            content = const Center(
              child: Text(
                "error",
              ),
            );
          }
          if (snapshot.hasData) {
            content = Center(
              child: SingleChildScrollView(
                child: Container(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 700
                          : 500,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  editEnabled = !editEnabled;
                                });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 34, 67, 153),
                                size: 30,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(255, 44, 55, 200),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 44, 55, 200),
                                  width: 3),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 30, 25, 35),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  initialValue: snapshot.data!.firstname,
                                  enabled: editEnabled,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    label: Text("Firstname"),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 241, 244, 252),
                                    border: OutlineInputBorder(),
                                    hintText: "Write here..",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().length <= 2) {
                                      return "Enter valid firstname";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    _enteredFirstname = value!.trim();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  initialValue: snapshot.data!.lastname,
                                  enabled: editEnabled,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    label: Text("Lastname"),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 241, 244, 252),
                                    border: OutlineInputBorder(),
                                    hintText: "Write here..",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().length <= 2) {
                                      return "Enter valid lastname";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    _enteredLastname = value!.trim();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  initialValue: snapshot.data!.email,
                                  enabled: editEnabled,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    label: Text("Email"),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 241, 244, 252),
                                    border: OutlineInputBorder(),
                                    hintText: "Write here..",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().length <= 1 ||
                                        !emailIsValid(value)) {
                                      return "Must be on form 'example@domain.com' ";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    _enteredEmail = value!.trim();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (!editEnabled)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        editEnabled = !editEnabled;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 1),
                                      backgroundColor: const Color.fromARGB(
                                          255, 44, 55, 200),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                    ),
                                    child: const Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              if (editEnabled)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      update();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 1),
                                      backgroundColor: const Color.fromARGB(
                                          255, 44, 55, 200),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                    ),
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return content;
        },
      ),
    );
  }
}
