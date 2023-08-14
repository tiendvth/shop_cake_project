import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoPage extends StatefulWidget {
  const ContactInfoPage({Key? key}) : super(key: key);

  @override
  State<ContactInfoPage> createState() => _ContactInfoPageState();
}

class _ContactInfoPageState extends State<ContactInfoPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.0288687237567, 105.78181093986845),
    zoom: 16,
  );
  void openGoogleMapsDirections() async {
    String destination = '21.0288687237567, 105.78181093986845'; // Tọa độ đích, ví dụ: latitude,longitude

    String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=$destination';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      print('Không thể mở Google Maps');
      throw 'Không thể mở Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainWhiteColor,
        elevation: 0,
        centerTitle: true,
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
          'Liên hệ',
          style: GoogleFonts.roboto(
            color: kMainDarkColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: GoogleMap(
                mapType: MapType.normal,
                onCameraMove: (CameraPosition position) {
                  print(position);
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('Shop bánh ngọt 2'),
                    position:
                        const LatLng(21.0288687237567, 105.78181093986845),
                    infoWindow: const InfoWindow(
                      title: 'Cửa hàng bánh ngọt 2',
                      snippet: 'Số 1, Đại Cồ Việt, Hai Bà Trưng, Hà Nội',
                    ),
                    onTap: () {
                      openGoogleMapsDirections();
                    },
                    consumeTapEvents: true,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueViolet),
                    visible: true,
                  ),
                },
                myLocationButtonEnabled: true,
                mapToolbarEnabled: true,
                myLocationEnabled: true,
                indoorViewEnabled: true,
                buildingsEnabled: true,
                zoomGesturesEnabled: true,
                layoutDirection: TextDirection.ltr,
                cameraTargetBounds: CameraTargetBounds.unbounded,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Cửa hàng bánh CAKE LOVE',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: kMainDarkColor,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width / 1.5,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kMainLightColor,
                    width: 1,
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    'https://pandagift.vn/uploads/shops/ban_gai/mo-hinh-tiem-banh-cake-love-2.jpg',
                    fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Địa chỉ:',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kMainDarkColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'số 8 Tôn Thất Thuyết, Mỹ Đình, Nam Từ Liêm, Hà Nội',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: kMainDarkColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Số điện thoại:',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kMainDarkColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '0123456789',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: kMainDarkColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Email:',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kMainDarkColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'shopcake@gmail.com',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kMainDarkColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
