import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_git/models/user.dart' as model;
import 'package:learn_git/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../utill/colors.dart';
import '../utill/global_variables.dart';

/**
 * created by IT19123196(K.H.T.N Dewangi)
 */
class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  late PageController pageController; // for tabs animation
  String username = "";

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    getData();
    //getUserName();
  }

  getData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

/**From Tutorial
 * Get data from firestore add collection name and in the doc we want to put 
 * userid and useing get() get information it store in the DocumentSnapshot variable
 * Then set username 
 */
  // void getUserName() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@)");
  //   print(snap.data());
  //   print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@)");

  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  //   print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@)");
  //   print(snap.data());
  // }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void pageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTap(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: pageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: blackColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? whiteColor : grayColor,
            ),
            label: '',
            backgroundColor: whiteColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_page == 1) ? whiteColor : grayColor,
              ),
              label: '',
              backgroundColor: whiteColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.post_add,
                color: (_page == 2) ? whiteColor : grayColor,
              ),
              label: '',
              backgroundColor: whiteColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: (_page == 3) ? whiteColor : grayColor,
            ),
            label: '',
            backgroundColor: whiteColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 4) ? whiteColor : grayColor,
            ),
            label: '',
            backgroundColor: whiteColor,
          ),
        ],
        onTap: navigationTap,
        currentIndex: _page,
      ),
    );
  }
}
