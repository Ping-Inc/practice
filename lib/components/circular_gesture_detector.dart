import 'dart:math' as math;
import 'package:flutter/material.dart';

class CircularGestureDetector extends StatefulWidget {
  final Widget child;
  final Function(double angle) onAngleUpdate;
  
  const CircularGestureDetector({
    Key? key, 
    required this.child,
    required this.onAngleUpdate,
  }) : super(key: key);

  @override
  _CircularGestureDetectorState createState() => _CircularGestureDetectorState();
}

class _CircularGestureDetectorState extends State<CircularGestureDetector> {
  Offset _center = Offset.zero;
  Offset? _previousPosition;
  Offset? _startPosition;
  bool _isHorizontalSwipe = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        _center = box.size.center(box.localToGlobal(Offset.zero));
        _previousPosition = details.globalPosition;
        _startPosition = details.globalPosition;
        _isHorizontalSwipe = false;
      },
      onPanUpdate: (details) {
        if (_previousPosition == null || _startPosition == null) return;
        
        final currentPosition = details.globalPosition;
        final deltaX = currentPosition.dx - _startPosition!.dx;
        final deltaY = currentPosition.dy - _startPosition!.dy;
                
        if (!_isHorizontalSwipe && deltaX.abs() > 8 && deltaY.abs() < 30) {
          _isHorizontalSwipe = true;
          if (deltaX > 0) {
            widget.onAngleUpdate(10);
          } else {
            widget.onAngleUpdate(-10);
          }
          return;
        }
        
        // If we've already detected a horizontal swipe, we can ignore further angle updates! (prevents skipping)
        if (_isHorizontalSwipe) {
          return;
        }
        
        final previousAngle = _getAngle(_center, _previousPosition!);
        final currentAngle = _getAngle(_center, currentPosition);
        
        var angleDiff = currentAngle - previousAngle;
                
        if (angleDiff > 180) {
          angleDiff -= 360;
        } else if (angleDiff < -180) {
          angleDiff += 360;
        }
        
        if (angleDiff.abs() > 2) {
          widget.onAngleUpdate(angleDiff);
        }
        
        _previousPosition = currentPosition;
      },
      onPanEnd: (details) {
        _previousPosition = null;
        _startPosition = null;
        _isHorizontalSwipe = false;
      },
      child: widget.child,
    );
  }
  
  double _getAngle(Offset center, Offset position) {
    final deltaX = position.dx - center.dx;
    final deltaY = position.dy - center.dy;
    
    final radians = math.atan2(deltaY, deltaX);
    return (radians * 180 / math.pi + 360) % 360;
  }
}
