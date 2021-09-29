// import 'package:flutter/animation.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:untitledretrant/providers/language_provider.dart';
import 'package:untitledretrant/wigdets/MainDrawer.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
class ThemesScreen extends StatelessWidget {
  static const routeName='/themes';
  final bool fromOnBording;

   ThemesScreen({this.fromOnBording=false });

  Widget buildRadioListTile(ThemeMode themeval,String txt,IconData icon,BuildContext ctx){
    return RadioListTile(
      secondary: Icon(icon,color: Theme.of(ctx).buttonColor),
        value: themeval,
        groupValue:Provider.of<ThemeProvider>(ctx,listen: true).tm ,
        onChanged: (newThemeval)=>Provider.of<ThemeProvider>(ctx,listen: false).themeModeChange(newThemeval),
      title: Text(txt),
    );
  }
  @override
  Widget build(BuildContext context) {
    var len=Provider.of<LanguageProvider>(context,listen: true);
    return Directionality(
      textDirection: len.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar:fromOnBording? AppBar(backgroundColor: Theme.of(context).canvasColor,elevation: 0,):
        AppBar(title: Text(len.getTexts('theme_appBar_title'))),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(len.getTexts('theme_screen_title'),style: Theme.of(context).textTheme.headline6,) 
            ),
            Expanded(
                child:ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(len.getTexts('theme_mode_title'),style:Theme.of(context).textTheme.headline6),
                    ),
                    buildRadioListTile(ThemeMode.system, len.getTexts('System_default_theme'), null, context),
                    buildRadioListTile(ThemeMode.light, len.getTexts('light_theme'), Icons.wb_sunny_outlined, context),
                    buildRadioListTile(ThemeMode.dark, len.getTexts('dark_theme'), Icons.nights_stay_outlined, context),
                    // buildListTile(context, len.getTexts('primary')),
                    // buildListTile(context,len.getTexts('accent')),
                    SizedBox(height: fromOnBording ? 80:0)
                  ],
                )
            )
          ],
        ),
        drawer:fromOnBording ?null: MainDrawer(),
      ),
    );
  }
  // ListTile buildListTile(BuildContext context,txt){
  //   var primarycolor=Provider.of<ThemeProvider>(context,listen: true).primaryColor;
  //   var accentcolor=Provider.of<ThemeProvider>(context,listen: true).accentColor;
  //   return ListTile(
  //     title: Text("Choose your $txt color",style:Theme.of(context).textTheme.headline6),
  //     trailing: CircleAvatar(
  //       backgroundColor: txt =="primary" ? primarycolor:accentcolor,
  //     ),
  //     onTap: (){
  //       showDialog(
  //           context: context,
  //         builder: (BuildContext ctx){
  //             return AlertDialog(
  //               elevation: 4,
  //               titlePadding: const EdgeInsets.all(0.0),
  //               contentPadding:const EdgeInsets.all(0.0),
  //               content: SingleChildScrollView(
  //                 child: ColorPicker(
  //                   pickerColor: txt=="primary" ?Provider.of<ThemeProvider>(ctx,listen: true).primaryColor:
  //                   Provider.of<ThemeProvider>(context,listen: true).accentColor,
  //                   onColorChanged: (newcolor)=>Provider.of<ThemeProvider>(context,listen: false).onChanged(newcolor, txt =="primary"?1:2),
  //                   colorPickerWidth: 300.0,
  //                   pickerAreaHeightPercent: 0.7,
  //                   enableAlpha: false,
  //                   displayThumbColor: true,
  //                   showLabel: false,
  //                 ),
  //               ),
  //             );
  //         }
  //       );
  //     },
  //   );
  // }
}

