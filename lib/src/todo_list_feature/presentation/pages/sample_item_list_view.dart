import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_testwork/src/app/app_constants/item_colors.dart';
import 'package:todo_testwork/src/todo_list_feature/di/todo_list_scope.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';
import 'package:todo_testwork/src/todo_list_feature/presentation/state_managers/todo_boc/todo_bloc.dart';
import 'package:todo_testwork/src/todo_list_feature/presentation/widgets/show_description_dialog.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodoListScope>().todoListBloc;
    if (kDebugMode) {
      print('Print test');
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Sample Items'), actions: [
        BlocBuilder<TodoBloc, TodoState>(
          bloc: bloc,
          builder: (context, state) => switch (state) {
            Loading() => const SizedBox.shrink(),
            Loaded(:final selectedItemId) => selectedItemId != null
                ? Wrap(children: [
                    IconButton(
                      onPressed: () async {
                        final title = await showDescriptionDialog(context);
                        bloc.add(
                          UpdateItemTitle(
                              id: selectedItemId, title: title ?? ''),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () => bloc.add(
                        DoneEvent(
                          id: selectedItemId,
                        ),
                      ),
                      icon: const Icon(Icons.done_all_rounded),
                    ),
                    IconButton(
                      onPressed: () => bloc.add(
                        DeleteCheckedEvent(),
                      ),
                      icon: const Icon(Icons.delete_forever_outlined),
                    )
                  ])
                : const SizedBox.shrink(),
            Error() => const SizedBox.shrink(),
          },
        )
      ]),
      body: BlocBuilder<TodoBloc, TodoState>(
          bloc: bloc,
          builder: (context, state) {
            return switch (state) {
              Loading() => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              Error(:final message) => Center(
                  child: Text(message),
                ),
              Loaded(:final todoList) => ReorderableListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    final item = todoList[index];
                    return DecoratedBox(
                      key: ValueKey(item.id),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: item.id == state.selectedItemId
                              ? ItemColors.Amber.color.withOpacity(.2)
                              : null),
                      child: CheckboxListTile(
                        value: item.isCompleted,
                        title: Text('${item.title} ${item.index} ${item.id}'),
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(
                              SelectItem(id: item.id),
                            );
                          }
                        },
                      ),
                    );
                  },
                  onReorder: (oldIndex, newIndex) => bloc.add(
                    SwapEvent(
                      firsItemId: todoList.getItemIdByElementIndex(oldIndex),
                      secondItemId: todoList.getItemIdByElementIndex(newIndex),
                    ),
                  ),
                ),
            };
          }),
      floatingActionButton: FloatingActionButton.large(
        child: const Icon(Icons.plus_one),
        onPressed: () async {
          final title = await showDescriptionDialog(context);
          if (title != null) {
            bloc.add(
              AddEvent(
                title: title,
              ),
            );
          }
        },
      ),
    );
  }
}

extension on List<TodoEntity> {
  int getItemIdByElementIndex(int elementIndex) {
    return this[elementIndex.clamp(0, length - 1)].id;
  }
}
