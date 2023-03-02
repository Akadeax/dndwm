import 'dart:core';
import 'player_class.dart';
import 'race.dart';
import 'role.dart';

class Player{
  Player(this.name,this.race , this.playerClass, this.role) {
    ac = role.ac!;
    health = role.health!;
    strengthBonus = role.strengthBonus!;
    hitChanceBonus = role.hitChanceBonus!;
    originalRace = race;
    healthBefore = role.health!;
    extraInfo = "";
  }
  String name;
  Race race;
  PlayerClass playerClass;
  Role role;

  late String extraInfo;
  late int ac;
  late int health;
  late int strengthBonus;
  late int hitChanceBonus;
  late Race originalRace;
  late int healthBefore;
}