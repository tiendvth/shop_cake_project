import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/src/cart_page/ui/cart_page.dart';
import 'package:shop_cake/src/list_food/ui/list_food_page.dart';
import 'package:shop_cake/src/profile_user/ui/profile_user_page.dart';

import 'my_order/ui/my_order_page.dart';


class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with SingleTickerProviderStateMixin {
  // late TabController? tabController;

  @override
  Widget build(BuildContext context) {
    // return MainBottomNavigationBar(
    //   wantKeepAliveChildren: [true, false, false, true],
    //   bottomNavigatorItemBuilder:
    //       (BuildContext contextNavigation, int currentIndex) {
    //     return ConvexAppBar(
    //       controller: tabController,
    //       style: TabStyle.react,
    //       backgroundColor: FontColor.colorFF3366,
    //       items: const [
    //         TabItem(icon: Icons.home_outlined),
    //         TabItem(icon: Icons.shopping_cart_outlined),
    //         //TabItem(icon: Icons.star),
    //         TabItem(icon: Icons.history),
    //         TabItem(icon: Icons.person_pin),
    //       ],
    //       initialActiveIndex: 0,
    //       onTap: (index) {
    //         contextNavigation.read<TabBarController>().tabIndex = index;
    //       },
    //     );
    //   },
    //   children: const [
    //     ListFoodPage(),
    //     CartPage(),
    //     //SizedBox(),
    //     MyOrderPage(),
    //     ProfileUserPage(),
    //   ],
    // );

    return MainBottomNavigationBar(
      wantKeepAliveChildren: [true, false, false, true],
      bottomNavigatorItemBuilder:
          (BuildContext contextNavigation, int currentIndex) {
        return BottomNavigationBar(
          selectedItemColor: FontColor.colorFFFFFF,
          unselectedItemColor: FontColor.colorDADADAFF,
          type: BottomNavigationBarType.fixed,
          backgroundColor: FontColor.colorFF3366,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: currentIndex,
          onTap: (index) {
            contextNavigation.read<TabBarController>().tabIndex = index;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Trang chủ"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "Đơn hàng"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "Danh sách"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), label: "Tài khoản"),
          ],
        );
      },
      children: const [
        ListFoodPage(),
        CartPage(),
        //SizedBox(),
        MyOrderPage(),
        ProfileUserPage(),
      ],
    );

    ;
  }
}
