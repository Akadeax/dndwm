import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_provider.dart';
import 'player_page.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
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
    DataProvider data = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game"),
      ),
      body: Container(
        height: 400,
        color: Colors.cyan,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Provider.of<DataProvider>(context).players.length,
            itemBuilder: (ctx, i) {
              return Row(
                children:
                [
                  if (i == 0)
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
                          child: Text(data.players[i].name),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PlayerPage(data.players[i])),
                            );
                          }
                      ),
                      SizedBox(
                        height: 50, width: 100,
                        child: TextButton(
                          child: const Text("Damage"),
                          onPressed: (){
                            setState(() {
                              data.players[i].health -= int.tryParse(_damageController.text) ?? 0;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: Center(child: Text("HP: ${data.players[i].health}")),
                      ),
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: Center(child : Text("AC: ${data.players[i].ac}")),
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
