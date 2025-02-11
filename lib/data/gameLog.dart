import 'package:hive_flutter/hive_flutter.dart';

part 'gameLog.g.dart';

// Hive object
@HiveType(typeId: 1)
class Gamelog {
  @HiveField(0)
  final int gameType;

  @HiveField(1)
  final String result;

  @HiveField(2)
  final String date;

  Gamelog(this.gameType, this.result, this.date);
}
