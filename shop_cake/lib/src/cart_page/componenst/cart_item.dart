import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/assets/assets.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class CartItem extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final String? price;
  final int? quantity;
  final GestureTapCallback? onTapAdd;
  final GestureTapCallback? onTapMinus;
  final GestureTapCallback? onTapRemove;
  final bool? isShowButton;
  final bool? isShowQuantity;

  const CartItem({
    Key? key,
    this.name,
    this.imageUrl,
    this.price,
    this.quantity,
    this.onTapAdd,
    this.onTapMinus,
    this.onTapRemove,
    this.isShowButton,
    this.isShowQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kMainWhiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kMainDarkGreyColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: k666666.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 110,
            height: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                // '${state.data[index]['images'] ?? 'https://img.freepik.com/free-vector/thai-cuisine-food-flat-illustration_1284-74042.jpg?w=826&t=st=1662447770~exp=1662448370~hmac=d1eb58a73a830be233671c2c08232da012f7faca37554705b8971f4cb723fffa'}',
                imageUrl ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrthQqVfCco3_Pj5My7QSayyY4ZmkAo98zbw&usqp=CAU',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    Assets.imgDefault,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          8.spaceWidth,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // '${state.data[index]['name'] ?? ''}',
                  name ?? 'Bánh ngọt',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                5.spaceHeight,
                Row(
                  children: [
                    Text(
                      'Số lượng:',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        quantity.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                5.spaceHeight,
                Row(
                  children: [
                    Text(
                      'Đơn giá:',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        price ?? '0đ',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isShowQuantity == true ?
                    Container(
                      height: 28,
                      width: 80,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kMainColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: onTapMinus,
                              // final count = state.data[index]['quantity'];
                              // final count = 0;
                              // final quantity = count - 1;
                              // if (quantity == 0) {
                              //   listCardCubit.removeFood(
                              //       context,
                              //       // state.data[index]['id']
                              //       1);
                              // } else {
                              //   listCardCubit.addFood(
                              //       context,
                              //       // state.data[index]['id'],
                              //       1,
                              //       quantity);
                              // }
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: onTapAdd,
                              // final count = state.data[index]['quantity'];
                              // final count = 0;
                              // final quantity = count + 1;
                              // listCardCubit.addFood(
                              //     context,
                              //     // state.data[index]['id'],
                              //     1,
                              //     quantity);
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ) : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              isShowButton == true
                  ? InkWell(
                      onTap: onTapRemove,
                      child: const Icon(
                        size: 28,
                        Icons.restore_from_trash_rounded,
                        color: Colors.grey,
                      ),
                    )
                  : const SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
