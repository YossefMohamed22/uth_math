import 'package:flutter/material.dart';
import 'package:neuro_math/view/multi_operation_page/multi_operation_logic.dart';

class VerticalTicker extends StatefulWidget {
  final Duration duration;
  final MultiOperationLogic logic;

  const VerticalTicker({
    super.key,
    this.duration = const Duration(seconds: 8),
    required this.logic,
  });

  @override
  State<VerticalTicker> createState() => _VerticalTickerState();
}

class _VerticalTickerState extends State<VerticalTicker> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  double get itemHeight => 40;
  double get totalHeight => widget.logic.numbers.length * itemHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenHeight = MediaQuery.of(context).size.height;
      final anim = Tween<double>(
        begin: screenHeight,
        end: -totalHeight,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

      setState(() {
        _animation = anim;
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.isDismissed) return const SizedBox();
    return ClipRect(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: child,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...List.generate(widget.logic.numbers.length, (index) {
                return SizedBox(
                  height: itemHeight,
                  child: Center(
                    child: Text(
                      widget.logic.numbers[index],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 10,),
              const Divider(
                thickness: 3,
                color: Colors.black,
                height: 0,
                endIndent: 100,
                indent: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
