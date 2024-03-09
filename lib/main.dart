import 'package:flutter/material.dart';
import 'package:indi_essence/screens/arscreens/arscreen.dart';
import 'package:indi_essence/screens/authentication/reg_screen.dart';
import 'package:indi_essence/screens/cartscreen/cartmain.dart';
import 'package:indi_essence/screens/homescreen/homescreen.dart';
import 'package:indi_essence/screens/authentication/signup_screen.dart';
import 'package:indi_essence/screens/homescreen/product/productscreen.dart';
import 'package:indi_essence/screens/homescreen/regionscreen/regionscreen.dart';
import 'package:indi_essence/screens/learnscreen/learn_screen.dart';
import 'package:indi_essence/screens/profilescreen/profile.dart';
import 'package:indi_essence/screens/stories/storiesmain.dart';
import 'package:indi_essence/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'navbar.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ehmntpitzzoukscopqxs.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVobW50cGl0enpvdWtzY29wcXhzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk5ODU0NDksImV4cCI6MjAyNTU2MTQ0OX0.R9nbuxDWlsV-NFhepyKYuLIeJWN13h5TltBAiDSdEXE',
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IndiEssence',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashScreen(),
        '/sign_up_screen':(context) => const SignUpScreen(),
        '/home_screen': (context) =>   HomeScreen(),
        '/registration_screen': (context) => const RegistrationScreen(),
        '/navbarscreen':(_) =>  const NavBarScreen(),
        '/storiesymain':(_) =>  const StoriesMain(),
        '/cartmain':(_) => const CartScreen(),
        '/profile':(_) => const Profile(),
        '/regionscreen':(_) =>  RegionScreen(),
        '/learn':(_) =>  LearnScreen(),
        '/productscreen':(_) => ProductGridScreen(),
        // '/productinfo':(_) => ProductGridScreenInfo(),
        // '/arscreen':(_) => ARScreen(),


      },
    );
  }
}

