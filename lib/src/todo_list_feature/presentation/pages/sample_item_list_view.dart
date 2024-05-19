import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_testwork/src/settings/settings_view.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';
import 'package:todo_testwork/src/todo_list_feature/presentation/state_managers/todo_boc/todo_bloc.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  static const routeName = '/';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<TodoBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
              title: Text('SampleItem ${item.id}'),
              leading: const CircleAvatar(
                // Display the Flutter Logo image asset.
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                bloc.add(
                  AddEvent(
                    todo: TodoEntity(
                        id: Random.secure().nextInt(9999),
                        title: 'New random item'),
                  ),
                );
              });
        },
      ),
    );
  }
}

class SampleItem {
  final int id;

  const SampleItem(this.id);
}
