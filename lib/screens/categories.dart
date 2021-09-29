import 'package:flutter/material.dart';
import 'package:untitledretrant/providers/meal_provider.dart';
import '../wigdets/catgoery_item.dart';

import 'package:provider/provider.dart';
class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GridView(
        padding: EdgeInsets.all(15),
        children: Provider.of<MealProvider>(context,listen:false).avableCatogery
          .map((e) =>
            CatgoeryItem (e.id,e.color)
        ).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),

      ),
    );
  }
}
