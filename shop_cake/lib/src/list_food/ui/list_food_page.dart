import 'package:common/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_cake/constants/color/colors.dart';
import 'package:shop_cake/firebase/setup_firebase.dart';
import 'package:shop_cake/network/network_manager.dart';
import 'package:shop_cake/src/detail_food/ui/detail_food_page.dart';
import 'package:shop_cake/src/detail_my_order/ui/detail_my_order_page.dart';
import 'package:shop_cake/src/home_page/repository/home_repository.dart';
import 'package:shop_cake/src/list_food/bloc/category_cubit.dart';
import 'package:shop_cake/src/list_food/bloc/list_food_cubit.dart';
import 'package:shop_cake/src/list_food/components/category_item.dart';
import 'package:shop_cake/src/list_food/components/input_search.dart';
import 'package:shop_cake/validation/validation.dart';

import '../../../constants/font_size/font_size.dart';

class ListFoodPage extends StatefulWidget {
  const ListFoodPage({Key? key}) : super(key: key);

  @override
  State<ListFoodPage> createState() => _ListFoodPageState();
}

class _ListFoodPageState extends State<ListFoodPage> {
  final listFoodCubit = ListFoodCubit();
  final listCategoryCubit = CategoryCubit();
  final homeRepository = HomeRepositoryImpl(apiProvider);


  get state => null;

  saveDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print("device_tokent: " + token.toString());
      device_token = token ?? '';
      await homeRepository.deviceToken(token.toString());
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    // saveDeviceToken();
    // tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    FirebaseMessaging.onMessage.listen(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("Data message firebase: ${message.data}");
        NavigatorManager.pushFullScreen(
          context,
          DetailMyOrder(
            id: int.parse(message.data['orderId']),
          ));
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Data message firebase: ${message.data}");
      Future.delayed(const Duration(milliseconds: 2000), () {
        NavigatorManager.pushFullScreen(
            context,
            DetailMyOrder(
              id: int.parse(message.data['orderId']),
            ));
      });
    });
    _refresh();
  }

  Future<void> _refresh() async {
     listCategoryCubit.getCategory();
     listFoodCubit.getListFood(listFoodCubit.searchController.text);
  }
  // Future<void> _refresh() async {
  //   await listFoodCubit.getListFood(listFoodCubit.searchController.text);
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => listFoodCubit,
        ),
        BlocProvider(
          create: (_) => listCategoryCubit,
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xfFFFFFFF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Danh sách món ăn',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: FontColor.colorFF3366,
        ),
        body: Column(
          children: [
          InputSearch(
            controller: listFoodCubit.searchController,
            maxWidth: double.infinity,
            prefixIcon: Icon(
              Icons.search,
            ),
            listFoodCubit: listFoodCubit,
        ),
          SizedBox(height: 20,
          ),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategorySuccess) {
                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    // itemCount: state.data.length,
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: CategoryItem(
                          // imageUrl: state.data[index]['image'],
                          // title: state.data[index]['title'],
                          title: 'category1',
                        ),
                      );
                    },
                  ),
                );
              }
              else {
                return SizedBox.shrink();
              }
            },
          ),
          Expanded(
            child: BlocBuilder<ListFoodCubit, ListFoodState>(
              builder: (context, stateListCake) {
                if (stateListCake is ListFoodSuccess) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 20),
                    child: CustomScrollView(
                      slivers: [
                        CupertinoSliverRefreshControl(
                            onRefresh: _refresh),
                        SliverGrid(
                          gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent:
                              MediaQuery.of(context).size.height / 3,
                              childAspectRatio: 0.83,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 10),
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      4),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color:
                                      Colors.grey.withOpacity(0.5),
                                      blurRadius: 5,
                                      offset: const Offset(1, 4))
                                  ],
                                  color: Colors.white),
                                child: InkWell(
                                  onTap: () {
                                    NavigatorManager.pushFullScreen(
                                      context,
                                      DetailFood(
                                        id: stateListCake.data[index]['id'] ?? '',
                                      ));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                width: double.infinity,
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      4),
                                                  child: Image.network(
                                                    stateListCake
                                                        .data['image'],
                                                    width: double
                                                        .infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(stateListCake
                                                        .data),
                                                    Text(
                                                      '${stateListCake
                                                          .data[index]['name'] ??
                                                          ''}',
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style:
                                                      const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        color: Color(
                                                            0xff231F20),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      '${Validation.oCcy
                                                          .format(
                                                          stateListCake
                                                              .data[index]['price'] ??
                                                              0)} đ',
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontSize: 12,
                                                        color: FontColor
                                                            .colorEC222D,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Row(
                                                      children: [
                                                        RatingBar.builder(
                                                          initialRating: 5,
                                                          minRating: 1,
                                                          direction: Axis
                                                              .horizontal,
                                                          ignoreGestures:
                                                          true,
                                                          itemCount: 5,
                                                          itemSize: 10,
                                                          itemPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              1),
                                                          itemBuilder:
                                                              (context,
                                                              _) =>
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors
                                                                .amber,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {},
                                                        ),
                                                        const Expanded(
                                                          child: Text(
                                                            // '${state.data[index]['status'] ?? ''}',
                                                            'testStatus',
                                                            textAlign: TextAlign.end,
                                                            style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              fontSize: 10,
                                                              // color: state.data[index]['status'] == "ACTIVE" ? Colors.green : Colors.deepOrange,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          listFoodCubit.addFoodToOrder(
                                              context,
                                              //
                                              1,
                                              1);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 10),
                                          decoration: const BoxDecoration(
                                              borderRadius:
                                              BorderRadius.only(
                                                bottomLeft:
                                                Radius.circular(4),
                                                bottomRight:
                                                Radius.circular(4),
                                              ),
                                              color: Colors.red),
                                          child: const Center(
                                            child: Text(
                                              'Thêm vào giỏ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            // childCount: state.data.length ?? 0,
                            childCount: 1,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is ListFoodFailure) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(
                          fontSize: FontSize.fontSize_16,
                          color: FontColor.color212121),
                    ),
                  );
                  // return Center(
                  //   child: Text(
                  //     state.message,
                  //     style: TextStyle(
                  //         fontSize: FontSize.fontSize_16,
                  //         color: FontColor.color212121),
                  //   ),
                  // );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
      // ),
      ],
    )),
    );
  }
}
