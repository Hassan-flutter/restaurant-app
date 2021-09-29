import 'package:flutter/material.dart';
import 'package:untitledretrant/models/meal.dart';
import 'package:untitledretrant/wigdets/mealitem.dart';
import 'package:untitledretrant/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import 'package:untitledretrant/providers/language_provider.dart';

class Catagorymealscreen extends StatefulWidget {
  static const routname='catagory_meals';


  @override
  _CatagorymealscreenState createState() => _CatagorymealscreenState();
}

class _CatagorymealscreenState extends State<Catagorymealscreen> {

String Idgood;
List<Meal> displayMeals;
@override
  void didChangeDependencies() {
  final List<Meal> avabelMeals=Provider.of<MealProvider>(context,listen: true).avabelMeals;
  final routarg12 = ModalRoute
      .of(context)
      .settings
      .arguments as Map<String, String>;
    Idgood = routarg12['id'];
  displayMeals = avabelMeals.where((haser) {
    return haser.categories.contains(Idgood);
  }).toList();
    super.didChangeDependencies();
  }



  void removeid(String hassanid){
     setState(() {
       displayMeals.removeWhere((element) => element.id==hassanid) ;
     });
  }
  @override
  Widget build(BuildContext context) {
    var len=Provider.of<LanguageProvider>(context,listen: true);
bool isLandscape= MediaQuery.of(context).orientation==Orientation.landscape;
var ds=MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: len.isEn  ? TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(len.getTexts('cat-$Idgood'))
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: ds<=400?400:500 ,
            childAspectRatio:isLandscape? ds/(ds*0.8):ds/(ds *0.75),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
            itemBuilder: (ctx,index){
              return Mealitem(
                hassid:displayMeals[index].id,
                imageui: displayMeals[index].imageUrl,
                duration: displayMeals[index].duration,
                complexity: displayMeals[index].complexity,
                affordability:displayMeals[index].affordability,
              );
            },
          itemCount: displayMeals.length,
        ),

      ),
    );
  }
}

