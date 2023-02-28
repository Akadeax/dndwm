import 'package:flutter/material.dart';
import 'dart:core';
import 'race.dart';
import 'class.dart';
import 'player.dart';
import 'werewolves_type.dart';
List<Race> races = [
  Race("Dwarf", "Bold and hardy, dwarves are known as skilled warriors, miners, and workers of stone and metal. Though they stand well under 5 feet tall, dwarves are so broad and compact that they can weigh as much as a human standing nearly two feet taller", ["advantage on drinking const rolls"]),
  Race("Elf", "Bold and hardy, dwarves are known as skilled warriors, miners, and workers of stone and metal. Though they stand well under 5 feet tall, dwarves are so broad and compact that they can weigh as much as a human standing nearly two feet taller", ["advantage on drinking const rolls"]),
];
List<Class> classes = [
  Class("Monk","",[0,5,0,0,2,0],"Acrobatics"),
  Class("Druid","",[0,0,2,0,5,0], "Animal Talk"),
];
List<WerewolvesType> roles = [
  WerewolvesType("Werewolf",14,20,5,5),
  WerewolvesType("Seer",13,12,2,0),
  WerewolvesType("Witch",13,15,2,0),
  WerewolvesType("Eldest",10,12,4,0),
  WerewolvesType("Hunter",14,12,7,3),
  WerewolvesType("Cupid",9,10,1,-1),
  WerewolvesType("Villager",12,12,4,0),
];
List<Player> players = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'DNDWolves Manager',
      home: HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  void onSubmit() {
    Race race = races.firstWhere((element) => element.name == selectedRace);
    Class playerClass = classes.firstWhere((element) => element.name == selectedClass);
    WerewolvesType role = roles.firstWhere((element) => element.name == selectedRole);
    players.add(Player(_playerNameController.text, race, playerClass, role));
    setState(() {
      selectedRace = null;
      selectedClass = null;
      selectedRole = null;
      _playerNameController.text = "";
    });
  }
  void onFinish() {

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
    return Container(
      color: Colors.deepOrangeAccent,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 50,
            child: TextField(
              controller: _playerNameController,
            ),
          ),
          Container(width: 100, height: 0),
          DropdownButton<String?>(
            value: selectedRace,
            items: races.map((e) {
              return DropdownMenuItem(value: e.name, child: Text(e.name));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedRace = newValue;
              });
            },
          ),
          Container(width: 100, height: 0),
          DropdownButton<String?>(
            value: selectedClass,
            items: classes.map((e) {
              return DropdownMenuItem(value: e.name, child: Text(e.name));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedClass = newValue;
              });
            },
          ),
          Container(width: 100, height: 0),
          DropdownButton<String?>(
            value: selectedRole,
            items: roles.map((e) {
              return DropdownMenuItem(value: e.name, child: Text(e.name));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedRole = newValue;
              });
            },
          ),
          Container(width: 100, height: 0),
          TextButton(
              onPressed: onSubmit,
              child: Text("make new Player")
          ),
          Container(width: 100, height: 0),
          TextButton(
              onPressed: onFinish,
              child: Text("Start the Game")
          ),
        ],
      ),
    );
  }

  Widget playerList(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.cyan,
      child: ListView.builder(
        itemCount: players.length,
        itemBuilder: (ctx, i) {
          return Text(players[i].name);
        }
      ),
    );
  }
}
