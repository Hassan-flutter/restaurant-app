
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:untitledretrant/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:untitledretrant/dummy_data.dart';
import 'package:untitledretrant/providers/meal_provider.dart';
import 'package:provider/provider.dart';
class Mealdatials extends StatefulWidget {
  static const routname='Meal_deatial';

  @override
  _MealdatialsState createState() => _MealdatialsState();
}

class _MealdatialsState extends State<Mealdatials> {
  Widget buildtilte(BuildContext ctx,String textt){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(textt,style: Theme.of(ctx).textTheme.headline6,textAlign: TextAlign.center),
    );
  }

  Widget buildcontainer(Widget child){
    var ds=MediaQuery.of(context).size.width;
    var dh=MediaQuery.of(context).size.height;
    bool isLandscape= MediaQuery.of(context).orientation==Orientation.landscape;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: isLandscape ?dh*0.5:dh*0.25 ,
      width: isLandscape ?(ds*0.5-30):ds,
      child: child,
    );
  }
  String hassnid;
  @override
  void didChangeDependencies() {
    hassnid = ModalRoute.of(context).settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var len=Provider.of<LanguageProvider>(context,listen: true);
    bool isLandscape= MediaQuery.of(context).orientation==Orientation.landscape;
    final selectgood=DUMMY_MEALS.firstWhere((element) => element.id==hassnid);
     var accentcloo= Theme.of(context).buttonColor;
     List<String> stephassan= len.getTexts('steps-$hassnid') as List<String>;
     var stepsli=ListView.builder(
       padding: EdgeInsets.all(0),
       itemBuilder: (ctx,index)=> Column(
         children: [
           ListTile(
             leading:CircleAvatar(
               backgroundColor: Colors.black,
               child: Text("# ${index+1}"),
             ) ,
             title: Text(stephassan[index],style: TextStyle(color: Colors.black),),
           ),
           Divider(),
         ],
       ),
       itemCount: stephassan.length,
     );
     List <String> lnIngredients=len.getTexts('ingredients-$hassnid') as List<String>;
     var Interghass=ListView.builder(
       padding: EdgeInsets.all(0),
       itemBuilder: (ctx,index)=>Card(
         color: accentcloo,
         child: Padding(
           padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
           child: Text(lnIngredients[index],style: TextStyle(
               color:  Colors.white,
           ),
           ),
         ),
       ),
       itemCount: lnIngredients.length,
     );
    return Directionality(
      textDirection: len.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(len.getTexts('meal-$hassnid')),
                background: Hero(tag: hassnid ,
                    child: InteractiveViewer(
                        child: FadeInImage(
                            placeholder: AssetImage('assets/images/a2.png'),
                            image: NetworkImage(selectgood.imageUrl,
                            ),
                            fit: BoxFit.cover
                        ))),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              if(isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        buildtilte(context, len.getTexts("Ingredients")),
                        buildcontainer(Interghass),
                      ],
                    ),
                    Column(
                      children: [
                        buildtilte(context, len.getTexts("Steps")),
                        buildcontainer(stepsli),
                      ],
                    )
                  ],
                ),
              if(! isLandscape) buildtilte(context, len.getTexts("Ingredients")),
              if(! isLandscape) buildcontainer(Interghass),
              if(! isLandscape) buildtilte(context, len.getTexts("Steps")),
              if(! isLandscape) buildcontainer(stepsli),

            ],),),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:()=>Provider.of<MealProvider>(context,listen: false).selectfavourite(hassnid),
          child: Icon(
              Provider.of<MealProvider>(context,listen: true).isfavourite(hassnid)? Icons.star :Icons.star_border
        ),
        ),
      ),
    );
  }
}
