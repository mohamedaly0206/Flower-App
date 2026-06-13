import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreditCardWebViewPayment extends StatefulWidget {
  final String initialUrl;
  final String successUrl;
  final String cancelUrl;
  const CreditCardWebViewPayment({
    super.key,
    required this.initialUrl,
    required this.successUrl,
    required this.cancelUrl,
  });

  @override
  State<CreditCardWebViewPayment> createState() =>
      _CreditCardWebViewPaymentState();
}

class _CreditCardWebViewPaymentState extends State<CreditCardWebViewPayment> {
  late final WebViewController _controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains(widget.successUrl)) {
              context.pop(true);
              return NavigationDecision.prevent;
            } else if (request.url.contains(widget.cancelUrl)) {
              context.pop(false);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.creditCardPayment,
        hasBackButton: false,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          loadingPercentage < 100
              ? LinearProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  value: loadingPercentage / 100.0,
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
