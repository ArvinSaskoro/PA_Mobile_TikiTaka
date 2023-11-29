// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/user.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({super.key});

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  TextEditingController _search = TextEditingController();

  bool isSearching = false;
  String name = "";

 Widget createButton(String text) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/otherProfile');
      },
      child: Container(
        width: 300,
        height: 50,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 18, 45, 66),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 15),
            Icon(
              Icons.person_add_alt_rounded,
              color: Colors.white,
            ),
            SizedBox(width: 30),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  final User = Provider.of<UserProvider>(context, listen: false);

    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/bottomnav');
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSearching = true;
                  });
                },
                child: Container(

                  width: MediaQuery.of(context).size.width / 1.8,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 217, 217, 217),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.search),
                        SizedBox(width: 10),
                        isSearching
                            ? Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: _search,
                                            decoration: InputDecoration(
                                              hintText: 'Search...',
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (String value) {
                                              setState(() {
                                                isSearching = value.isNotEmpty;
                                              });
                                            },
                                            onSubmitted: (String value) {
                                              print('Searching for: $value');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        // Tampilkan IconButton hanya jika TextField diisi
                        if (_search.text.isNotEmpty)
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _search.clear();
                                isSearching =
                                    false; 
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () async {
                  await User.searchFirestore(_search.text);
                  // print("object");
                 name = User.userSearch.username;
                },
                child: Text(
                  "Search",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 45.1),
            Text(
              'Profile Recommendation',
              style: TextStyle(
                color: Color.fromARGB(255, 18, 45, 66),
                fontFamily: 'Raleway',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            // if (User.searchh == true)
            Container(
              width: double.infinity,
              height: 360,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  createButton(name),
                ],
              ),
            ),
            Container(
              height: 153,
              width: lebar,
              child: Stack(
                children: [
                  Center(
                    child: Positioned(
                      top: 100,
                      child: Container(
                        margin: EdgeInsets.only(top: 60),
                        height: 120,
                        width: lebar / 1.5,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 29, 72, 106),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Positioned(
                      child: Image.asset('assets/maskot.png'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
