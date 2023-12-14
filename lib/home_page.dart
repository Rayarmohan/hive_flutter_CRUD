import 'package:flutter/material.dart';
import 'package:hive_crud/functions/db_functions.dart';
import 'package:hive_crud/widgets/alert_dialog.dart';
import 'package:hive_crud/widgets/alert_update.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PersonModel> personModelList = [];

  Future<void> getAllPerson() async {
    final personDB = await Hive.openBox<PersonModel>('person_db');
    personModelList.clear();
    personModelList.addAll(personDB.values);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllPerson();
  }

  @override
  Widget build(BuildContext context) {
    getAllPerson();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Hive CRUD'),
        actions: [
          IconButton(
              onPressed: () async {
                await AlertDialogwidget().showAlertDialog(context);
                await getAllPerson();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SafeArea(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Name: ${personModelList[index].name}'),
                  subtitle: Text('Age : ${personModelList[index].age}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await AlertUpdate().onUpdatePressed(
                                context, index, personModelList[index]);
                            await getAllPerson();
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            await deletePerson(index);
                            await getAllPerson();
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: personModelList.length)),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
