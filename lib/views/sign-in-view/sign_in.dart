import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_together/core/utils.dart';
import 'package:help_together/services/language_service.dart';
import 'package:help_together/services/user_service.dart';
import 'package:location/location.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with TickerProviderStateMixin {
  UserService userService = UserService.instance;
  AnimationController animationController;
  Animation<double> pawIn;
  Animation<double> pawUp;
  Animation<double> pawOpacity;
  Animation<double> buttonDown;

  signIn() async {
    final result = await getLocation();
    if (result is LocationData) {
      final user = await signInWithGoogle();
      final addresses = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(result.latitude, result.longitude));
      await userService.signIn(user, addresses[0].adminArea);
      Navigator.of(context).pushNamed('/home');
    }
  }

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

    Future.microtask(() async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context).pushNamed('/home');
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange,
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
                      child: Wrap(
                        spacing: 30,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            width: 150,
                          )
                        ],
                      )),
                ),
                Opacity(
                    opacity: pawOpacity.value,
                    child: Text('HELPY',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.permanentMarker(
                            color: Colors.white, fontSize: 60))),
                Transform.translate(
                  offset: Offset(0, buttonDown.value),
                  child: Opacity(
                    opacity: pawOpacity.value,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 15,
                              primary: Colors.white,
                              padding: const EdgeInsets.all(20)),
                          child: Wrap(
                            spacing: 10,
                            children: [
                              Icon(FontAwesomeIcons.google,
                                  color: Colors.blue[900]),
                              Text(
                                  LanguageService.instance
                                      .translateWord('signIn'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(color: Colors.black))
                            ],
                          ),
                          onPressed: () {
                            print('click');
                            signIn();
                          }),
                    ),
                  ),
                )
              ],
            );
          },
        )));
  }
}
