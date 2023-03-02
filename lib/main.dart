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




