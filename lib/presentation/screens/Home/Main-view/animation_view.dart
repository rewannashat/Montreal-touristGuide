import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class FloatingSvgImage extends StatefulWidget {
  const FloatingSvgImage({super.key});

  @override
  State<FloatingSvgImage> createState() => _FloatingSvgImageState();
}

class _FloatingSvgImageState extends State<FloatingSvgImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: SvgPicture.asset(
          'assets/images/uploadFailedIllistration.svg',
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
