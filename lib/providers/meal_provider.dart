
import 'package:flutter/material.dart';
import 'package:untitledretrant/models/catogey.dart';
import 'package:untitledretrant/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';

class MealProvider with ChangeNotifier{
  Map<String,bool> filters={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };


  List<Meal> avabelMeals=DUMMY_MEALS;
  List<Meal>Favourute=[];
  List<String> perfsMealId=[];
   List <Catogery> avableCatogery= DUMMY_CATEGORIES;
  void setfliters() async{

      avabelMeals=DUMMY_MEALS.where((meal) {
        if(filters['gluten']&& !meal.isGlutenFree){
          return false ;
        };
        if(filters['lactose']&& !meal.isLactoseFree){
          return false ;
        };
        if(filters['vegan']&& !meal.isVegan){
          return false ;
        };
        if(filters['vegetarian']&& !meal.isVegetarian){
          return false ;
        };
        return true;
      }).toList();

      List <Catogery> ac=[];
      avabelMeals.forEach((meal) {
        meal.categories.forEach((catId) {
          DUMMY_CATEGORIES.forEach((cat) {
            if(cat.id==catId) {
              if(! ac.any((cat) => cat.id==catId)) ac.add(cat);
            }
          });
        });
      });
      avableCatogery= ac;
      notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("gluten", filters['gluten']);
      prefs.setBool("lactose", filters['lactose']);
      prefs.setBool("vegan", filters['vegan']);
      prefs.setBool("vegetarian", filters['vegetarian']);

        }
   void getDate()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten']= prefs.getBool("gluten") ?? false;
    filters['lactose']=  prefs.getBool("lactose")?? false;
    filters['vegan']= prefs.getBool("vegan")?? false;
    filters['vegetarian']=  prefs.getBool("vegetarian")?? false;
    setfliters();
     perfsMealId=prefs.getStringList("perfsMealId")??[];

    for(var mealid in perfsMealId){
      final extingindex=Favourute.indexWhere((element) => element.id==mealid);
     if(extingindex < 0 ){
       Favourute.add(DUMMY_MEALS.firstWhere((element) => element.id==mealid));
     }

    }
    List <Meal> fn=[];
    Favourute.forEach((Favouruteid) {
      avabelMeals.forEach((avabelMealsid) {
        if(Favouruteid.id==avabelMealsid.id) fn.add(Favouruteid) ;
      });
    });
    Favourute=fn;
    notifyListeners();
  }

  void selectfavourite(String mealid)async{

    final extingindex=Favourute.indexWhere((element) => element.id==mealid);
    if(extingindex>=0){
        Favourute.removeAt(extingindex);
        perfsMealId.remove(mealid);
    }
    else{
        Favourute.add(DUMMY_MEALS.firstWhere((element) => element.id==mealid));
        perfsMealId.add(mealid);
    }

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("perfsMealId", perfsMealId);
  }
  bool isfavourite(String mealid){
   return Favourute.any((element) => element.id==mealid);
  }
  }
