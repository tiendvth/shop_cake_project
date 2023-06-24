import 'package:common/common.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/detail_my_order/ui/detail_my_order_page.dart';
import 'package:shop_cake/src/my_order/bloc/my_order_cubit.dart';
import 'package:shop_cake/src/my_order/repository/repository.dart';
import 'package:shop_cake/utils/utils.dart';
import 'package:shop_cake/validation/validation.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Đơn hàng của tôi',
          style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: FontColor.colorFF3366,
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
            MyOrderCubit(MyOderRepositoryImpl(apiProvider)),
        child: BlocBuilder<MyOrderCubit, MyOrderState>(
          builder: (context, state) {
            if (state is MyOrderSuccess) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(8)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: context
                            .read<MyOrderCubit>()
                            .items
                            .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                          value: context.read<MyOrderCubit>().selectedValue,
                          onChanged: (value) {
                            context.read<MyOrderCubit>().selectedValue =
                                value as String;
                            context.read<MyOrderCubit>().getListOrder();
                          },
                          buttonHeight: 40,
                          buttonWidth: double.infinity,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 30),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.data['data']['content'].length ?? 0,
                        itemBuilder: (BuildContext context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mã đơn hàng:${state.data['data']['content'][index]['id'] ?? ''}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                    2.spaceHeight,
                                    Text(
                                      '${state.data['data']['content'][index]['status'] ?? ""}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.green),
                                    ),
                                    2.spaceHeight,
                                    Text(
                                      'Tổng tiền: ${Validation.oCcy.format(state.data['data']['content'][index]['totalPrice'] ?? 0)} đ',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    8.spaceHeight,
                                    Row(
                                      children: [
                                        const Text(
                                          'Ngày đặt:  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        2.spaceWidth,
                                        Expanded(
                                          child: Text(
                                            state.data['data']['content'][index]
                                                        ['createdAt'] !=
                                                    null
                                                ? '${parserTime(state.data['data']['content'][index]['createdAt'] ?? "")}'
                                                : '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.red),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    15.spaceHeight,
                                    MaterialButton(
                                      height: 44,
                                      minWidth:
                                          MediaQuery.of(context).size.width -
                                              20,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      color: Colors.redAccent,
                                      onPressed: () {
                                        NavigatorManager.push(
                                            context, DetailMyOrder(
                                                        id: state.data['data']
                                                                    ['content']
                                                                [index]['id'] ??
                                                            '')).then((value) => context.read<MyOrderCubit>().getListOrder());
                                      },
                                      child: const Text(
                                        'Xem chi tiết',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
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
                    )
                  ],
                ),
              );
            } else if (state is MyOrderFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(fontSize: 16, color: FontColor.color212121),
                ),
              );
              // return Center(
              //   child: Text(
              //     state.message,
              //     style: TextStyle(fontSize: 16, color: FontColor.color212121),
              //   ),
              // );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
