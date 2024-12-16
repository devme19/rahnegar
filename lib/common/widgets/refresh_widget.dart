import 'package:flutter/material.dart';


class RefreshWidget extends StatefulWidget {
  const RefreshWidget({super.key});

  @override
  State<RefreshWidget> createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> with SingleTickerProviderStateMixin{
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Rotation duration
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onRefresh() {
    // Trigger the animation
    _controller.repeat();
    Future.delayed(const Duration(seconds: 3), () {
      // Stop animation after the operation
      _controller.stop();
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onRefresh,
      child: RotationTransition(
        turns: _controller,
        child: Icon(
          Icons.refresh,
          size: 50,
          color: Colors.blue,
        ),
      ),
    );
  }
}
