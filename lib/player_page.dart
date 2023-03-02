import 'package:dndwm/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'player.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage(this.player, {Key? key}) : super(key: key);
  final Player player;
  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  String? selectedAction;
  late TextEditingController _extraInfoController;

  @override
  void initState() {
    super.initState();
    _extraInfoController = TextEditingController();
    _extraInfoController.text = widget.player.extraInfo;
  }

  @override
  void dispose() {
    _extraInfoController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    DataProvider data = Provider.of<DataProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.player.name),
        ),
        body: Center(
          child: Column(
              children:[
                SizedBox(
                  width: 100,
                  height: 25,
                  child: Center(child: Text(widget.player.name.toString())),
                ),
                SizedBox(
                  width: 100,
                  height: 25,
                  child: Center(child: Text(widget.player.race.name.toString())),
                ),
                SizedBox(
                  width: 100,
                  height: 25,
                  child: Center(child: Text(widget.player.playerClass.name.toString())),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: Center(child: Text("health: ${widget.player.health}")),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: Center(child: Text("ac: ${widget.player.ac}")),
                ),
                SizedBox(
                  width: 200,
                  height: 30,
                  child: Center(child: Text("hit chance bonus: ${widget.player.hitChanceBonus}")),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: Center(child: Text("Strength: ${widget.player.strengthBonus}")),
                ),
                SizedBox(
                  width: 200,
                  height: 30,
                  child: Center(child: Text("Class feature: ${widget.player.playerClass.feature}")),
                ),

                DropdownButton<String>(
                  items: const [
                    DropdownMenuItem(value: "Frogify", child: Text("Frogify")),
                    DropdownMenuItem(value: "Revive", child: Text("Revive")),
                    DropdownMenuItem(value: "ReturnForm", child: Text("Return to original form")),
                    DropdownMenuItem(value: "IsMayor",child: Text("Is Mayor"),),
                  ],
                  onChanged:(String? newValue){
                    setState(() {
                      selectedAction = newValue;
                    });
                  },
                  value: selectedAction,
                ),
                TextButton(
                  child: const Text("Action"),
                  onPressed: (){
                    setState(() {
                      switch (selectedAction){
                        case "Frogify":
                          widget.player.race = data.staticData.races!.firstWhere((element) => element.name == "Frog");
                          widget.player.healthBefore =widget.player.health;
                          widget.player.health = 5;
                          widget.player.ac = 5;
                          widget.player.hitChanceBonus = 0;
                          widget.player.strengthBonus = 0;

                          break;
                        case "Revive":
                          widget.player.health = widget.player.role.health!;
                          widget.player.ac = widget.player.role.ac!;
                          widget.player.hitChanceBonus = widget.player.role.hitChanceBonus!;
                          widget.player.strengthBonus = widget.player.role.strengthBonus!;
                          widget.player.race = widget.player.originalRace;
                          break;
                        case "ReturnForm":
                          widget.player.race = widget.player.originalRace;
                          widget.player.health = widget.player.healthBefore;
                          widget.player.ac = widget.player.role.ac!;
                          widget.player.hitChanceBonus = widget.player.role.hitChanceBonus!;
                          widget.player.strengthBonus = widget.player.role.strengthBonus!;
                          break;
                        case "IsMayor":
                          if (widget.player.ac <= widget.player.role.ac!) {
                            widget.player.ac += 4;
                          }
                          break;
                      }
                    });
                  },
                ),
                const SizedBox(
                  width: 100,
                  height: 50,
                  child: Center(child: Text("Extra info")),
                ),
                SizedBox(
                    width: 500,
                    height: 200,
                    child: TextField(
                      controller: _extraInfoController,
                      onChanged: (String newValue){
                        widget.player.extraInfo = newValue;
                      },
                      maxLines: null,
                    ),
                ),
              ],
          ),
        ),
    );
  }
}
