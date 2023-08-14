import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/config/format_price.dart';
import 'package:shop_cake/common/config/string_service.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/detail_food/bloc/counter_bloc/count_dish_cubit.dart';
import 'package:shop_cake/src/detail_food/bloc/detail_food_bloc/detail_food_cubit.dart';
import 'package:shop_cake/src/detail_food/repository/repository.dart';
import 'package:shop_cake/src/favourite/bloc/favourite_cubit.dart';
import 'package:shop_cake/utils/utils.dart';
import 'package:shop_cake/widgets/space_extention.dart';

import '../../../common/config_read_file.dart';

class DetailFood extends StatelessWidget {
  final id;
  final detail;
  double priceDiscount = 0.0;

  DetailFood({Key? key, required this.id, required this.detail})
      : super(key: key);

  final CountDishCubit _countDishCubit = CountDishCubit();
  final favouriteCubit = FavouriteCubit();
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    final detailFoodCubit =
        DetailFoodCubit(DetailFoodRepositoryImpl(apiProvider), id);
    double price;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainWhiteColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: kBgMenu,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kMainDarkColor,
          ),
        ),
        title: Text(
          'Chi tiết sản phẩm',
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: kMainDarkColor,
            ),
          ),
        ),
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
              if (state.data['data']['discount'] != null) {
                priceDiscount = state.data['data']['discount'];
                price = DiscountCake.discountCake(
                    state.data['data']['discount'],
                    state.data['data']['price']);
              } else {
                price =
                    DiscountCake.discountCake(0.0, state.data['data']['price']);
              }
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3.5,
                              width: double.infinity,
                              child: ImageSlideshow(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 3,
                                initialPage: 0,
                                indicatorColor: kMainRedColor.withOpacity(0.5),
                                indicatorBackgroundColor: Colors.grey,
                                autoPlayInterval: 3000,
                                indicatorRadius: 3.0,
                                isLoop: true,
                                children: [
                                  ClipRRect(
                                    child: Image.network(
                                      // '${state.data['data']['images']??'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1600'}',
                                      // 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1600',
                                      ReadFile.readFile(
                                          state.data['data']['image']),
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  ClipRRect(
                                    child: Image.network(
                                      // '${state.data['data']['images']??'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1600'}',
                                      ReadFile.readFile(
                                          state.data['data']['image']),
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  ClipRRect(
                                    child: Image.network(
                                      // '${state.data['data']['images']??'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1600'}',
                                      ReadFile.readFile(
                                          state.data['data']['image']),
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: kMainDarkGreyColor.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: isFavourite ? IconButton(
                                  onPressed: () {
                                    favouriteCubit.removeFavourite(
                                        id: state.data['data']['id']);
                                  },
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: kTextColor,
                                  ),
                                ) : IconButton(
                                  onPressed: () {
                                    favouriteCubit.addFavourite(
                                        id: state.data['data']['id']);
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: kMainRedColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        20.spaceHeight,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${state.data['data']['name'] ?? ''}',
                                // '{state.data.name}',
                                style: GoogleFonts.roboto(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: kF2F4B4E,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                              16.spaceHeight,
                              Text(
                                'Mô tả sản phẩm:',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: kF2F4B4E,
                                ),
                              ),
                              10.spaceHeight,
                              Text(
                                '${state.data['data']['note'] ?? 'Chưa có'}',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: k9B9B9B,
                                ),
                              ),
                              state.data['data']['discount'] != null
                                  ? Column(
                                      children: [
                                        14.spaceHeight,
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Giá: ',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: kF2F4B4E,
                                                ),
                                              ),
                                              TextSpan(
                                                text: FormatPrice.formatVND(
                                                    state.data['data']
                                                        ['price']),
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: kMainBlackColor,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        10.spaceHeight,
                                      ],
                                    )
                                  : Container(),
                              state.data['data']['discount'] != null
                                  ? Row(
                                      children: [
                                        Image.asset(
                                          Assets.icSaleFire,
                                          height: 24,
                                          width: 24,
                                        ),
                                        10.spaceWidth,
                                        Text(
                                          'Sale ${StringService.formatDiscount(state.data['data']['discount'] ?? '0')}%',
                                          style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: kMainRedColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              10.spaceHeight,
                              Row(
                                children: [
                                  state.data['data']['discount'] != null
                                      ? Text(
                                          'Giá khuyến mãi:',
                                          style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: kF2F4B4E,
                                          ),
                                        )
                                      : Text(
                                          'Giá:',
                                          style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: kF2F4B4E,
                                          ),
                                        ),
                                  10.spaceWidth,
                                  Expanded(
                                    child: Text(
                                      FormatPrice.formatVND(
                                          DiscountCake.discountCake(
                                              priceDiscount,
                                              state.data['data']['price'])),
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kMainRedColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              15.spaceHeight,
                              Text(
                                'Số lượng',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: kF2F4B4E,
                                ),
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
                                        '${_countDishCubit.count_dish}  sản phẩm',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: kMainRedColor,
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: kFFA6BD,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  _countDishCubit.prisonDish();
                                                  detailFoodCubit.quantity =
                                                      _countDishCubit
                                                          .count_dish;
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  _countDishCubit.addDish();
                                                  detailFoodCubit.quantity =
                                                      _countDishCubit
                                                          .count_dish;
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
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
                              height: 44,
                              minWidth: MediaQuery.of(context).size.width - 20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: kFFA6BD,
                              onPressed: () async {
                                await detailFoodCubit.addFoodToOrder(
                                    context, id, price);
                                print(price);
                                closeLoading(context);
                              },
                              child: Text(
                                'Thêm vào giỏ hàng',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
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
