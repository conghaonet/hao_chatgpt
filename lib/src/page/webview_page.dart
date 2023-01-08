import 'package:flutter/material.dart';
import 'package:hao_chatgpt/src/constants.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  final String? url;
  final String? title;
  const WebviewPage({required this.url, this.title, Key? key})
      : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late String _title;
  late String _url;
  late final WebViewController _controller;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _title = widget.title ?? '';
    _url = widget.url.isNotBlank ? widget.url! : Constants.blankUrl;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          if (mounted) {
            setState(() {
              _progress = progress.toDouble() / 100;
            });
          }
        },
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(_url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          IconButton(
            onPressed: () async {
              await _controller.reload();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () async {
              var currentUrl = await _controller.currentUrl();
              if (currentUrl.isNotBlank) {
                await openWebView(
                    context: context, url: currentUrl!, isExternal: true);
              }
            },
            icon: const Icon(Icons.open_in_browser),
          ),
        ],
      ),
      body: Stack(
        children: [
          WillPopScope(
            onWillPop: () async {
              if (await _controller.canGoBack()) {
                await _controller.goBack();
                return false;
              } else {
                return true;
              }
            },
            child: WebViewWidget(
              controller: _controller,
            ),
          ),
          Offstage(
            offstage: _progress == 1.0,
            child: LinearProgressIndicator(
              value: _progress,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.blueAccent), // 进度条颜色为粉色
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
