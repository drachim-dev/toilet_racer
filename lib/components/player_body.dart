import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/position_body_component.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/material.dart' as material;
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/components/player.dart';
import 'package:toilet_racer/services/timer_service.dart';
import 'package:vector_math/vector_math_64.dart' show Vector2;

import 'boundary.dart';

class PlayerBody extends PositionBodyComponent {
  static const pi = math.pi;
  static const pi2 = math.pi * 2;

  static Vector2 pointer(double angle, double length, [bool flipY = false]) {
    final rotation = Rot.withAngle(angle);
    if (flipY) {
      return Rot.mulTransVec2(rotation, Vector2(0, 1)..scale(length));
    } else {
      return Rot.mulVec2(rotation, Vector2(0, -1)..scale(length));
    }
  }

  /// Assure any angle to be in range (-pi..pi] (exclusive..inclusive]
  static double directionalAngle(double angle) {
    final normalizedAngle = normalizeAngle(angle);
    if (normalizedAngle > pi) {
      return normalizedAngle - pi2;
    }
    return normalizedAngle;
  }

  /// Assure any angle to be [0..2*pi) (inclusive..exclusive]
  static double normalizeAngle(double angle) {
    return (angle % pi2 + pi2) % pi2;
  }

  final Player player;

  /// Total time that the player exists.
  /// This will be used to make the player faster.
  double time = 0;

  final Vector2 startPosition;

  final bool counterclockwise;

  /// Angle of the direction the player wants to go.
  double bearing;

  final bool preview;

  final TimerService _timerService = locator<TimerService>();

  PlayerBody(this.player, this.startPosition,
      {this.preview = false, this.counterclockwise = true})
      : assert(player != null),
        assert(startPosition != null),
        super(player.positionComponent, player.positionComponent.size) {
    /// Player starts with bearing and heading
    /// in right direction when turning counterclockwise
    /// and in left direction when turning clockwise
    bearing = counterclockwise ? pi / 2 : -pi / 2;
  }

  @override
  Body createBody() {
    // desired mass of the player in kg
    const mass = 10;

    // Geometrical form of the collision object of the player
    // We use a small circle that's placed underneath the actual sprite
    final shape = CircleShape()
      // radius in m of the circle defines the size of the collision body of the player
      ..radius = 2;

    // The fixture describes the material properties
    final fixtureDef = FixtureDef(shape)
      // Dichte: compute the density based on our given mass and radius
      // we do this, so we can safely adjust the radius
      // without changing the forces applied to the player
      ..density = mass / (shape.radius * shape.radius * pi)
      // Elastizität: Not really relevant for us right now - using default value
      ..restitution = 0.0
      // Reibung: Not really relevant for us right now - using default value
      ..friction = 0.2;

    final bodyDef = BodyDef()
      // To be able to determine object in collision
      ..userData = this
      ..type = BodyType.dynamic
      ..position = gameRef.screenToWorld(startPosition)
      // heading and bearing are the same at start
      ..angle = bearing
      ..linearVelocity = Vector2.zero()
      ..angularVelocity = 0
      ..linearDamping = 0
      ..angularDamping = 0;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderCircle(Canvas c, Offset center, double radius) {
    super.renderCircle(c, center, radius);

    // draw lines to show heading and bearing
    final length = radius * 3;
    final heading = body.angle;
    final headingPointer = pointer(heading, length, true);
    final bearingPointer = pointer(bearing, length, true);
    c.drawLine(
        center,
        center + headingPointer.toOffset(),
        Paint()
          ..strokeWidth = 1
          ..color = Colors.red);
    c.drawLine(
        center,
        center + bearingPointer.toOffset(),
        Paint()
          ..strokeWidth = 1
          ..color = Colors.blue);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (preview) return;
    _timerService.update(dt);

    player.update(velocity: body.linearVelocity.length);

    time += dt;

    final heading = normalizeAngle(body.angle);

    // 1. Set new linear velocity of the player in direction of heading
    // See http://fooplot.com/#W3sidHlwZSI6MCwiZXEiOiIoLSh4LzYwLTEpXigyKSsxKSo5MCsxMCIsImNvbG9yIjoiIzAwMDAwMCJ9LHsidHlwZSI6MTAwMCwid2luZG93IjpbIi0yLjA3MjMwNzY5MjMwNzY5MjQiLCI4MCIsIi00Ljk2NTAwMDAwMDAwMDAwMSIsIjExMCJdfV0-

    const maxVelocity = 100.0;
    const timeToMaxVelocity = 60.0;
    const startVelocity = 10.0;

    final absoluteVelocity = time > timeToMaxVelocity
        ? maxVelocity
        : (-1.0 * math.pow(time / timeToMaxVelocity - 1.0, 2.0) + 1.0) *
                (maxVelocity - startVelocity) +
            startVelocity;
    final velocity = pointer(heading, absoluteVelocity);
    final impulse = (velocity - body.linearVelocity) * body.mass;
    body.applyLinearImpulse(impulse);

    // 2. Turns the players heading in direction of bearing

    const maxAngularVelocity = pi2 / 2; // 180°/s

    // Only turn the player when the difference between bearing and heading exceeds the turning threshold.
    // The threshold has to be small enough so the player does not notice.
    // The threshold has to be large enough so the turning algorithm settles and does not "flicker".
    // "Flickering" would occur when the player turns left and right by small steps the whole time.
    // Assuming a 60 Hz framerate.
    const turningThreshold = maxAngularVelocity / 60;

    final deltaAngle = directionalAngle(bearing - heading);

    final angularVelocity = deltaAngle.abs() < turningThreshold
        ? 0
        : deltaAngle > 0
            ? maxAngularVelocity
            : -maxAngularVelocity;

    final angularImpulse =
        (angularVelocity - body.angularVelocity) * body.inertia;
    body.applyAngularImpulse(angularImpulse);
  }

  /// Rotates the bearing of the player counterclockwise.
  void spin() {
    // How much to rotate the bearing
    // 20 means that you have to click 20 times for a full 360° turn
    final deltaBearing = counterclockwise ? pi2 / 20 : -pi2 / 20;
    bearing = normalizeAngle(bearing + deltaBearing);
  }
}

class BoundaryContactCallback extends ContactCallback<PlayerBody, Boundary> {
  final Function collisionDetected;

  BoundaryContactCallback(this.collisionDetected);

  @override
  void begin(PlayerBody player, Boundary boundary, Contact contact) {
    boundary.paint.color = material.Colors.red;
    collisionDetected();
  }

  @override
  void end(PlayerBody player, Boundary boundary, Contact contact) {}
}
