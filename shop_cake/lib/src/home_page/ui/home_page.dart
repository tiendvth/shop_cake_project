import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/src/home_page/components/body.dart';
import 'package:shop_cake/src/home_page/components/upper_body.dart';
import 'package:shop_cake/src/list_food/bloc/category_cubit.dart';
import 'package:shop_cake/src/list_food/bloc/list_food_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ListFoodCubit listFoodCubit = ListFoodCubit();
  final CategoryCubit categoryCubit = CategoryCubit();

  @override
  void initState() {
    super.initState();
    listFoodCubit.getListFood(listFoodCubit.searchController.text);
    categoryCubit.getCategory();
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
      ],
      child: Scaffold(
        backgroundColor: kBackground,
        body: Stack(
          children: const [
            UpperBody(),
            Body(),
          ],
        ),
      ),
    );
  }
}