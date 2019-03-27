import 'package:flutter/material.dart';
import './gradient_btn.dart';
import '../model/ex_stream.dart';
import 'dart:math' as Math;
/**
 * 可以调整loading状态的渐变按钮
 */
//用StatefulWidget类可以dispose动画
class LoadingGradientBtn extends StatefulWidget {
  //一个包装了Stream的类，里面监听按钮是否处于loading状态
  final ExStream<bool> exStream;
  //按钮正常状态时的内容
  final Widget child;

  //渐变图标的颜色
  Color iconColor;
  final double width;
  final double height;
  final double fontSize;
  final VoidCallback pressed;
  final bool disabled;
  final List<Color> colors;
  final double radius;

  LoadingGradientBtn({@required this.exStream, this.iconColor, this.width, this.height, this.fontSize, @required this.child, @required this.pressed, this.disabled, this.colors, this.radius}) {
    if(this.iconColor == null) {
      //默认颜色
      this.iconColor = Colors.blue;
    }
  }

  @override
  _AnimState createState() {
    return _AnimState();
  }
}
/**
 * 动画控制器AnimationController需要vsync参数，要用到SingleTickerProviderStateMixin，只能State类
 */
class _AnimState extends State<LoadingGradientBtn> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> rotateAnimation;
  //渐变按钮类
  GradientBtn gradientBtn;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(duration: const Duration(seconds: 1), vsync: this);
    rotateAnimation = new Tween(begin: 0.0, end: Math.pi * 2).animate(animationController);
    rotateAnimation.addStatusListener((status){
      if (status == AnimationStatus.completed) {
        //当动画结束时重复动画
        animationController.repeat();
      }
    });

    gradientBtn = GradientBtn(width: widget.width, height: widget.height, fontSize: widget.fontSize, child: 
      StreamBuilder(
        //监听loading状态变化
        stream: widget.exStream.stream,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> currentSummary){
          if(currentSummary.data) {
            //开启动画
            animationController.forward();
            return AnimatedBuilder(
              //监听动画变化
              animation: rotateAnimation,
              child: Icon(Icons.cached, color: widget.iconColor),
              builder: (BuildContext context, Widget child) {
                return Transform.rotate(
                  child: child,
                  angle: rotateAnimation.value,
                );
              }
            );
          }else {
            //关闭动画
            animationController.stop();
            return widget.child;
          }
        }
      ), pressed: widget.pressed, disabled: widget.disabled, colors: widget.colors, radius: widget.radius
    );
  }

  @override
  Widget build(BuildContext context) {
    return gradientBtn;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}