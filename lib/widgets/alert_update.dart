import 'package:flutter/material.dart';
import 'package:hive_crud/home_page.dart';

import '../functions/db_functions.dart';
import '../model/data_model.dart';

class AlertUpdate {
  Future<void> onUpdatePressed(BuildContext context, int index,
      PersonModel person) async {
    TextEditingController nameController =
    TextEditingController(text: person.name);
    TextEditingController ageController = TextEditingController(
        text: person.age);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          title: const Text('Edit Person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                PersonModel updatedPerson = PersonModel(
                  name: nameController.text,
                  age: ageController.text,
                );
                await updatePerson(index, updatedPerson);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
