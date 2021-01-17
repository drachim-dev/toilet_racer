import 'package:firebase_admob/firebase_admob.dart';
import 'package:flame/flame.dart';
import 'package:flame/game/game_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toilet_racer/app/ad_manager.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/race_game.dart';
import 'package:toilet_racer/views/overlay_ui.dart';
import 'package:toilet_racer/views/start_menu.dart';
import 'package:vector_math/vector_math_64.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  Flame.initializeWidget();
  await Flame.util.fullScreen();
  await Flame.util.setOrientation(DeviceOrientation.portraitUp);
  final size = await Flame.util.initialDimensions();

  await FirebaseAdMob.instance.initialize(appId: AdManager.appId);

  runApp(MyApp(size));
}

class MyApp extends StatefulWidget {
  final Vector2 size;

  MyApp(this.size);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RaceGame _game;
  InterstitialAd _ad;

  @override
  void initState() {
    super.initState();

    _ad = _buildAd()..load();
    _game = RaceGame(widget.size, roundEndCallback: _roundEndCallback);
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NerkoOne'),
      home: Material(
        child: GameWidget(
          game: _game,
          overlayBuilderMap: {
            startMenu: (_, game) => StartMenu(game),
            overlayUi: (_, game) => OverlayUi(),
          },
          initialActiveOverlays: const [startMenu],
        ),
      ),
    );
  }

  InterstitialAd _buildAd() {
    return InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      targetingInfo: MobileAdTargetingInfo(testDevices: [
        AdManager.testdDevice1,
        AdManager.testdDevice2,
      ]),
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          _ad..load();
        } else if (event == MobileAdEvent.closed) {
          _ad = _buildAd()..load();
        }
      },
    );
  }

  Future<bool> _showAd() {
    return _ad.show();
  }

  Future<void> _roundEndCallback() async {
    //await _showAd();
  }
}
