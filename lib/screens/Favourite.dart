
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitledretrant/models/meal.dart';
import 'package:untitledretrant/providers/meal_provider.dart';
import 'package:untitledretrant/wigdets/mealitem.dart';
class Favourite  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var ds=MediaQuery.of(context).size.width;
    bool isLandscape= MediaQuery.of(context).orientation==Orientation.landscape;
    final   List<Meal> Favourute=Provider.of<MealProvider>(context,listen: true).Favourute ;
    if(Favourute.isEmpty){
      return Center(
        child: Text("Empty Favourite"),
      );
    }
    else{
     return  GridView.builder(
       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
         maxCrossAxisExtent: ds<=400?400:500 ,
         childAspectRatio:isLandscape? ds/(ds*0.8):ds/(ds *0.75),
         crossAxisSpacing: 0,
         mainAxisSpacing: 0,
       ),
        itemBuilder: (ctx,index){
          return Mealitem(
            hassid:Favourute[index].id,
            imageui: Favourute[index].imageUrl,
            duration: Favourute[index].duration,
            complexity: Favourute[index].complexity,
            affordability:Favourute[index].affordability,

          );
        },
        itemCount: Favourute.length,
      );
    }
  }
}
