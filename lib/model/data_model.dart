import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class PersonModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String age;

  PersonModel({required this.name, required this.age});
}
