import 'package:flutter/material.dart';

class FlashAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback onComplete;
  final bool isTransitioning;

  const FlashAnimation({
    super.key,
    required this.child,
    required this.onComplete,
    this.isTransitioning = false,
  });

  @override
  State<FlashAnimation> createState() => FlashAnimationState();
}

class FlashAnimationState extends State<FlashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });
  }

  @override
  void didUpdateWidget(FlashAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isTransitioning != oldWidget.isTransitioning &&
        widget.isTransitioning) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return _controller.isAnimating
                ? Container(
                    color: Theme.of(context)
                        .colorScheme
                        .tertiaryContainer
                        .withOpacity(_animation.value),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
