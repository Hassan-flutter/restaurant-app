import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitledretrant/models/meal.dart';
import 'package:untitledretrant/screens/Meal_detial.dart';
import 'package:provider/provider.dart';
import 'package:untitledretrant/providers/language_provider.dart';


class Mealitem extends StatelessWidget {
   final String hassid;
  final String imageui;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;


  const Mealitem({
    @required this.hassid,
    @required this.imageui,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,

  });




  void selecthassan(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(Mealdatials.routname,
        arguments: hassid
         ).then((val) {
        //   if(val!=null) removeItem(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    var len=Provider.of<LanguageProvider>(context,listen: true);
    return InkWell(
      onTap: () => selecthassan(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Hero(
                      tag: hassid,
                      child: InteractiveViewer(
                          child: FadeInImage(
                            width: double.infinity,
                              placeholder: AssetImage('assets/images/a2.png'),
                              image: NetworkImage(imageui
                              ),
                              fit: BoxFit.cover
                          ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 300,
                      color: Colors.black54,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        len.getTexts("meal-$hassid"),
                        style: TextStyle(fontSize: 26, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule,color: Theme.of(context).buttonColor),
                      SizedBox(width: 6),
                      if(duration <=10)
                      Text(
                        "$duration"+ len.getTexts("min2"),
                      ),
                      if(duration > 10)
                      Text(
                        "$duration"+ len.getTexts("min"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work,color: Theme.of(context).buttonColor),
                      SizedBox(width: 6),
                      Text(
                       len.getTexts('$complexity')
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money,color: Theme.of(context).buttonColor),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        len.getTexts('$affordability'),

                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
