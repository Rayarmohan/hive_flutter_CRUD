
import 'package:hive_crud/model/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> addPerson(PersonModel value) async {
  final personDB = await Hive.openBox<PersonModel>('person_db');
  await personDB.add(value);


}

Future<void> deletePerson(int index) async {
  final personDB = await Hive.openBox<PersonModel>('person_db');
  await personDB.deleteAt(index);

}

Future<void> updatePerson(int index, PersonModel updatedPerson) async {
  final personDB = await Hive.openBox<PersonModel>('person_db');
  await personDB.putAt(index, updatedPerson);
}


