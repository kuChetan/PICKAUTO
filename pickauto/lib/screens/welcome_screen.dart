
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pickauto/screens/location_map_screen.dart';

import '../components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin{
  late AnimationController controller;
  late Animation animation;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = ColorTween(begin: Colors.redAccent, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {
        // print
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset('images/logo.png',color: Colors.redAccent,),
                height: 60.0,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'PICKAUTO',
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                    speed: Duration(milliseconds: 300),
                  ),
                ],
                totalRepeatCount: 1,
              ),
              
            ],
            
          ),
          SizedBox(height: 48.0,),
          RoundedButton(selectedColor: Colors.redAccent,buttonText: 'Get Location',onPressed: () {
            Navigator.pushNamed(context, LocationMapScreen.id);
          },),
          // RoundedButton(selectedColor: Colors.lightBlueAccent,buttonText: 'Register',onPressed: () {
          //   Navigator.pushNamed(context, RegistrationScreen.id);
          // },),
        ],
      ),
    );
  }
  
}
