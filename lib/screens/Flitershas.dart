import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitledretrant/providers/language_provider.dart';
import 'package:untitledretrant/wigdets/MainDrawer.dart';
import 'package:untitledretrant/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class Fliters extends StatelessWidget {
  static const routeName = '/fliters';
  final bool fromOnBording;

  Fliters({this.fromOnBording=false });





  Widget bulidswitchTile(
      String title, String desrbtion, bool currentvaule, Function update) {
    return SwitchListTile(
      title: Text(title),
      value: currentvaule,
      subtitle: Text(desrbtion),
      onChanged: update,
      inactiveTrackColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    var len=Provider.of<LanguageProvider>(context,listen: true);
    final Map <String,bool> currentfliters=Provider.of<MealProvider>(context,listen: true).filters;
    return Directionality(
      textDirection: len.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(


        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              title: fromOnBording ?null:Text(len.getTexts('filters_appBar_title')),
              backgroundColor:fromOnBording ? Theme.of(context).canvasColor:Theme.of(context).primaryColor,
              elevation: fromOnBording ?0:5 ,
            ),
            SliverList(delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.all(20),
                child: Text(len.getTexts('filters_screen_title'),
                    style: Theme.of(context).textTheme.headline6,textAlign: TextAlign.center),
              ),

                    bulidswitchTile(
                      len.getTexts('Gluten-free'),
                      len.getTexts('Gluten-free-sub'),
                      currentfliters['gluten'],
                          (newvalue) {
                       currentfliters['gluten']=newvalue ;
                        Provider.of<MealProvider>(context,listen: false).setfliters();
                      },
                    ),
                    bulidswitchTile(
                      len.getTexts('Lactose-free'),
                      len.getTexts('Lactose-free_sub'),
                      currentfliters['lactose'],
                          (newvalue) {
                       currentfliters['lactose']=newvalue;
                        Provider.of<MealProvider>(context,listen: false).setfliters();
                      },
                    ),
                    bulidswitchTile(
                      len.getTexts('Vegetarian'),
                      len.getTexts('Vegetarian-sub'),
                      currentfliters['vegetarian'],
                          (newvalue) {
                        currentfliters['vegetarian']=newvalue ;
                        Provider.of<MealProvider>(context,listen: false).setfliters();
                      },
                    ),
                    bulidswitchTile(
                      len.getTexts('Vegan'),
                      len.getTexts('Vegan-sub'),
                      currentfliters['vegan'],
                          (newvalue) {
                        currentfliters['vegan']=newvalue ;
                        Provider.of<MealProvider>(context,listen: false).setfliters();
                      },

                    ),
              SizedBox(height:  fromOnBording ? 80:0)
            ],),),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
