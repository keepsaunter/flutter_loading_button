import 'package:flutter/material.dart';
import './model/ex_stream.dart';
import './widget/loading_gradient_btn.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Loading Button Demo',
      theme: ThemeData(
        //为了做渐变按钮，取消了默认的按钮最小宽度及背景的设置
        buttonTheme: new ButtonThemeData(
          minWidth: 0,
          height: 0,
          padding: EdgeInsets.all(0),
          buttonColor: Colors.transparent
        )
      ),
      home: MyHomePage(title: 'Flutter Loading Button Demo'),
    );
  }
}
class MyHomePage extends StatelessWidget {
  final String title;
  ExStream<bool> btnStream;

  MyHomePage({@required this.title}) {
    this.btnStream = ExStream();
  }

  void btnPressed() {
    this.btnStream.setData(true);
  }
  void btnUnLoading() {
    this.btnStream.setData(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: LoadingGradientBtn(exStream: this.btnStream, width: 100, height: 30, fontSize: 13, pressed: (){
            this.btnPressed();
            Timer(const Duration(seconds: 5), () {this.btnUnLoading();});
        },child: Text('test')),
      )
    );
  }
}