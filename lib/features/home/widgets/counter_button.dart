import 'package:flutter/material.dart';

class CounterButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final bool isEnabled;
  final double size;

  const CounterButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.color,
    this.isEnabled = true,
    this.size = 72,
  });

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!widget.isEnabled) return;
    _animCtrl.forward().then((_) => _animCtrl.reverse());
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedOpacity(
          opacity: widget.isEnabled ? 1.0 : 0.35,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.isEnabled
                  ? widget.color
                  : widget.color.withOpacity(0.3),
              shape: BoxShape.circle,
              boxShadow: widget.isEnabled
                  ? [
                BoxShadow(
                  color: widget.color.withOpacity(0.45),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
                  : [],
            ),
            child: Icon(
              widget.icon,
              color: Colors.white,
              size: widget.size * 0.45,
            ),
          ),
        ),
      ),
    );
  }
}