import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key, required this.home});
  final Widget home;

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  Future<void> navigateToHome()async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>widget.home));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientText(
              'Shikshak Saathi',
              style: const TextStyle(fontSize: 30),
              gradient: LinearGradient(colors: [
                Colors.red,
                Colors.blue.shade400,
                Colors.blue.shade900,
              ]),
            ),
            SizedBox.fromSize(size: const Size(34, 34),),
            SizedBox(height:100,
                width: 50,
                child: Expanded(child: LoadingAnimationWidget.fourRotatingDots(color: Colors.red, size: 40)))
          ],
        ),
      ),
    );
  }
}
class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {super.key,
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}