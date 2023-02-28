import 'dart:core';
import 'class.dart';
import 'race.dart';
import 'werewolves_type.dart';

class Player{
  Player(this.name,this.race , this.playerClass, this.role) {
    ac = role.ac;
    health = role.health;
    StrengthBonus = role.strengthBonus;
    hitChanceBonus = role.hitChanceBonus;
  }
  String name;
  Race race;
  Class playerClass;
  WerewolvesType role;

  int? ac;
  int? health;
  int? StrengthBonus;
  int? hitChanceBonus;
}