import 'package:flutter/material.dart';
import 'package:untitledretrant/providers/language_provider.dart';
import 'package:untitledretrant/providers/theme_provider.dart';
import 'package:untitledretrant/wigdets/MainDrawer.dart';
import 'Favourite.dart';
import 'categories.dart';
import 'package:untitledretrant/providers/meal_provider.dart';
import 'package:provider/provider.dart';
class TabsScreen extends StatefulWidget {
static const routeName="tabs_screen";
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  List pages;
int pageindex=0;

@override
  void initState() {
  Provider.of<MealProvider>(context, listen: false).getDate();
  Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
  Provider.of<ThemeProvider>(context, listen: false).getcolor();
  Provider.of<LanguageProvider>(context, listen: false).getLan();
  super.initState();
}

  void selectpage(int value) {
    setState(() {
      pageindex=value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var len=Provider.of<LanguageProvider>(context,listen: true);
    pages=[

      {
        'page':Categories(),
        'title':len.getTexts('categories')
      },
      {
        'page':Favourite(),
        'title':len.getTexts('your_favorites')
      },
    ];
    return Directionality(
      textDirection: len.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pages[pageindex]['title']),
        ),
        body: pages[pageindex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: selectpage,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: pageindex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text(len.getTexts('categories')),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text(len.getTexts('your_favorites')),
            ),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }


}
