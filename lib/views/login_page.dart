import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/login_from.dart';
import 'package:fristprofigmatest/views/widget/loginfrom/widget/login_background.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                      'SIGN IN',
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
                      image: Svg('assets/images/iconsvgs/civic.svg'),
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 20,width: 0,),
                   LoginForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
