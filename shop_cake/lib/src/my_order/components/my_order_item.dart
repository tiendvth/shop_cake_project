import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:shop_cake/widgets/space_extention.dart';

class MyOrderItem extends StatelessWidget {
  final String? orderId;
  final String? status;
  final String? orderName;
  final String? image;
  final String? price;
  final String? quantity;
  final String? totalPrice;
  final String? orderDate;
  final String? address;
  final GestureTapCallback? onTap;

  const MyOrderItem({
    Key? key,
    this.orderId,
    this.status,
    this.orderName,
    this.image,
    this.price,
    this.quantity,
    this.totalPrice,
    this.orderDate,
    this.onTap,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 'Mã đơn hàng:${state.data['data']['content'][index]['id'] ?? ''}',
        RichText(
          text: TextSpan(
            text: 'Mã đơn hàng: ',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: kMainBlackColor,
            ),
            children: <TextSpan>[
              TextSpan(
                // 'Mã đơn hàng:${state.data['data']['content'][index]['id'] ?? ''}',
                text: orderId ?? '42634778923478',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: kMainOrangeColor,
                ),
              ),
            ],
          ),
        ),
        4.spaceHeight,
        RichText(
          text: TextSpan(
            text: 'sản phẩm: ',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: kMainBlackColor,
            ),
            children: <TextSpan>[
              TextSpan(
                // 'Mã đơn hàng:${state.data['data']['content'][index]['id'] ?? ''}',
                text: orderName ?? 'Bánh kem socola',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: kMainRedColor,
                ),
              ),
            ],
          ),
        ),
        4.spaceHeight,
        RichText(
          text: TextSpan(
            text: 'Trạng thái: ',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: kMainBlackColor,
            ),
            children: <TextSpan>[
              TextSpan(
                // text: '${state.data['data']['content'][index]['status'] ?? ''}',
                text: status ?? 'Đang giao hàng',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: kMainGreenColor,
                ),
              ),
            ],
          ),
        ),
        4.spaceHeight,
        RichText(
          text: TextSpan(
            text: 'Tổng tiền: ',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: kMainRedColor,
            ),
            children: <TextSpan>[
              TextSpan(
                // 'Tổng tiền: ${Validation.oCcy.format(state.data['data']['content'][index]['totalPrice'] ?? 0)} đ',
                text: totalPrice ?? '123 đ',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: kMainRedColor,
                ),
              ),
            ],
          ),
        ),
        4.spaceHeight,
        RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          text: TextSpan(
            text: 'Địa chỉ: ',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: kMainBlackColor,
            ),
            children: <TextSpan>[
              TextSpan(
                // 'Tổng tiền: ${Validation.oCcy.format(state.data['data']['content'][index]['totalPrice'] ?? 0)} đ',
                text: address ?? 'Tập thể Bách Khoa, Hai Bà Trưng, Hà Nội',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: k9B9B9B,
                ),
              ),
            ],
          ),
        ),
        8.spaceHeight,
        RichText(
          text: TextSpan(
            text: 'Ngày đặt hàng: ',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: kMainBlackColor,
            ),
            children: <TextSpan>[
              TextSpan(
                // state.data['data']['content'][index]
                //             ['createdAt'] !=
                //         null
                //     ? '${parserTime(state.data['data']['content'][index]['createdAt'] ?? "")}'
                //     : '',
                text: orderDate ?? '12/12/2021',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: kMainBlackColor,
                ),
              ),
            ],
          ),
        ),
        15.spaceHeight,
        MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          minWidth: MediaQuery.of(context).size.width - 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: kMainRedColor.withOpacity(0.6),
          onPressed: onTap,
          child: const Text(
            'Xem chi tiết',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        )
      ],
    );
  }
}
