import 'package:flutter/material.dart';

/// 可拖动的圆形浮动按钮
class DraggableFloatingButton extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double? bottomNavBarHeight; // 底部导航栏高度，用于计算默认位置

  const DraggableFloatingButton({
    super.key,
    required this.onTap,
    this.icon = Icons.add,
    this.backgroundColor = Colors.blue,
    this.iconColor = Colors.white,
    this.size = 56.0,
    this.bottomNavBarHeight,
  });

  @override
  State<DraggableFloatingButton> createState() =>
      _DraggableFloatingButtonState();
}

class _DraggableFloatingButtonState extends State<DraggableFloatingButton> {
  Offset? _position;
  bool _isDragging = false;
  bool _isInitialized = false;

  void _initializePosition(double availableWidth, double availableHeight, BuildContext context) {
    if (!_isInitialized && !_isDragging) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final safeArea = MediaQuery.of(context).padding;
          final bottomNavBarHeight = widget.bottomNavBarHeight ?? 80.0;
          final padding = 16.0;
          
          // 计算默认位置（右下角）
          final defaultX = availableWidth - widget.size - padding - safeArea.right;
          final defaultY = availableHeight - widget.size - padding - safeArea.bottom - bottomNavBarHeight;
          
          // 确保位置在有效范围内
          final minX = safeArea.left;
          final maxX = availableWidth - widget.size - safeArea.right;
          final minY = safeArea.top;
          final maxY = availableHeight - widget.size - safeArea.bottom - bottomNavBarHeight;
          
          final clampedX = defaultX.clamp(minX, maxX);
          final clampedY = defaultY.clamp(minY, maxY);
          
          setState(() {
            _position = Offset(clampedX, clampedY);
            _isInitialized = true;
          });
        }
      });
    }
  }

  Offset _calculatePosition(double availableWidth, double availableHeight, BuildContext context) {
    final safeArea = MediaQuery.of(context).padding;
    final bottomNavBarHeight = widget.bottomNavBarHeight ?? 80.0;
    final padding = 16.0;
    
    // 计算默认位置（右下角）
    final defaultX = availableWidth - widget.size - padding - safeArea.right;
    final defaultY = availableHeight - widget.size - padding - safeArea.bottom - bottomNavBarHeight;
    
    // 确保位置在有效范围内
    final minX = safeArea.left;
    final maxX = availableWidth - widget.size - safeArea.right;
    final minY = safeArea.top;
    final maxY = availableHeight - widget.size - safeArea.bottom - bottomNavBarHeight;
    
    final clampedX = defaultX.clamp(minX, maxX);
    final clampedY = defaultY.clamp(minY, maxY);
    
    return _position ?? Offset(clampedX, clampedY);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;
        
        // 初始化位置
        _initializePosition(availableWidth, availableHeight, context);
        
        // 计算当前位置
        final position = _calculatePosition(availableWidth, availableHeight, context);
        
        final safeArea = MediaQuery.of(context).padding;
        final bottomNavBarHeight = widget.bottomNavBarHeight ?? 80.0;
        final minX = safeArea.left;
        final maxX = availableWidth - widget.size - safeArea.right;
        final minY = safeArea.top;
        final maxY = availableHeight - widget.size - safeArea.bottom - bottomNavBarHeight;

        return Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onPanStart: (details) {
              setState(() {
                _isDragging = true;
              });
            },
            onPanUpdate: (details) {
              setState(() {
                final currentPosition = _position ?? position;
                final newX = currentPosition.dx + details.delta.dx;
                final newY = currentPosition.dy + details.delta.dy;
                
                // 限制按钮在整个 HomePage body 区域内
                _position = Offset(
                  newX.clamp(minX, maxX),
                  newY.clamp(minY, maxY),
                );
                _isInitialized = true;
              });
            },
            onPanEnd: (details) {
              setState(() {
                _isDragging = false;
              });
            },
            onTap: widget.onTap,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                color: widget.iconColor,
                size: widget.size * 0.5,
              ),
            ),
          ),
        );
      },
    );
  }
}
