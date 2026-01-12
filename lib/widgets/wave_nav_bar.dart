import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:praktikumuiux_7020230073/providers/theme_provider.dart';

class WaveNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const WaveNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override

  // ignore: library_private_types_in_public_api
  _WaveNavigationBarState createState() => _WaveNavigationBarState();
}

class _WaveNavigationBarState extends State<WaveNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(WaveNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 80,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: isDark ? Color(0xFF1C1C1E) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(screenWidth, 80),
                  painter: WavePainter(
                    currentIndex: widget.currentIndex,
                    isDark: isDark,
                    animation: _animation.value,
                    itemCount: 3,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildNavItem(Icons.home_rounded, 0, isDark),
                _buildNavItem(Icons.shopping_bag_rounded, 1, isDark),
                _buildNavItem(Icons.person_rounded, 2, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, bool isDark) {
    final isSelected = widget.currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 80,
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: isSelected ? 15 : 10),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            transform: Matrix4.translationValues(0, isSelected ? -20 : 0, 0),
            child: Container(
              width: isSelected ? 60 : 50,
              height: isSelected ? 60 : 50,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : (isDark ? Color(0xFF1C1C1E) : Colors.white),
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                        color: Color(0xFF0095F6),
                        width: 3,
                      )
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Color(0xFF0095F6).withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? Color(0xFF0095F6)
                    : (isDark ? Colors.grey[400] : Colors.grey[700]),
                size: isSelected ? 30 : 26,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final int currentIndex;
  final bool isDark;
  final double animation;
  final int itemCount;

  WavePainter({
    required this.currentIndex,
    required this.isDark,
    required this.animation,
    required this.itemCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? Color(0xFF1C1C1E) : Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    final itemWidth = size.width / itemCount;
    final centerX = (currentIndex * itemWidth) + (itemWidth / 2);

    final waveWidth = 120.0 * animation;
    final waveHeight = 40.0 * animation;
    final bubbleRadius = 35.0;

    path.moveTo(0, size.height);

    path.lineTo(centerX - waveWidth, size.height);

    path.quadraticBezierTo(
      centerX - (waveWidth * 0.7),
      size.height - (waveHeight * 0.3),
      centerX - (waveWidth * 0.5),
      size.height - waveHeight,
    );

    path.quadraticBezierTo(
      centerX - bubbleRadius,
      size.height - waveHeight - bubbleRadius,
      centerX,
      size.height - waveHeight - bubbleRadius,
    );


    path.quadraticBezierTo(
      centerX + bubbleRadius,
      size.height - waveHeight - bubbleRadius,
      centerX + (waveWidth * 0.5),
      size.height - waveHeight,
    );

 
    path.quadraticBezierTo(
      centerX + (waveWidth * 0.7),
      size.height - (waveHeight * 0.3),
      centerX + waveWidth,
      size.height,
    );

    path.lineTo(size.width, size.height);

   
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.currentIndex != currentIndex ||
        oldDelegate.animation != animation ||
        oldDelegate.isDark != isDark;
  }
}