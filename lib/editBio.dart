import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/user.dart';

class EditBioPage extends StatefulWidget {
  @override
  State<EditBioPage> createState() => _EditBioPageState();
}

class _EditBioPageState extends State<EditBioPage> {
  TextEditingController _bio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context, listen: false);

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference users = db.collection("users");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.3),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 72, 106),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<DocumentSnapshot>(
                      stream: User.users.doc(User.idlogin).snapshots(),
                      builder: (_, snapshot) {
                        return CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                              snapshot.data!.get("path_potoProfile")),
                        );
                      }),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 16),
                TextFormField(
                  controller: _bio,
                  maxLines: 3, // Jumlah baris untuk textfield
                  decoration: InputDecoration(
                    labelText: 'Edit Bio',
                    hintText: 'Enter your bio',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 41, 179, 173)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 41, 179, 173)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (User.userAuth != null) {
                      await users.doc(User.idlogin).update({'bio': _bio.text});
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Apply', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 29, 72, 106)),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
