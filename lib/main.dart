import 'package:flutter/material.dart';

import 'package:kakao_flutter_sdk/all.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/common.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_plugin.dart';
import 'package:kakao_flutter_sdk/link.dart';
import 'package:kakao_flutter_sdk/local.dart';
import 'package:kakao_flutter_sdk/push.dart';
import 'package:kakao_flutter_sdk/search.dart';
import 'package:kakao_flutter_sdk/story.dart';
import 'package:kakao_flutter_sdk/talk.dart';
import 'package:kakao_flutter_sdk/template.dart';
import 'package:kakao_flutter_sdk/user.dart';

void main() {
  KakaoContext.clientId = "d1ab3757d87960f7ae7a6214c6e41bd7";
  KakaoContext.javascriptClientId = "3f932ca5f98e3c9fc279867fce426fed";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'KakaoLogin using sdk'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accessToken;
  String _refreshToken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Image.asset('assets/image/kakao.png'),
              onTap: () async {
                String authCode = await AuthCodeClient.instance.request();
                print('kakao');
                print('authCode : ${authCode}');
                // String authCode = await AuthCodeClient.instance.requestWithTalk() // or with KakaoTalk
                AccessTokenResponse token = await AuthApi.instance.issueAccessToken(authCode);
//                AccessTokenStore.instance.toCache(token);
                AccessTokenStore.instance.toStore(token);
                print('accessToken : ${token.accessToken}');
                print('refreshToken : ${token.refreshToken}');
                setState(() {
                  _accessToken = token.accessToken;
                  _refreshToken = token.refreshToken;
                });
              },
            ),
            SizedBox(
              height: 36,
            ),
            Text('Access Token : ${_accessToken}'),
            Text('Refresh Token : ${_refreshToken}')
          ],
        ),
      ),
    );
  }

  _checkAccessToken() async {
    var token = await AccessTokenStore.instance.fromStore();
    debugPrint(token.toString());
  }
}
