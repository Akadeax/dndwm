import 'package:flutter/material.dart';
import 'dart:core';
import 'race.dart';
import 'class.dart';
import 'player.dart';
import 'werewolves_type.dart';
List<Race> races = [
  Race("Dwarf", "Bold and hardy, dwarves are known as skilled warriors, miners, and workers of stone and metal. Though they stand well under 5 feet tall, dwarves are so broad and compact that they can weigh as much as a human standing nearly two feet taller", ["advantage on drinking const rolls"]),
  Race("Elf", "Bold and hardy, dwarves are known as skilled warriors, miners, and workers of stone and metal. Though they stand well under 5 feet tall, dwarves are so broad and compact that they can weigh as much as a human standing nearly two feet taller", ["advantage on drinking const rolls"]),
  Race("Frog","Ribbit",["Ribbit"]),
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
      home: PlayerCreation()
    );
  }
}

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
      color: Colors.cyanAccent,
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
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _Game()),
                );
              },
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
class _Game extends StatefulWidget {
  const _Game({Key? key}) : super(key: key);

  @override
  State<_Game> createState() => _GameState();
}

class _GameState extends State<_Game> {
  late TextEditingController _damageController;

  @override
  void initState() {
    super.initState();
    _damageController = TextEditingController();
  }

  @override
  void dispose() {
    _damageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game"),
      ),
      body: Container(
        height: 400,
        color: Colors.cyan,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: players.length,
            itemBuilder: (ctx, i) {
              return Row(
                children:
                [
                  SizedBox(
                    height: 50, width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _damageController,
                    ),
                  ),
                  Column(
                    children: [
                      TextButton(
                          child: Text(players[i].name),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => _PlayerPage(players[i])),
                            );
                          }
                      ),
                      SizedBox(
                        height: 50, width: 100,
                        child: TextButton(
                          child: Text("Damage"),
                          onPressed: (){
                            setState(() {
                              players[i].health -= int.tryParse(_damageController.text) ?? 0;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: Center(child: Text("HP: ${players[i].health}")),
                      ),
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: Center(child : Text("AC: ${players[i].ac}")),
                      )
                    ],
                  ),
                ],
              );
            }
        ),
      ),
    );
    }
}

class _PlayerPage extends StatefulWidget {
  const _PlayerPage(this.player, {Key? key}) : super(key: key);
  final Player player;
  @override
  State<_PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<_PlayerPage> {
  String? selectedAction;
  late TextEditingController _ExtraInfoController;

  @override
  void initState() {
    super.initState();
    _ExtraInfoController = TextEditingController();
    _ExtraInfoController.text = widget.player.extraInfo;
  }

  @override
  void dispose() {
    _ExtraInfoController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.player.name),
      ),
      body: Center(
        child: Column(
          children:[
            Container(
              width: 100,
              height: 25,
              child: Center(child: Text(widget.player.name.toString())),
            ),
            Container(
              width: 100,
              height: 25,
              child: Center(child: Text(widget.player.race.name.toString())),
            ),
            Container(
              width: 100,
              height: 25,
              child: Center(child: Text(widget.player.playerClass.name.toString())),
            ),
            Container(
              width: 100,
              height: 50,
              child: Center(child: Text("health: ${widget.player.health}")),
            ),
            Container(
              width: 100,
              height: 50,
              child: Center(child: Text("ac: ${widget.player.ac}")),
            ),
            Container(
              width: 200,
              height: 50,
              child: Center(child: Text("hit chance bonus: ${widget.player.hitChanceBonus}")),
            ),
            Container(
              width: 100,
              height: 50,
              child: Center(child: Text("Strength: ${widget.player.strengthBonus}")),
            ),
            Container(
              width: 100,
              height: 50,
              child: Center(child: Text("Class feature: ${widget.player.playerClass.feature}")),
            ),

            DropdownButton<String>(
              items: const [
                DropdownMenuItem(child: Text("Frogify"), value: "Frogify"),
                DropdownMenuItem(child: Text("Revive"), value: "Revive"),
                DropdownMenuItem(child: Text("ReturnForm"), value: "ReturnForm"),

              ],
              onChanged:(String? newValue){
                setState(() {
                  selectedAction = newValue;
                });
              },
              value: selectedAction,
            ),
            TextButton(
              child: Text("Action"),
              onPressed: (){
                setState(() {
                  switch (selectedAction){
                    case "Frogify":
                      widget.player.race = races.firstWhere((element) => element.name == "Frog");
                      widget.player.healthBefore =widget.player.health;
                      widget.player.health = 5;
                      widget.player.ac = 5;
                      widget.player.hitChanceBonus = 0;
                      widget.player.strengthBonus = 0;

                      break;
                    case "Revive":
                      widget.player.health = widget.player.role.health;
                      widget.player.ac = widget.player.role.ac;
                      widget.player.hitChanceBonus = widget.player.role.hitChanceBonus;
                      widget.player.strengthBonus = widget.player.role.strengthBonus;
                      widget.player.race = widget.player.originalRace;
                      break;
                    case "ReturnForm":
                        widget.player.race = widget.player.originalRace;
                        widget.player.health = widget.player.healthBefore;
                        widget.player.ac = widget.player.role.ac;
                        widget.player.hitChanceBonus = widget.player.role.hitChanceBonus;
                        widget.player.strengthBonus = widget.player.role.strengthBonus;
                      break;
                  }
                });
              },
            ),
            Container(
              width: 100,
              height: 50,
              child: Center(child: Text("Extra info")),
            ),
            Container(
              width: 500,
              height: 200,
              child: TextField(
                controller: _ExtraInfoController,
                onChanged: (String newValue){
                  widget.player.extraInfo = newValue;
                },
                maxLines: null,
              )
            )
          ]
        ),
      )
    );
  }
}

