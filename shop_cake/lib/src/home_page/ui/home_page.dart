import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/home_page/bloc/home_cubit.dart';
import 'package:shop_cake/src/home_page/components/body.dart';
import 'package:shop_cake/src/home_page/components/upper_body.dart';
import 'package:shop_cake/src/list_food/bloc/category_cubit.dart';
import 'package:shop_cake/src/list_food/bloc/list_food_cubit.dart';
import 'package:shop_cake/src/list_food/bloc/list_price_filter_cubit.dart';

import '../../../common/ config/format_price.dart';
import '../../list_food/components/dialog_filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ListFoodCubit listFoodCubit = ListFoodCubit();
  final CategoryCubit categoryCubit = CategoryCubit();
  final HomeCubit homeCubit = HomeCubit();
  final ListPriceFilterCubit listPriceFilterCubit = ListPriceFilterCubit();
  final controller = GroupButtonController();
  final priceFilterCubit = ListPriceFilterCubit();
  int? priceFrom = 0;
  int? priceTo = 0;
  String? search = '';

  @override
  void initState() {
    super.initState();
    listFoodCubit.getListFood(search, priceFrom, priceTo);
    // listFoodCubit.getListFood(search, priceFrom, priceTo);
    categoryCubit.getCategory();
    listPriceFilterCubit.listPriceFilter();
    // homeCubit.getAllPromotions(search, priceFrom, priceTo);
    _refresh();
  }

  Future<void> _refresh() async {
    listFoodCubit.getListFood(
      listFoodCubit.searchController.text,
      priceFrom,
      priceTo,
    );
    priceFilterCubit.listPriceFilter();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => listFoodCubit,
        ),
        BlocProvider(
          create: (context) => categoryCubit,
        ),
        BlocProvider(create: (context) => listPriceFilterCubit
        ),
        BlocProvider(create: (context) => homeCubit
        )
      ],
      child: Scaffold(
        backgroundColor: kBackground,
        body: Stack(
          children: [
            BlocBuilder<ListPriceFilterCubit, ListPriceFilterState>(
              builder: (context, statePrice){
                if (statePrice is ListPriceFilterSuccess){
                  return UpperBody(
                    onTap: (){
                      print('Tap icon fillter');
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogFilter(
                            child: Container(
                              height: 380,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: GroupButton(
                                controller: controller,
                                buttons: statePrice.data
                                    .map((e) =>
                                '${FormatPrice.formatPriceToInt(e.priceFrom)} - ${FormatPrice.formatPriceToInt(e.priceTo)}')
                                    .toList(),
                                onSelected: (index, value, isSelected) {
                                  priceFrom =
                                      statePrice.data[value].priceFrom;
                                  priceTo =
                                      statePrice.data[value].priceTo;
                                },
                                options: GroupButtonOptions(
                                  spacing: 8,
                                  unselectedTextStyle:
                                  GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  groupRunAlignment:
                                  GroupRunAlignment.start,
                                  unselectedColor: Colors.white,
                                  selectedColor: kMainDarkColor,
                                  selectedTextStyle: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  textAlign: TextAlign.center,
                                  buttonWidth: MediaQuery.of(context)
                                      .size
                                      .width /
                                      2 -
                                      56,
                                  runSpacing: 8,
                                  direction: Axis.horizontal,
                                ),
                              ),
                            ),
                            onTap: () {
                              print('tap popup');
                              listFoodCubit.getListFood(
                                search,
                                priceFrom,
                                priceTo,
                              );
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                  );
                }else{
                  return SizedBox();
                }
              },

            ),
            BlocBuilder<ListFoodCubit, ListFoodState>(
              builder: (context, state){
                if (state is ListFoodSuccess){
                  print(state.data);
                  return Body(
                    data: state.data,
                  );
                }else {
                  return SizedBox();
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}