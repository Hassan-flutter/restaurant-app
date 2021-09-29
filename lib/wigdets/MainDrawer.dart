import 'package:flutter/material.dart';
import 'package:untitledretrant/screens/Flitershas.dart';
import 'package:untitledretrant/screens/TabsScreen.dart';
import 'package:untitledretrant/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:untitledretrant/providers/language_provider.dart';
class MainDrawer extends StatelessWidget {
  Widget buildfuction(String title,IconData icon,Function hassaner,BuildContext ctx){
    return ListTile(
      leading: Icon(icon, size: 26,color: Theme.of(ctx).buttonColor),
      title: Text(
        title,
        style: TextStyle(
          color:Theme.of(ctx).textTheme.bodyText1.color,
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: hassaner,
    );
  }
  @override
  Widget build(BuildContext context) {
   var len=Provider.of<LanguageProvider>(context,listen: true);
    return Directionality(
      textDirection: len.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: len.isEn? Alignment.centerLeft:Alignment.centerRight,
              color: Theme.of(context).accentColor,
              child: Text(
                len.getTexts('drawer_name'),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(height: 20),
            buildfuction(len.getTexts('drawer_item1'), Icons.restaurant,(){Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);},context),
            buildfuction(len.getTexts('drawer_item2'), Icons.settings,(){Navigator.of(context).pushReplacementNamed(Fliters.routeName);},context),
            buildfuction(len.getTexts('drawer_item3'), Icons.color_lens,(){Navigator.of(context).pushReplacementNamed(ThemesScreen.routeName);},context),
            Divider(height: 10,color: Colors.black),
            Container(
              alignment:len.isEn? Alignment.center: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 20,right: 22),
              child: Text(len.getTexts('drawer_switch_title'),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
                padding:EdgeInsets.only(right:(len.isEn ?0:20),left: (len.isEn?20:0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(len.getTexts('drawer_switch_item2'),
                  style: Theme.of(context).textTheme.headline6,),
                  Switch(
                      value: Provider.of<LanguageProvider>(context,listen: true).isEn,
                      onChanged: (newval){
                        Provider.of<LanguageProvider>(context,listen: false).changeLan(newval);

                      }
                  ),
                 Text(len.getTexts('drawer_switch_item1'),
                style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
