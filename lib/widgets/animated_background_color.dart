import 'package:flutter/material.dart';

class AnimatedBackgroundColor extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  final Widget child;

  const AnimatedBackgroundColor({
    Key key,
    @required this.color,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.bounceIn,
    @required this.child,
  })  : assert(color != null),
        assert(child != null),
        super(key: key);

  @override
  _AnimatedBackgroundColorState createState() =>
      _AnimatedBackgroundColorState();
}

class _AnimatedBackgroundColorState extends State<AnimatedBackgroundColor>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;
  Animation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );

    _colorTween = ColorTween(
      begin: widget.color,
    ).animate(_curvedAnimation);
  }

  @override
  void didUpdateWidget(AnimatedBackgroundColor oldWidget) {
    super.didUpdateWidget(oldWidget);

    _colorTween = ColorTween(
      begin: oldWidget.color,
      end: widget.color,
    ).animate(
        _animationController); //NB! if CurvedAnimation is used as an animation the color animation becomes choppy.

    _animationController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _colorTween,
        builder: (context, snapshot) {
          return Center(
            child: ColoredBox(
              color: _colorTween.value,
              child: widget.child,
            ),
          );
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
