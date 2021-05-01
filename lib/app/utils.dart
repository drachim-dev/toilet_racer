import 'package:flame/extensions.dart';

/// calculates the middle vertices between [first] and [second]
/// [first] and [second] must be of equal size
List<Vector2> getMiddleVertices(List<Vector2> first, List<Vector2> second) {
  if (first.length != second.length) {
    throw RangeError(
        'first (size: ${first.length}) != second (size: ${second.length})');
  }

  var middle = List<Vector2>.from(first);
  for (var i = 0; i < first.length; i++) {
    middle[i].add(second[i]);
    middle[i].scale(0.5);
  }
  return middle;
}