import 'package:flutter/material.dart';
import 'package:fristprofigmatest/views/login_page.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/login_background.dart';
import 'package:fristprofigmatest/views/widget/signupfrom/signup_from.dart';
import 'package:get/get.dart';  // Import GetX

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const loginBackgroundWidget(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'Please enter the information \n below to access.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('assets/images/signupicon.png'),
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 20,width: 0,),
                   SignupForm(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.offAll(() => const LoginPage(), transition: Transition.rightToLeft);
              },
            ),
          ),
        ],
      ),
    );
  }
}
