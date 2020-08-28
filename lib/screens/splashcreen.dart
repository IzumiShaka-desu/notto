import 'package:flutter/material.dart';
import 'package:notto/screens/logres.dart';
import 'package:notto/service/sharepref_service.dart';
import 'package:notto/utils.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimate = false;
  animate() {
    setState(() {
      isAnimate = true;
    });
  }

  @override
  void initState() {
    delayMethod(2500, () => animate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var sized = (isAnimate) ? size.width * 4 : size.width / 2;
    return SafeArea(
      child: Stack(children: [
        Positioned.fill(
            child: Container(
          color: Colors.blue,
        )),
        AnimatedPositioned(
          bottom: (isAnimate) ? -size.width : size.width * 0.5,
          left: (isAnimate) ? -size.width : size.width * 0.25,
          child: AnimatedContainer(
            height: sized,
            width: sized,
            duration: Duration(milliseconds: 350),
            curve: Curves.fastLinearToSlowEaseIn,
            onEnd: () => goToHome(),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(sized)),
          ),
          duration: Duration(milliseconds: 450),
          curve: Curves.elasticInOut,
        ),
        AnimatedPositioned(
          bottom: (isAnimate) ? size.height * 0.841 : size.width * 0.68,
          left: size.width * 0.335,
          child: Center(child: createTitle()),
          duration: Duration(milliseconds: 350),
          curve: Curves.elasticInOut,
        ),
      ]),
    );
  }

  goToHome() async {
    bool isLogin = await SFService().isLogin() ?? false;
    if (isLogin) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginRegister()));
    }
  }
}
