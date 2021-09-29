

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{
  var primaryColor=Colors.pink;
  var accentColor=Colors.amber;

  var tm=ThemeMode.system;
   String themeText="s";
  onChanged(newcolor,n) async{
    n == 1
        ?primaryColor=toMaterialColor(newcolor.hashCode)
        :accentColor=toMaterialColor(newcolor.hashCode);
        notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("primaryColor", primaryColor.value);
    prefs.setInt("accentColor", accentColor.value);
  }
  getcolor()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   primaryColor= toMaterialColor(prefs.getInt("primaryColor") ??0xFFE91E63 );
  accentColor=toMaterialColor( prefs.getInt("accentColor")??0xFFFFC107);
  notifyListeners();
  }
  MaterialColor toMaterialColor(colorval){
  return  MaterialColor(
        colorval,
      <int, Color>{
        50: Color(0xFFFFEBEE),
        100: Color(0xFFFFCDD2),
        200: Color(0xFFEF9A9A),
        300: Color(0xFFE57373),
        400: Color(0xFFEF5350),
        500: Color(colorval),
        600: Color(0xFFE53935),
        700: Color(0xFFD32F2F),
        800: Color(0xFFC62828),
        900: Color(0xFFB71C1C),
      },
    );
  }
  void themeModeChange(newThemeval) async{
    tm=newThemeval;
    getThemetext(tm);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString("themeText", themeText);
     print(prefs.getString("themeText"));
  }
 getThemetext(ThemeMode tm){
    if (tm==ThemeMode.dark)
      themeText="d";
    else if (tm==ThemeMode.light)
      themeText="l";
    else if (tm==ThemeMode.system)
      themeText="s";
 }
 getThemeMode() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
  themeText= prefs.getString("themeText")?? "s";
   if (themeText=="d")
     tm=ThemeMode.dark;
   else if (themeText=="l")
     tm=ThemeMode.light;
   else if ( themeText=="s")
     tm=ThemeMode.system;
   notifyListeners();
 }
}