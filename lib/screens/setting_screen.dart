import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_git/screens/login_screen.dart';
import 'package:learn_git/screens/splash.dart';
import 'package:learn_git/services/auth_service.dart';
import 'package:learn_git/services/firestore_service.dart';
import 'package:learn_git/utill/colors.dart';

import '../utill/utils.dart';
import '../widgets/text_field.dart';

/**
 * created by IT19123196(K.H.T.N Dewangi)
 */
class SettingScreen extends StatefulWidget {
  final String uid;
  const SettingScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();

  var newPassword = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final currentUser = FirebaseAuth.instance.currentUser;
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  bool isLoading = false;
  late User user;
  var userData = {};
  bool _displayNameValid = true;
  bool _bioValid = true;
  Uint8List? _image;
  String imgURL = "";

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    var snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();
    userData = snap.data()!;
    _usernameController.text = userData['username'];
    _emailController.text = userData['email'];
    _bioController.text = userData['bio'];
    imgURL = userData['photoUrl'];
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    newPasswordController.dispose();
    super.dispose();
  }

  changePassword() async {
    try {
      print('DEWWWWWWWWWWWWWWWWWW');
      await currentUser!.updatePassword(newPasswordController.text);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: yellowColor,
          content: Text(
            'Your Password has been Successfully Changed. Login again !',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  deleteProfile() async {
    try {
      print('DEWWWWWWWWWWWWWWWWWW');
      String res = await FireStoreService()
          .deleteProfile(FirebaseAuth.instance.currentUser!.uid);
      print("FirebaseAuth.instance.currentUser!.uid 1");
      print(FirebaseAuth.instance.currentUser!.uid);
      print("FirebaseAuth.instance.currentUser!.uid 11");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Splash()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: yellowColor,
          content: Text(
            'Your Account has been Successfully deleted. SignUp again !',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

/*From Tutorial
  Using Image picker we can select image using galary or we can capture image by using cammera
  when user click add image button that method called 
  and pickImage function write in utiil class
  i use Uint8List because it is dynamic (not mension any type) 
  set state because we need to display the image we selected 
  on the circle avatar*/
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  updateProfileData() async {
    setState(() {
      isLoading = true;
    });
    String res = await FireStoreService().updateUserData(
      FirebaseAuth.instance.currentUser!.uid,
      username: _usernameController.text,
      bio: _bioController.text,
    );
    print("FFFFFFF");
    print(_bioController.text);
    print(_emailController.text);
    print("DEWWWWWWW");

    
    SnackBar snackbar = SnackBar(content: Text("Profile updated!"));
  }

  updateProfilePicture() async {
    setState(() {
      isLoading = true;
    });
    String res = await FireStoreService()
        .updateProfile(FirebaseAuth.instance.currentUser!.uid, file: _image!);
    print("FFFFFFF");
    print(_bioController.text);
    print(_emailController.text);
    print("DEWWWWWWW");

    
    SnackBar snackbar = SnackBar(content: Text("Profile Picture updated!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 26, top: 25, right: 20),
        child: ListView(
          children: [
            const Center(
              child: Text(
                "Settings",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: const [
                Icon(
                  Icons.person,
                  color: blueColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            /**Learn from tutorial */
            /**In UI part i learn how to call method and display like this UI passing context and tile as parameters
            */
            changePasswordAlert(context, "Change password"),
            updateUserAccountAlert(context, "Update user account"),
            deactivateAccountAlert(context, "Delete Account"),
            imageUpdateAlert(context, "Update image"),
            PrivacyAlert(context, "Privacy and security"),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Icon(
                  Icons.info,
                  color: blueColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            InformationAlert(context, "Seller", "US"),
            InformationAlert(context, "Language", "English"),
            InformationAlert(context, "Size", "64.9MB"),
            InformationAlert(context, "Conpatibility", "ww"),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Icon(
                  Icons.volume_up_outlined,
                  color: blueColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            notificationTab("Enable Notification", false),
            notificationTab("Enable Light Mode", false),
            notificationTab("Enable To Use As Private", false),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: OutlineButton(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {},
                child: const Text("SIGN OUT",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row notificationTab(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: grayColor),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector PrivacyAlert(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                        "If your mobile app collects personal information from your users, you need a Privacy Policy to comply with legislation around the world.Not only this, but app stores such as Google Play and Apple's App Store are now insistent on developers including Privacy Policies in their app store listings as well as within their apps."),
                    Text(
                        "Having a Privacy Policy is also good practice for transparency and to show your customers that you care about keeping their personal data safe and secure. When you update your Privacy Policy with material changes, you can send Update Notices to be even more transparent and compliant."),
                    Text(
                        "When you request permission to use personal data for somethingAccount sign-up and login pagesCheckout or payment pages"),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: grayColor,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: grayColor,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector changePasswordAlert(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                //backgroundColor: C
                title: Text(title),
                //insetPadding: EdgeInsets.all(10),
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                content: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                          autofocus: false,
                          controller: newPasswordController,
                          obscureText: true,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                            contentPadding: const EdgeInsets.all(8),
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      const SizedBox(
                        height: 24,
                      ),
                      //confirm password field
                      TextFormField(
                          autofocus: false,
                          controller: confirmNewPasswordController,
                          obscureText: true,
                          validator: (value) {
                            if (confirmNewPasswordController.text !=
                                newPasswordController.text) {
                              return "Password don't match";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            confirmNewPasswordController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                            contentPadding: const EdgeInsets.all(8),
                            hintText: "Confirm Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),

                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              newPassword = newPasswordController.text;
                            });
                            changePassword();
                          }
                        },
                        child: const Text(
                          'Change Password',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: grayColor,
              ),
            ),
            const Icon(
              Icons.password_rounded,
              color: grayColor,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector updateUserAccountAlert(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                //backgroundColor: C
                title: Text(title),
                //insetPadding: EdgeInsets.all(10),
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(),
                      flex: 2,
                    ),
                    Stack(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  NetworkImage('imgURL', scale: 1.0),
                              //backgroundColor: Color.fromARGB(255, 12, 12, 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      hint: 'Enter Your User Name',
                      textType: TextInputType.text,
                      textController: _usernameController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      hint: 'Enter Your Bio',
                      textType: TextInputType.multiline,
                      textController: _bioController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      child: Container(
                        //From Tutorial check loading
                        child: !isLoading
                            ? const Text(
                                'Update',
                              )
                            : const CircularProgressIndicator(
                                color: whiteColor,
                              ),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: blueColor,
                        ),
                      ),
                      onTap: updateProfileData,
                    ),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: grayColor,
              ),
            ),
            const Icon(
              Icons.update,
              color: grayColor,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector imageUpdateAlert(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                //backgroundColor: C
                title: Text(title),
                //insetPadding: EdgeInsets.all(10),
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        userData['username'],
                        style: const TextStyle(fontSize: 15, color: blackColor),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                userData['photoUrl'],
                              ),
                              radius: 60,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(),
                          flex: 2,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                                backgroundColor: Color.fromARGB(255, 10, 9, 9),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage:
                                    NetworkImage('imgURL', scale: 1.0),
                                backgroundColor:
                                    Color.fromARGB(255, 12, 12, 12),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      child: Container(
                        //From Tutorial check loading
                        child: !isLoading
                            ? const Text(
                                'Update',
                              )
                            : const CircularProgressIndicator(
                                color: whiteColor,
                              ),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: blueColor,
                        ),
                      ),
                      onTap: updateProfilePicture,
                    ),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: grayColor,
              ),
            ),
            const Icon(
              Icons.update,
              color: grayColor,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector deactivateAccountAlert(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                //backgroundColor: C
                title: Text(title),
                //insetPadding: EdgeInsets.all(10),
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                content: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const Center(
                        child: Text(
                          "Why You Delete your Account?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: blackColor),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFieldInput(
                        hint: '',
                        textType: TextInputType.multiline,
                        textController: _reasonController,
                      ),
                      const Divider(),
                      const SizedBox(height: 5),
                      const Center(
                        child: Text(
                          "Deleting a user is permanent. Keep in mind that if a user is deleted from the account and then needs to be added back to the account, they will be added as a brand new user",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: blackColor),
                        ),
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              newPassword = newPasswordController.text;
                            });
                            deleteProfile();
                          }
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 5),
                      const Center(
                        child: Text(
                          "If you don't want to delete account you can logout",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: blackColor),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Center(
                        child: Text(
                          "Alternatively referred to as a sign in, a login or logon is a set of credentials used to gain access to an area requiring proper authorization. Logins grant access to and control of computers, networks, and bulletin boards, and online accounts and other services or devices.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: blackColor),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          function:
                          () async {
                            await AuthService().signOut();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          };
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: grayColor,
              ),
            ),
            const Icon(
              Icons.leave_bags_at_home,
              color: grayColor,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector InformationAlert(
      BuildContext context, String title, String sub) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: grayColor,
              ),
            ),
            Text(
              sub,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: grayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
