import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/custom_widgets/big_text.dart';
import 'package:food_delivery_app_one/custom_widgets/food_page_body.dart';
import 'package:food_delivery_app_one/custom_widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            /// Header & Location
            Container(
              padding: const EdgeInsets.only(
                  top: 50, left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Location
                  Column(
                    children: [
                      BigText(
                        text: 'Bangladesh',
                        color: Colors.blue[200],
                      ),
                      Row(
                        children: const [
                          SmallText(text: 'Narsingdi'),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ],
                  ),

                  /// Search Bar
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(08),
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  )
                ],
              ),
            ),

            /// Popular & Recommended Food List
            Expanded(
              child: SingleChildScrollView(
                child: FoodPageBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
