import 'package:flutter/material.dart';

class GradientBtn extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;
  bool disabled;
  List<Color> colors;
  double radius;
  VoidCallback pressed;
  Widget child;
  
  GradientBtn({this.width=70, this.height=22, this.fontSize = 10, @required this.child, @required this.pressed, this.disabled = false, this.colors, this.radius}) {
    if(this.radius == null) {
      this.radius = this.height / 2;
    }
    if(this.colors == null) {
      this.colors = [Color.fromARGB(255, 238,195,16), Color.fromARGB(255, 236,153,2), Color.fromARGB(255, 219,98,3)];
      // this.colors = [Color.fromARGB(255, 131,137,141), Color.fromARGB(255, 193,193,193), Color.fromARGB(255, 131,137,141)];
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      //让按钮外部轮廓也带圆角
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(this.radius))),
      child: Container(
        width: this.width,
        height: this.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: this.colors),
            borderRadius: BorderRadius.all(Radius.circular(this.radius))
          ),
        child: this.child
      ),
      onPressed: this.pressed
    );
  }
}