import 'package:toilet_racer/models/player.dart';

class PlayerRepository {
  static final _fly = Player(
      name: 'Fly',
      scale: 1.2,
      filePaths: Iterable<int>.generate(2)
          .map((index) => 'player/fly/movement/fly_move$index.png')
          .toList());

  static final _larva = Player(
      name: 'Larva',
      filePaths: Iterable<int>.generate(8)
          .map((index) => index + 2)
          .map((index) => 'player/larva/movement/larva_move$index.png')
          .toList());

  static final _frog = Player(
      name: 'Frog',
      filePaths: Iterable<int>.generate(7)
          .map((index) => 'player/frog/movement/frog_move$index.png')
          .toList());

  static final _bee = Player(
      name: 'Bee',
      filePaths: Iterable<int>.generate(5)
          .map((index) => 'player/bee/movement/bee_move$index.png')
          .toList());

  static final _snake = Player(
      name: 'Snake',
      scale: 0.6,
      filePaths: Iterable<int>.generate(8)
          .map((index) => 'player/snake/movement/snake_move$index.png')
          .toList());

  static final _mosquitoLarva1 = Player(
      name: 'Mosquito Larva',
      filePaths: Iterable<int>.generate(10)
          .map((index) =>
              'player/mosquito_larva1/movement/mosquito_larva1_move$index.png')
          .toList());

  static final _bugBeetle = Player(
      name: 'Beetle',
      scale: 0.8,
      filePaths: Iterable<int>.generate(5)
          .map(
              (index) => 'player/bug_beetle/movement/bug_beetle_move$index.png')
          .toList());

  static final _policeCar = Player(
      name: 'Police',
      scale: 0.9,
      filePaths: Iterable<int>.generate(3)
          .map((index) => 'player/policecar/movement/policecar_move$index.png')
          .toList());

  static final _alien = Player(
      name: 'Alien',
      filePaths: Iterable<int>.generate(9)
          .map((index) => 'player/alien/movement/alien_move$index.png')
          .toList());

  static final _mosquitoLarva2 = Player(
      name: 'Mosquito Larva',
      filePaths: Iterable<int>.generate(10)
          .map((index) =>
              'player/mosquito_larva2/movement/mosquito_larva2_move$index.png')
          .toList());

  static final _rat =
      Player(name: 'Scabbers', scale: 0.85, filePaths: ['player/rat.png']);

  static final _allPlayers = [
    _fly,
    _larva,
    _frog,
    _bee,
    _snake,
    _mosquitoLarva1,
    _bugBeetle,
    _policeCar,
    _alien,
    // _mosquitoLarva2,
    _rat,
  ];

  List<Player> getAllPlayers() {
    return _allPlayers;
  }
}
