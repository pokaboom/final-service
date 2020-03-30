import 'package:flutter/material.dart';
import '../item.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import '../bloc/cartlistBloc.dart';
import '../model/food_item.dart';
class Denting extends StatefulWidget {
  @override
  _DentingState createState() => _DentingState();
}

class _DentingState extends State<Denting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){Navigator.pop(context);},
        ),
        title: Text(
          'Denting/Painting',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          scrollDirection: Axis.vertical,

          children: <Widget>[
            for (var foodItem in denting.foodItems)
              Builder(
                builder: (context) {
                  return ItemContainer(foodItem: foodItem);
                },
              )
          ],
        ),
      ),
    );
  }
}

class ItemContainer extends StatelessWidget {

  ItemContainer({
    @required this.foodItem,
  });

  final FoodItem foodItem;
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();


  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  removeFromList(FoodItem foodItem) {
    bloc.removeFromList(foodItem);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(foodItem);
        final snackBar = SnackBar(
          content: Text('${foodItem.title} added to Cart'),
          duration: Duration(milliseconds: 550),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Items(
        hotel: foodItem.hotel,
        itemName: foodItem.title,
        itemPrice: foodItem.price,
        imgUrl: foodItem.imgUrl,
        leftAligned: (foodItem.id % 2) == 0 ? true : false,
      ),
    );
  }
}