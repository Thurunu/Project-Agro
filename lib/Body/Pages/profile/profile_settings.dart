import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_algora_2/Body/bottom_nav_bar_screen.dart';
import '../../../Back/auth_page.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  String userEmail = 'error';
   String userID = 'Not yet';
  final currentUser = FirebaseAuth.instance.currentUser!;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_details');
  final myController = TextEditingController();
  final Map<String, dynamic> data = {};
  bool isEdited = false;
  String selectedOption = 'farmer';

  @override
  void initState() {
    super.initState();
    _userEmail(); // Call _userEmail when the screen loads
    getData();
    myController.addListener(() {
      setState(() {
        isEdited = myController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

//user sign-out
  void _signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthPage(),
      ),
    );
  }

//getting user email
  void _userEmail() {
    if (currentUser != null) {
      String? email = currentUser.email;
      userEmail = email!;
      final uid = currentUser?.uid;
      userID = uid!;
      print(userID);
    } else
      print('error');
  }

//change user name
  void updateName(String name) async {
    String formattedName = capitalizeName(name); // Capitalize the name
    data['name'] = formattedName;

    userCollection.doc(userID).set(data).then((value) {
      print("User name updated!");
      setState(() {
        isEdited =
            false; // Set isEdited to false to hide the button after update
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  //change user type
  void updateType(String type) async {
    data['user_type'] = type;
    userCollection.doc(userID).set(data).then((value) {
      print("User type updated!");
      setState(() {
        isEdited =
            false; // Set isEdited to false to hide the button after update
      });
    }).catchError((onError) {
      print(onError);
    });
  }

//capitalize user name first letter
  String capitalizeName(String name) {
    // Split the name into words
    List<String> words = name.split(' ');

    // Capitalize the first letter of each word
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    // Join the words back together with a space
    return words.join(' ');
  }

//getting user data from the database
  void getData() async {
    userCollection.doc(userID).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        String name = doc.get('name');
        String type = doc.get('user_type');
        myController.text = name; // Set the retrieved name in the text field
        setState(() {
          isEdited = false;
          selectedOption = type;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              this.context,
              MaterialPageRoute(
                builder: (context) => const BottomNavBarScreen(
                  initialPage: 3,
                ),
              ),
            );
          },
        ),
        actions: <Widget>[
          if (isEdited)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  updateName(myController.text);
                  updateType(selectedOption);
                  setState(() {
                    isEdited = false;
                  });
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(
          top: screenHeight * 0.05,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                //profile picture
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(
                    image: AssetImage('assets/images/user.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'Edit Profile Picture',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  userEmail,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              //user name
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 10.0,
                ),
                child: Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: myController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),

              //user type
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 10.0,
                ),
                child: Text(
                  'User Type',
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RadioListTile<String>(
                      title: const Text('Farmer'),
                      value: 'farmer',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                          isEdited = true;
                        });

                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Seller'),
                      value: 'seller',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                          isEdited = true;
                        });

                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Farmer & Seller'),
                      value: 'both',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                          isEdited = true;
                        });

                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 10.0),
                child: Text(
                  'Other Options',
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: _signOut,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Initial background color
                      borderRadius: BorderRadius.circular(
                          8.0), // Optional: Add rounded corners
                    ),
                    child: Text(
                      'Sign out',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.green.shade500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
