import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_git/providers/user_provider.dart';
import 'package:learn_git/screens/bottom_bar.dart';
import 'package:learn_git/screens/login_screen.dart';
import 'package:learn_git/screens/splash.dart';
import 'package:learn_git/utill/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  //ensure widgets initiazed da blnw
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    /** */
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: blackColor,
        ),
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),

/**Firebase provide multiple methds that we can run to check 
 * authentication status there are 3 methods
 * 1- IdTockenChanges() => FirebaseAuth.instance.IdTockenChanges()
 * it listen any changers from user this use when user signin or user sign out
 * this run when token change
 * 2- userChanges() => 
 * this gives some update methods
 * 3-authStateChanges() - only run sign in and signout
*/
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //if connection active
            if (snapshot.connectionState == ConnectionState.active) {
              // Check snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data it means user is logged
                return const BottomBar();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            //This runs when connection is waiting
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Splash();
          },
        ),
      ),
    );
  }
}
