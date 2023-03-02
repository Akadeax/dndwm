import 'package:dndwm/static_data_container.dart';
import 'package:dndwm/player.dart';

class DataProvider {
  DataProvider(this.players, this.staticData);

  List<Player> players;
  StaticDataContainer staticData;
}