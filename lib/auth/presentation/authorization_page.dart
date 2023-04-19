import 'package:flutter/material.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizationPage extends StatefulWidget {
  final Uri authorizationUrl;
  final void Function(Uri redirectUrl) onAuthorizationCodeRedirectAttempt;

  const AuthorizationPage({
    super.key,
    required this.authorizationUrl,
    required this.onAuthorizationCodeRedirectAttempt,
  });

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  // void initState() {
  //   super.initState();
  //   if (Platform.isAndroid) {
  //     WebView.platform = SurfaceAndroidWebView();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final webViewController = WebViewController()
      ..loadRequest(Uri.parse(widget.authorizationUrl.toString()))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest navReq) {
            if (navReq.url
                .startsWith(GithubAuthenticator.redirectUrl.toString())) {
              widget.onAuthorizationCodeRedirectAttempt(Uri.parse(navReq.url));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..clearCache()
      ..clearLocalStorage();
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(controller: webViewController),
      ),
    );
  }
}
