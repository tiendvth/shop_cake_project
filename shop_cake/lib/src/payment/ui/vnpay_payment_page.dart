import 'package:flutter/material.dart';
import 'package:shop_cake/constants/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VnPayPaymentPage extends StatefulWidget {
  @override
  _VnPayPaymentPageState createState() => _VnPayPaymentPageState();
}

class _VnPayPaymentPageState extends State<VnPayPaymentPage> {
  final String paymentUrl = 'http://sandbox.vnpayment.vn/tryitnow/Home/CreateOrder';
  final String redirectUrl = 'http://localhost:3000';
  final String vnpTmnCode = '33W8VDX4';
  final String vnpHashSecret = 'GAUCTFWUWOSARCULHQYHSWNRWPDUOXQL';

  _redirectToVnPay() {
    final String vnpUrl = '$paymentUrl?'
        'vnp_Version=2.0.0&'
        'vnp_TmnCode=$vnpTmnCode&'
        'vnp_Amount=${1000000000 * 100}&'
        'vnp_Command=pay&'
        'vnp_CurrCode=VND&';
    return vnpUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Thanh toán VnPay'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: kBgMenu,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
      ),
      body: WebView(
        initialUrl: _redirectToVnPay(),
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith(redirectUrl)) {
            print('Redirecting to $redirectUrl');
            Navigator.of(context).pop();
            return NavigationDecision.prevent;
          }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
