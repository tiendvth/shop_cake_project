import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/detail_food/bloc/counter_bloc/count_dish_cubit.dart';
import 'package:shop_cake/src/detail_food/bloc/detail_food_bloc/detail_food_cubit.dart';
import 'package:shop_cake/src/detail_food/repository/repository.dart';
import 'package:shop_cake/validation/validation.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class DetailFood extends StatelessWidget {
  final id;

  DetailFood({
    Key? key,
    required this.id,
  }) : super(key: key);

  final CountDishCubit _countDishCubit = CountDishCubit();

  @override
  Widget build(BuildContext context) {
    final detailFoodCubit =
        DetailFoodCubit(DetailFoodRepositoryImpl(apiProvider), id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FontColor.colorFF3366,
        title: Text('Chi tiết'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => detailFoodCubit,
            ),
            BlocProvider(
              create: (_) => CountDishCubit(),
            ),
          ],
            child: BlocBuilder<DetailFoodCubit, DetailFoodState>(
            builder: (context, state) {
              if (state is DetailFoodSuccess) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: double.infinity,
                            child: ImageSlideshow(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 3,
                              initialPage: 0,
                              indicatorColor: Colors.blue,
                              indicatorBackgroundColor: Colors.grey,
                              autoPlayInterval: 3000,
                              isLoop: true,
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                    '${state.data['data']['images']??'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1600'}',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          20.spaceHeight,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.data['data']['name'] ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                15.spaceHeight,
                                const Text(
                                  'Mô tả',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Text(
                                  '${state.data['data']['description'] ?? 'Chưa có'}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                                15.spaceHeight,
                                const Text(
                                  'Giá',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                10.spaceHeight,
                                Text(
                                  '${Validation.oCcy.format(state.data['data']['price'] ?? 0)} đ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: FontColor.colorEC222D),
                                ),
                                15.spaceHeight,
                                const Text(
                                  'Số lượng',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                BlocBuilder(
                                  bloc: _countDishCubit,
                                  builder: (context, state) {
                                    if (state is CountDishCount) {
                                      _countDishCubit.count_dish =
                                          state.count ?? 0;
                                    }
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${_countDishCubit.count_dish}  item',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.redAccent),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  _countDishCubit.prisonDish();
                                                  detailFoodCubit.quantity =
                                                      _countDishCubit.count_dish;
                                                },
                                                icon: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  _countDishCubit.addDish();
                                                  detailFoodCubit.quantity =
                                                      _countDishCubit.count_dish;
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      child: Align(
                        alignment: Alignment.topLeft,
                        // child: IconButton(
                        //   onPressed: () {
                        //     Navigator.pop(context);
                        //   },
                        //   icon: const Icon(
                        //     Icons.arrow_back,
                        //     color: Colors.red,
                        //   ),
                        // ),
                      ),
                    ),
                    BlocBuilder(
                      bloc: _countDishCubit,
                      builder: (context, state) {
                        if (state is CountDishCount) {
                          _countDishCubit.count_dish = state.count ?? 0;
                        }
                        return Positioned(
                          bottom: 24,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: MaterialButton(
                                height: 50,
                                minWidth: MediaQuery.of(context).size.width - 20,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                color: Colors.redAccent,
                                onPressed: () {
                                  detailFoodCubit.addFoodToOrder(context, id);
                                },
                                child: const Text(
                                  'Thêm vào giỏ hàng',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
      )),
    );
  }
}
