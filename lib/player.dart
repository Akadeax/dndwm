import 'dart:core';
import 'class.dart';
import 'race.dart';
import 'werewolves_type.dart';

class Player{
  Player(this.name,this.race , this.playerClass, this.role) {
    ac = role.ac;
    health = role.health;
    strengthBonus = role.strengthBonus;
    hitChanceBonus = role.hitChanceBonus;
    originalRace = race;
  }
  String name;
  Race race;
  Class playerClass;
  WerewolvesType role;

  late int ac;
  late int health;
  late int strengthBonus;
  late int hitChanceBonus;
  late Race originalRace;
}