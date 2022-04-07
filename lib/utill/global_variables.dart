import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_git/screens/home_screen.dart';
import 'package:learn_git/screens/profile_screen.dart';
import 'package:learn_git/screens/questionlist.dart';
import 'package:learn_git/screens/search_screen.dart';
import 'package:learn_git/screens/setting_screen.dart';

List<Widget> homeScreenItems = [
  HomeScreen(),
  const SearchScreen(),
  const QuestionList(),
  SettingScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
