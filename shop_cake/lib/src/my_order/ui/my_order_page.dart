import 'package:common/common.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/common/config/format_date.dart';
import 'package:shop_cake/common/enum/status_ship_enum.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/detail_my_order/ui/detail_my_order_page.dart';
import 'package:shop_cake/src/my_order/bloc/my_order_cubit.dart';
import 'package:shop_cake/src/my_order/components/my_order_item.dart';
import 'package:shop_cake/src/my_order/repository/repository.dart';
import 'package:shop_cake/widgets/c_image.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  final myOrderCubit = MyOrderCubit(MyOderRepositoryImpl(apiProvider));

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    myOrderCubit.getListOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Đơn hàng của tôi',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kMainRedColor,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
            child: InkWell(
              onTap: () {},
              child: const CImage(
                assetsPath: Assets.icNotification,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocProvider(
          create: (BuildContext context) => myOrderCubit,
          child: BlocBuilder<MyOrderCubit, MyOrderState>(
            builder: (context, stateOrder) {
              if (stateOrder is MyOrderSuccess) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 15),
                      height: 35,
                      padding:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: kMainRedColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          alignment: Alignment.centerLeft,
                          buttonPadding: EdgeInsets.zero,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          hint: Text(
                            'Select Item',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: kMainRedColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          items: context
                              .read<MyOrderCubit>()
                              .items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: kMainRedColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: context.read<MyOrderCubit>().selectedValue,
                          onChanged: (value) {
                            context.read<MyOrderCubit>().selectedValue =
                                value as String;
                            context.read<MyOrderCubit>().selectIndex = context
                                    .read<MyOrderCubit>()
                                    .items
                                    .indexOf(value as String) +
                                1;
                            print(context.read<MyOrderCubit>().selectIndex + 1);
                            context.read<MyOrderCubit>().getListOrder();
                          },
                          buttonHeight: 40,
                          buttonWidth: double.infinity,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // itemCount: state.data['data']['content'].length ?? 0,
                          itemCount: stateOrder.data['data']['result'].length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 12, bottom: 12),
                                  child: MyOrderItem(
                                    onTap: () {
                                      NavigatorManager.push(
                                        context,
                                        DetailMyOrder(
                                          // id: state.data['data']['content'][index]['id'] ?? ''
                                          id: stateOrder.data['data']['result']
                                              [index]['id'],
                                        ),
                                      ).then((value) => context
                                          .read<MyOrderCubit>()
                                          .getListOrder());
                                    },
                                    // status: '${stateOrder.data['data']['result'][index]['status'] ?? ''}',
                                    status: statusShipEnumToString(
                                        statusShipEnumFromString(
                                            stateOrder.data['data']['result']
                                                    [index]['status'] ??
                                                '')),
                                    orderId:
                                        '${stateOrder.data['data']['result'][index]['orderCode'] ?? ''}',
                                    // orderName: '${stateOrder
                                    //     .data['data']['result'][index]['orderName'] ??
                                    //     ''}',
                                    address:
                                        '${stateOrder.data['data']['result'][index]['deliveryAddress'] ?? ''}',
                                    orderDate: FormatDate.formatDate(
                                        stateOrder.data['data']['result'][index]
                                                ['createdAt'] ??
                                            ''),
                                    deliveryDate: FormatDate.formatDate(
                                        stateOrder.data['data']['result'][index]
                                                ['deliveryDate'] ??
                                            ''),
                                  ),
                                ),
                                Divider(
                                  color: const Color(0xffB9B9B9).withOpacity(0.5),
                                  height: 0.5,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
                // } else if (state is MyOrderFailure) {
                //   return Center(
                //     child: Text(
                //       state.message,
                //       style: TextStyle(fontSize: 16, color: FontColor.color212121),
                //     ),
                //   );
                //   // return Center(
                //   //   child: Text(
                //   //     state.message,
                //   //     style: TextStyle(fontSize: 16, color: FontColor.color212121),
                //   //   ),
                //   // );
                // }
              } else {
                return Column(children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: kMainRedColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        alignment: Alignment.centerLeft,
                        buttonPadding: EdgeInsets.zero,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        hint: Text(
                          'Select Item',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: kMainRedColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        items: context
                            .read<MyOrderCubit>()
                            .items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: kMainRedColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: context.read<MyOrderCubit>().selectedValue,
                        onChanged: (value) {
                          context.read<MyOrderCubit>().selectedValue =
                              value as String;
                          context.read<MyOrderCubit>().selectIndex = context
                                  .read<MyOrderCubit>()
                                  .items
                                  .indexOf(value as String) +
                              1;
                          print(context.read<MyOrderCubit>().selectIndex + 1);
                          context.read<MyOrderCubit>().getListOrder();
                        },
                        buttonHeight: 40,
                        buttonWidth: double.infinity,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 100, right: 16, left: 16, bottom: 20),
                    child: Center(
                      child: Text(
                        'Bạn không có đơn hàng nào',
                        style: GoogleFonts.roboto(
                            fontSize: 16, color: FontColor.colorHintText),
                      ),
                    ),
                  ),
                ]);
              }
            },
          ),
        ),
      ),
    );
  }
}
