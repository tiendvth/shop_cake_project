import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/src/detail_food/ui/detail_food_page.dart';
import 'package:shop_cake/src/home_page/components/categorries.dart';
import 'package:shop_cake/src/list_food/bloc/list_food_cubit.dart';
import 'package:shop_cake/src/list_food/components/item_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ListFoodCubit listFoodCubit = ListFoodCubit();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 210.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Categories(

          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Sản phẩm hót nhất",
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<ListFoodCubit, ListFoodState>(
                  builder: (context, state) {
                    if (state is ListFoodSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GridView.custom(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.7,
                            ),
                            childrenDelegate: SliverChildBuilderDelegate(
                              (context, index) => ItemCard(
                                isPromotion: true,
                                addToCart: () {
                                  listFoodCubit.addFoodToOrder(
                                    context,
                                    cakeId: state.data['result'][index]
                                        ['cakeId'],
                                    quantity: state.data['result'][index]
                                            ['quantity'] ??
                                        1,
                                  );
                                },
                                onTap: () {
                                  NavigatorManager.pushFullScreen(
                                      context,
                                      DetailFood(
                                        id: state.data['result'][index]['id'] ??
                                            '',
                                        detail: state.data['result'][index],
                                      ));
                                },
                              ),
                              childCount: state.data['result'].length,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
