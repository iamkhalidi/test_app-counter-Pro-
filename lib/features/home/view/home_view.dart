import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../widgets/counter_button.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E17),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 32, 28, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تم التطوير بواسطة خالد',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          letterSpacing: 6,
                          color: Colors.white.withOpacity(0.35),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'العداد',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  // Reset Button
                  GestureDetector(
                    onTap: controller.reset,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.refresh_rounded,
                              size: 15,
                              color: Colors.white.withOpacity(0.6)),
                          const SizedBox(width: 6),
                          Text(
                            'إعادة',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── Counter Display ──────────────────────
            Obx(() {
              final color = controller.valueColor;
              return Column(
                children: [
                  // Glow Ring
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          color.withOpacity(0.15),
                          color.withOpacity(0.0),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF1A1826),
                          border: Border.all(
                            color: color.withOpacity(0.4),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.2),
                              blurRadius: 40,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                            style: TextStyle(
                              fontSize: controller.value.abs() >= 100 ? 52 : 68,
                              fontWeight: FontWeight.w900,
                              color: color,
                              letterSpacing: -3,
                              height: 1,
                            ),
                            child: Text(controller.valueLabel),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Status Chip
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 7),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border:
                      Border.all(color: color.withOpacity(0.3)),
                    ),
                    child: Text(
                      controller.value > 0
                          ? 'موجب  ▲'
                          : controller.value < 0
                          ? 'سالب  ▼'
                          : 'صفر  ●',
                      style: TextStyle(
                        fontSize: 13,
                        color: color,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              );
            }),

            const Spacer(),

            // ── Buttons Row ──────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 56),
              child: Obx(
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Decrement
                    Column(
                      children: [
                        CounterButton(
                          onPressed: controller.decrement,
                          icon: Icons.remove_rounded,
                          color: const Color(0xFFFF5C5C),
                          isEnabled: controller.canDecrement,
                          size: 76,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'تنقيص',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.4),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),

                    // Center divider decoration
                    Column(
                      children: [
                        Container(
                          width: 1,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.white.withOpacity(0.12),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.15),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),

                    // Increment
                    Column(
                      children: [
                        CounterButton(
                          onPressed: controller.increment,
                          icon: Icons.add_rounded,
                          color: const Color(0xFF00C48C),
                          isEnabled: controller.canIncrement,
                          size: 76,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'إضافة',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.4),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}