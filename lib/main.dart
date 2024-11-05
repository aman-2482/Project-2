import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovingSquare(),
    );
  }
}


class MovingSquare extends StatefulWidget {
  @override
  _MovingSquareState createState() => _MovingSquareState();
}

class _MovingSquareState extends State<MovingSquare> {
  // Current horizontal position of the square
  double _position = 0.0;

  // Whether the square is currently moving
  bool _isMoving = false;

  /// Moves the square to the right edge of the screen.
  /// Sets `_isMoving` to true to disable the buttons during movement.
  void _MovingSquareRight() {
    setState(() {
      _isMoving = true;
    });
    _animateSquare(MediaQuery.of(context).size.width - 100);
  }

  /// Moves the square to the left edge of the screen.
  /// Sets `_isMoving` to true to disable the buttons during movement.
  void _MovingSquareLeft() {
    setState(() {
      _isMoving = true;
    });
    _animateSquare(0.0);
  }

  /// Animates the square to a target position with a delay.
  /// Once the square reaches the target, `_isMoving` is set to false.
  void _animateSquare(double target) {
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _position = target;
        _isMoving = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Moving Square")),
      body: Center(
        child: Stack(
          children: [
            // An animated container representing the square.
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              left: _position,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
            // Button controls to move the square left or right.
            Positioned(
              bottom: 50,
              left: 50,
              right: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    // Button to move the square left if it's not already at the left edge
                    onPressed:
                        !_isMoving && _position > 0 ? _MovingSquareLeft : null,
                    child: Text("Move to left"),
                  ),
                  ElevatedButton(
                    // Button to move the square right if it's not already at the right edge
                    onPressed: !_isMoving &&
                            _position < MediaQuery.of(context).size.width - 100
                        ? _MovingSquareRight
                        : null,
                    child: Text("Move to Right"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
