class Position {
  final int x;
  final int y;

  const Position(this.x, this.y);

  Position operator +(Position p) {
    return Position(x + p.x, y + p.y);
  }

  Position operator -(Position p) {
    return Position(x - p.x, y - p.y);
  }

  @override
  bool operator ==(Object other) {
    return other is Position && other.x == x && other.y == y;
  }

  @override
  String toString() => "x: $x, y: $y";
  
  @override
  int get hashCode => Object.hash(x, y);
  

  Map<String, dynamic> tojson() => {
    'x': x,
    'y': y,
  };

  factory Position.fromJson(Map<String, dynamic> map) {
    return Position(
      map['x'] as int,
      map['y'] as int,
    );
  }
  
}
