import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitledretrant/providers/language_provider.dart';
import 'package:untitledretrant/providers/theme_provider.dart';
import 'package:untitledretrant/screens/Catagorymealscreen.dart';
import 'package:untitledretrant/screens/Flitershas.dart';
import 'package:untitledretrant/screens/Meal_detial.dart';
import 'package:untitledretrant/screens/TabsScreen.dart';
import 'package:untitledretrant/screens/on_boarding_screen.dart';
import 'package:untitledretrant/screens/theme_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'providers/meal_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homescreen= (prefs.getBool('watched')??false) ? TabsScreen():OnBoardingScreen();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MealProvider>(
              create:(ctx)=>MealProvider()
          ),
          ChangeNotifierProvider<ThemeProvider>(
              create:(ctx)=>ThemeProvider()
          ),
          ChangeNotifierProvider<LanguageProvider>(
              create:(ctx)=>LanguageProvider()
          ),
        ],
        child: MyApp(homescreen),
      )
  );
}

class MyApp extends StatelessWidget {
  final Widget homescreen;

  const MyApp( this.homescreen) ;

  @override
  Widget build(BuildContext context) {
    var primaryColor=Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor=Provider.of<ThemeProvider>(context,listen: true).accentColor;
    var tm=Provider.of<ThemeProvider>(context,listen: true).tm;
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      theme: ThemeData(
          primarySwatch: primaryColor,
          accentColor: accentColor,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          buttonColor:Colors.black87,
          cardColor:Colors.white,
          shadowColor: Colors.black54,
          textTheme:ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 50, 50, 1),
            ),
            headline6: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),

          )
      ),
      darkTheme: ThemeData(
          primarySwatch: primaryColor,
          accentColor: accentColor,
          canvasColor: Color.fromRGBO(14, 22, 33, 1),
          fontFamily: 'Raleway',
          buttonColor:Colors.white70,
          cardColor:Color.fromRGBO(35, 34, 39, 1),
          shadowColor: Colors.black26,
          unselectedWidgetColor: Colors.white70,
          textTheme:ThemeData.dark().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Colors.white60,
            ),
            headline6: TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),

          )
      ),
      //home:  categories(),
      routes: {
        '/':(context)=>homescreen,
        TabsScreen.routeName:(context)=>TabsScreen(),
        Catagorymealscreen.routname:(context)=>Catagorymealscreen(),
        Mealdatials.routname:(context)=>Mealdatials(),
        Fliters.routeName:(context)=>Fliters(),
        ThemesScreen.routeName:(context)=>ThemesScreen(),
      },
    );
  }
}

class Myhomepage extends StatefulWidget {
  @override
  _MyhomepageState createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("hassan"),
        ),
        body:null
    );
  }
}
