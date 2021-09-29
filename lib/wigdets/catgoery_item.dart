import 'package:flutter/material.dart';
import 'package:untitledretrant/screens/Catagorymealscreen.dart';
import 'package:provider/provider.dart';
import 'package:untitledretrant/providers/language_provider.dart';

class CatgoeryItem   extends StatelessWidget {
  final String id;

  final Color color;

  CatgoeryItem(this.id,  this.color);
  void Selectsreen(BuildContext ctx){
    Navigator.of(ctx).pushNamed(Catagorymealscreen.routname,
      arguments: {
      'id':id,

      }
    );
  }


  @override
  Widget build(BuildContext context) {
    var len=Provider.of<LanguageProvider>(context,listen: true);
    return InkWell(
      onTap: () =>Selectsreen(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(len.getTexts('cat-$id'),style:Theme.of(context).textTheme.headline6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
