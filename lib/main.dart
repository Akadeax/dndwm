import 'dart:convert';
import 'dart:io';

import 'package:dndwm/race.dart';
import 'package:dndwm/static_data_container.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:core';
import 'data_provider.dart';
import 'player_class.dart';
import 'player_creation.dart';
import 'role.dart';

/*List<Race> races = [
  Race("Dwarf", "", ["advantage on drinking const rolls"]),
  Race("Elf", "", [""]),
  Race("Half-Elf", "", [""]),
  Race("Goliath", "", [""]),
  Race("Owlin", "", ["temp flight"]),
  Race("Tortle", "", [""]),
  Race("Tiefling", "", [""]),
  Race("Halfling", "", [""]),
  Race("kobold", "", [""]),
  Race("Human", "", [""]),
  Race("Orc", "", [""]),
  Race("Half-Orc", "", [""]),
  Race("Changeling", "", ["change appearance"]),
  Race("Locathah", "fish mf", ["aqua affinity"]),
  Race("Gnome", "", [""]),
  Race("Minotaur", "", [""]),
  Race("Aaraockra", "bird mf", ["temp flight"]),
  Race("Dragonborn", "", [""]),
  Race("Lizardmen", "", [""]),
  Race("Kenku", "", ["temp flight"]),
  Race("Fae", "", [""]),
  Race("Tabaski", "Lynx mf", [""]),
  Race("Plasmoid", "", ["fit's through small holes"]),
  Race("Loxedon", "elephant mf", [""]),
  Race("Goblin", "", [""]),
  Race("Satyr", "", [""]),
  Race("other", "", [""]),
  Race("Frog","Ribbit",["Ribbit"]),
];
List<PlayerClass> classes = [
  PlayerClass("Monk","",[0,5,0,0,2,0],"Acrobatics"),
  PlayerClass("Druid","",[0,0,2,0,5,0], "Animal Talk"),
  PlayerClass("Warrior","",[2,2,2,0,0,0], "Athletics"),
  PlayerClass("Barbarian","",[2,0,5,0,0,0], "survival"),
  PlayerClass("Paladin","",[0,0,5,0,0,2], "persuasion"),
  PlayerClass("Ranger","",[0,5,0,0,2,0], ""),
  PlayerClass("Rogue","",[0,5,0,1,0,1], ""),
  PlayerClass("Artificer","",[0,0,2,5,0,0], ""),
  PlayerClass("Cleric","",[0,0,2,0,5,0], ""),
  PlayerClass("Sorcerer","",[0,2,0,0,0,5], ""),
  PlayerClass("Wizard","",[0,0,0,5,2,0], ""),
  PlayerClass("Warlock","",[0,0,0,2,0,5], ""),
  PlayerClass("Bard","",[0,2,0,0,0,5], ""),

];
List<Role> roles = [
  Role("Werewolf",14,20,5,5),
  Role("Seer",13,12,2,0),
  Role("Witch",13,15,2,0),
  Role("Eldest",10,12,4,0),
  Role("Hunter",14,12,7,3),
  Role("Cupid",9,10,1,-1),
  Role("Villager",12,12,4,0),
];*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final Future<StaticDataContainer> staticDataLoadFuture;

  @override
  void initState() {
    staticDataLoadFuture = staticDataLoad();
    super.initState();
  }

  Future<StaticDataContainer> staticDataLoad() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Directory dataDir = Directory("${dir.path}/DNDWM");
    await dataDir.create();

    File staticDataFile = File("${dataDir.path}/data.json");

    if(!await staticDataFile.exists()) {
      StaticDataContainer debugContainer = StaticDataContainer(
        races: [ Race(name: "Test Race", description: "This is a test race", features: [ "Test Feature"] ) ],
        classes: [ PlayerClass(name: "Test Class", description: "This is a test class", bonus: [0, 5, 0, 0, 2, 0], feature: "Test Feature" ) ],
        roles: [ Role(name: "Test Role", ac: -1, health: -1, hitChanceBonus: -1, strengthBonus: -1) ],
      );
      var encoder = const JsonEncoder.withIndent("     ");
      await staticDataFile.writeAsString(encoder.convert(debugContainer.toJson()));
    }

    String fileString = await staticDataFile.readAsString();

    Map<String, dynamic> jsonData = jsonDecode(fileString);
    return StaticDataContainer.fromJson(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DNDWolves Manager',
      home: FutureBuilder<StaticDataContainer>(
        future: staticDataLoadFuture,
        builder: (ctx, snapshot) {
          if(snapshot.hasData) {
            return Provider<DataProvider>(
                create: (_) => DataProvider([], snapshot.requireData),
                child: const PlayerCreation()
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}




