import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/%20config/format_price.dart';
import 'package:shop_cake/common/badge_widget.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/cart_page/bloc/list_card_bloc/list_card_cubit.dart';
import 'package:shop_cake/src/cart_page/componenst/appbar_cart_widget.dart';
import 'package:shop_cake/src/cart_page/componenst/cart_item.dart';
import 'package:shop_cake/src/cart_page/repository/cart_repository.dart';
import 'package:shop_cake/src/detail_food/bloc/counter_bloc/count_dish_cubit.dart';
import 'package:shop_cake/src/payment/ui/payment_page.dart';
import 'package:shop_cake/widgets/c_image.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class CartPage extends StatefulWidget {
  final bool? isShowIconBack;

  const CartPage({Key? key, this.isShowIconBack}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final listCardCubit = ListCardCubit(CartRepositoryImpl(apiProvider));
  final CountDishCubit _countDishCubit = CountDishCubit();

  @override
  void initState() {
    super.initState();
    listCardCubit.getListCart();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => listCardCubit,
        ),
        BlocProvider(
          create: (_) => _countDishCubit,
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: false,
          bottom: true,
          child: BlocBuilder<ListCardCubit, ListCardState>(
            builder: (context, stateListCake) {
              if (stateListCake is ListCardSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 180,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            gradient: kBgMenu,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(24,
                                  AppBar().preferredSize.height + 15, 24, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (widget.isShowIconBack == true) ...[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: kMainRedColor.withOpacity(0.6),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Giỏ hàng",
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: kMainDarkColor,
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                  if (widget.isShowIconBack == false) ...[
                                    Expanded(
                                      child: Text(
                                        "Giỏ hàng",
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: kMainDarkColor,
                                          ),
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                  Badge(
                                    value: '3',
                                    child: InkWell(
                                      onTap: () {},
                                      child: const CImage(
                                        assetsPath: Assets.icNotification,
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              24, AppBar().preferredSize.height + 65, 24, 0),
                          child: Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FontColor.colorFFFFFF,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Giá tiền',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: k514D56,
                                        ),
                                      ),
                                      Text(
                                        // text: '${state.totalPrice}',
                                        '0đ',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: k514D56,
                                        ),
                                      ),
                                    ],
                                  ),
                                  5.spaceHeight,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // text: '${state.totalPrice}',
                                        'Phí giao hàng',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: k514D56,
                                        ),
                                      ),
                                      Text(
                                        // text: '${state.totalPrice}',
                                        '0đ',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: k514D56,
                                        ),
                                      ),
                                    ],
                                  ),
                                  5.spaceHeight,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // text: '${state.totalPrice}',
                                        'Phí dich vụ khác',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: k514D56,
                                        ),
                                      ),
                                      Text(
                                        // text: '${state.totalPrice}',
                                        '0đ',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: k514D56,
                                        ),
                                      ),
                                    ],
                                  ),
                                  10.spaceHeight,
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: FontColor.colorBorder,
                                  ),
                                  10.spaceHeight,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // text: '${state.totalPrice}',
                                        'Tổng tiền',
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: kMainRedColor,
                                        ),
                                      ),
                                      Text(
                                        // text: '${state.totalPrice}',
                                        '0đ',
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: kMainRedColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.spaceHeight,
                    Expanded(
                      child: SingleChildScrollView(
                        child: stateListCake.data.isNotEmpty ||
                                listCardCubit.datas.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                itemBuilder: (context, index) {
                                  // print(state.data[index]['quantity']);
                                  return Column(
                                    children: [
                                      Slidable(
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          extentRatio: 0.5,
                                          children: [
                                            SlidableAction(
                                              onPressed:
                                                  (BuildContext context) {
                                                listCardCubit.removeFood(
                                                    context,
                                                    stateListCake.data[index]
                                                        ['shoppingCartTmtId']);
                                              },
                                              backgroundColor: kMainRedColor
                                                  .withOpacity(0.6),
                                              foregroundColor: Colors.white,
                                              icon:
                                                  Icons.delete_forever_rounded,
                                              label: 'Xóa',
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            SlidableAction(
                                              onPressed: null,
                                              backgroundColor:
                                                  const Color(0xFF21B7CA),
                                              foregroundColor: Colors.white,
                                              icon: Icons.clear,
                                              label: 'Đóng',
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ],
                                        ),
                                        child: CartItem(
                                          quantity: stateListCake.data[index]
                                          ['quantityShoppingCartTmt'],
                                          name: stateListCake.data[index]['nameCake'],
                                          price: FormatPrice.formatVND(
                                              stateListCake.data[index]['priceCake']),
                                          imageUrl: stateListCake.data[index]
                                          ['imageCake'],
                                          onTapAdd: () {
                                            final count =
                                            stateListCake.data[index]['quantity'];
                                            final quantity = count + 1;
                                            listCardCubit.addFood(
                                                context,
                                                // state.data[index]['id'],
                                                1,
                                                quantity);
                                          },
                                          onTapMinus: () {
                                            final count =
                                            stateListCake.data[index]['quantity'];
                                            final quantity = count - 1;
                                            if (quantity == 0) {
                                              listCardCubit.removeFood(
                                                  context,
                                                  // state.data[index]['id']
                                                  1);
                                            } else {
                                              listCardCubit.addFood(
                                                  context,
                                                  stateListCake.data[index]
                                                  ['quantity'],
                                                  quantity);
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  );
                                },
                                itemCount: stateListCake.data.length ?? 0,
                                shrinkWrap: true,
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    top: 100, right: 16, left: 16),
                                child: Center(
                                  child: Text(
                                    'Không có sản phẩm nào trong giỏ hàng',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: k9B9B9B,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              } else if (stateListCake is ListCardLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (stateListCake is ListCardFailure) {
                return const AppbarCartWidget();
              } else {
                return const AppbarCartWidget();
              }
            },
          ),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: FloatingActionButton(
            backgroundColor: Colors.pink,
            child: const Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              if (listCardCubit.datas.length > 0) {
                NavigatorManager.pushFullScreen(context, PaymentPage(
                  callback: () async {
                    await listCardCubit.getListCart();
                    listCardCubit.datas.clear();
                  },
                )).then((value) {
                  listCardCubit.getListCart();
                });
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
