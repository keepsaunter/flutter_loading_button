import 'package:flutter/material.dart';
import '../model/ex_stream.dart';
import './gradient_btn.dart';

class SimpleLoadingBtn extends StatelessWidget {
  final ExStream<bool> exStream;
  final VoidCallback pressed;
  SimpleLoadingBtn({@required this.exStream, @required this.pressed});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this.exStream.stream,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> currentSummary){
        return GradientBtn(child: Text(currentSummary.data?'加载中':'操作'), pressed: this.pressed,);
      }
    );
  }
}