import 'package:dndwm/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game.dart';
import 'player.dart';
import 'player_class.dart';
import 'race.dart';
import 'role.dart';

class PlayerCreation extends StatefulWidget {
  const PlayerCreation({Key? key}) : super(key: key);

  @override
  State<PlayerCreation> createState() => _PlayerCreationState();
}

class _PlayerCreationState extends State<PlayerCreation> {
  String? selectedRace;
  String? selectedClass;
  String? selectedRole;
  late TextEditingController _playerNameController;

  @override
  void initState() {
    super.initState();
    _playerNameController = TextEditingController();
  }

  @override
  void dispose() {
    _playerNameController.dispose();
    super.dispose();
  }
  void onSubmit(BuildContext context) {
    DataProvider data = Provider.of(context);

    Race race = data.staticData.races!.firstWhere((element) => element.name == selectedRace);
    PlayerClass playerClass = data.staticData.classes!.firstWhere((element) => element.name == selectedClass);
    Role role = data.staticData.roles!.firstWhere((element) => element.name == selectedRole);
    data.players.add(Player(_playerNameController.text, race, playerClass, role));
    setState(() {
      selectedRace = null;
      selectedClass = null;
      selectedRole = null;
      _playerNameController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            playerInputRow(context),
            playerList(context),
          ],
        )
    );
  }

  Widget playerInputRow(BuildContext context) {
    DataProvider data = Provider.of(context);

    return Container(
      color: Colors.cyanAccent,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 50,
            child: TextField(
              controller: _playerNameController,
            ),
          ),
          const SizedBox(width: 100, height: 0),
          DropdownButton<String?>(
            value: selectedRace,
            items: data.staticData.races?.map((e) {
              return DropdownMenuItem(value: e.name, child: Text(e.name!));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedRace = newValue;
              });
            },
          ),
          const SizedBox(width: 100, height: 0),
          DropdownButton<String?>(
            value: selectedClass,
            items: data.staticData.classes!.map((e) {
              return DropdownMenuItem(value: e.name, child: Text(e.name!));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedClass = newValue;
              });
            },
          ),
          const SizedBox(width: 100, height: 0),
          DropdownButton<String?>(
            value: selectedRole,
            items: data.staticData.roles!.map((e) {
              return DropdownMenuItem(value: e.name, child: Text(e.name!));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedRole = newValue;
              });
            },
          ),
          const SizedBox(width: 100, height: 0),
          TextButton(
              onPressed: () => onSubmit(context),
              child: const Text("make new Player")
          ),
          const SizedBox(width: 100, height: 0),
          TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Game()),
                );
              },
              child: const Text("Start the Game")
          ),
        ],
      ),
    );
  }

  Widget playerList(BuildContext context) {
    DataProvider data = Provider.of(context);

    return Container(
      height: 300,
      color: Colors.cyan,
      child: ListView.builder(
          itemCount: data.players.length,
          itemBuilder: (ctx, i) {
            return Text(data.players[i].name);
          }
      ),
    );
  }
}