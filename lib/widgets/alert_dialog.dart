import 'package:flutter/material.dart';
import 'package:hive_crud/functions/db_functions.dart';
import 'package:hive_crud/home_page.dart';
import 'package:hive_crud/model/data_model.dart';

class AlertDialogwidget {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16),
            title: const Text("Add new Person"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Enter a Name"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Enter age"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancel")),
              TextButton(
                  onPressed: () async {
                    await onAddButtonclicked();
                    Navigator.pop(context);
                  },
                  child: const Text("Add"))
            ],
          );
        });
  }

  Future<void> onAddButtonclicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    if (!_age.isEmpty && !_name.isEmpty) {
      var person = PersonModel(name: _name, age: _age);
      addPerson(person);
    }
  }
}
