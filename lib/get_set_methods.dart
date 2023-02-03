import 'dart:html';

class Rectangle {
  final int width, height;

  Rectangle(this.width, this.height);

  int get area => width * height;

  Point? _center;
  Point? get center => _center;
  set center(Point? origin) {
    _center = Point(
     ( origin?.x ?? 0)+ width / 2,
     ( origin?.y ?? 0) + height / 2,
    );
  }
}