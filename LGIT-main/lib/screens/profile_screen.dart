import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_git/utill/colors.dart';

import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../widgets/follow_button.dart';
import 'login_screen.dart';

/**
 * created by IT19123196(K.H.T.N Dewangi)
 */
class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
/**From Tutorial 
 * set usersnap data to the user data global variable and it not going to be null
 * then we can easily get values by calling
 * get followers and folllowing array length using snap and set to variable
 * we can easily disply that values 
*/
      userData = snap.data()!;
      followers = snap.data()!['followers'].length;
      following = snap.data()!['following'].length;
      /**For follow user 
       * 1st define bool variable and set it into false(bool isFollowing)
       * then call snap (user snap)and add current user uid to the
       * followers array in users database using .contains()
      */
      isFollowing = snap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      // setState(() {});
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: blackColor,
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
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
                Column(
                  children: [
                    Center(
                      child: Text(
                        userData['username'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                        child: Text(
                      userData['email'],
                      style: const TextStyle(color: Colors.grey),
                    ))
                  ],
                ),
                const Divider(),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          showState(followers, "followers"),
                          showState(following, "following"),
                        ],
                      ),
                      /**From Tutorial
                       * check Users
                       * 1st check what ever uid we are entering from the parameter
                       * (From the construstor) is equal to the current user id
                       * if it is equal it is user own account then display current user profile
                       * then button display signout button(called Follow Button pass as parameters)
                       * 
                       * If it is not 2nd check follow that person if following person
                       * thendisplay unfollow button(pass separate parameters to dollow button)
                       * 
                       * If these all failed it is follow user (not followed person and not own acc)
                       * pass separate parameter to the follow burtton and set isFollowing = true
                       * and ad 1 to followers
                       */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FirebaseAuth.instance.currentUser!.uid == widget.uid
                              ? FollowButton(
                                  background: blackColor,
                                  textColor: whiteColor,
                                  border: Colors.grey,
                                  text: 'Sign Out',
                                  function: () async {
                                    await AuthService().signOut();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                                )
                              : isFollowing
                                  ? FollowButton(
                                      background: Colors.white,
                                      textColor: Colors.black,
                                      border: Colors.grey,
                                      text: 'Unfollow',
                                      function: () async {
                                        await FireStoreService().followUser(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          userData['uid'],
                                        );

                                        setState(() {
                                          isFollowing = false;
                                          followers--;
                                        });
                                      },
                                    )
                                  : FollowButton(
                                      background: Colors.blue,
                                      textColor: Colors.white,
                                      border: Colors.blue,
                                      text: 'Follow',
                                      function: () async {
                                        await FireStoreService().followUser(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          userData['uid'],
                                        );

                                        setState(() {
                                          isFollowing = true;
                                          followers++;
                                        });
                                      },
                                    )
                        ],
                      ),
                      //const Divider(),
                      const SizedBox(height: 14),
                      const Text('About',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Center(
                          child: Text(
                        userData['bio'],
                        style: const TextStyle(color: Colors.grey),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          );
  }

/** */
  Column showState(int number, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
