import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> pawIn;
  Animation<double> pawUp;
  Animation<double> pawOpacity;
  Animation<double> buttonDown;

  @override
  initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    pawIn = Tween<double>(begin: 30, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 0.25)));
    pawUp = Tween<double>(begin: 1, end: -80).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0.25, 0.35)));
    pawOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0.35, 0.65)));
    buttonDown = Tween<double>(begin: 0, end: 60).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0.35, 0.55)));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AnimatedBuilder(
      animation: animationController,
      builder: (context, value) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, pawUp.value),
              child: Transform.scale(
                  scale: pawIn.value,
                  child: Icon(FontAwesomeIcons.paw,
                      size: 70, color: Colors.white)),
            ),
            Opacity(
              opacity: pawOpacity.value,
              child: Text('KAHRAMANIM',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            Opacity(
              opacity: pawOpacity.value,
              child: Transform.translate(
                offset: Offset(0, buttonDown.value),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: Colors.white,
                      padding: const EdgeInsets.all(20)),
                  child: Text('Google ile Giriş Yap',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black)),
                  onPressed: () {},
                ),
              ),
            )
          ],
        );
      },
    )));
  }
}
