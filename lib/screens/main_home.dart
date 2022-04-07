import 'package:flutter/material.dart';

import 'home.dart';

/*Created by - IT19246024 - Warnakulasuriya D.A*/
class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 30, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                          ),
                          child: Image.network(
                              "https://image.winudf.com/v2/image1/Y29tLm5obi5hbmRyb2lkLmJsb2dfaWNvbl8xNTk1NDAxNzAzXzA2OA/icon.png?w=&fakeurl=1"),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                          "https://play-lh.googleusercontent.com/36szRvmqeewn6fxpx9V88zhpPU3c84Im9zjAFPZl-cReiztnAD6cn0jSnWBGsNNdPsU"),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 30, 0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Image.network(
                          "https://www.worcesternews.co.uk/resources/images/4044885/"),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                        "https://unloc.online/wp-content/uploads/2020/04/283-2833820_user-icon-orange-png.png"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
