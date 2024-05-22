import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_testwork/src/app/app_constants/item_colors.dart';
import 'package:todo_testwork/src/todo_list_feature/di/todo_list_scope.dart';
import 'package:todo_testwork/src/todo_list_feature/domain/entity/todo_entity.dart';
import 'package:todo_testwork/src/todo_list_feature/presentation/state_managers/todo_boc/todo_bloc.dart';
import 'package:todo_testwork/src/todo_list_feature/presentation/widgets/show_description_dialog.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  /// Displays a list of SampleItems.
  const SampleItemListView({
    super.key,
  });
  /// route name
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodoListScope>().todoListBloc;
    return Scaffold(
      appBar: AppBar(title: const Text('Sample Items'), actions: [
        BlocBuilder<TodoBloc, TodoState>(
          bloc: bloc,
          builder: (context, state) => switch (state) {
            Loading() => const SizedBox.shrink(),
            Loaded(:final selectedItem) => selectedItem != null
                ? Wrap(children: [
                    IconButton(
                      onPressed: () async {
                        final title = await showDescriptionDialog(
                            context, selectedItem.title);
                        if (title != null) {
                          bloc.add(
                            UpdateItemTitle(id: selectedItem.id, title: title),
                          );
                        }
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () => bloc.add(
                        DoneEvent(
                          id: selectedItem.id,
                        ),
                      ),
                      icon: const Icon(Icons.done_all_rounded),
                    ),
                    IconButton(
                      onPressed: () => bloc.add(
                        const DeleteCheckedEvent(),
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
                    return InkWell(
                      key: ValueKey(item.id),
                      onTap: () => bloc.add(
                        SelectItem(todo: item),
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: item.id == state.selectedItem?.id
                                ? ItemColors.amber.color.withOpacity(.2)
                                : null),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: item.color.color.withOpacity(0.6),
                          title: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Checkbox95(
                                value: item.isCompleted,
                                onChanged: (_) => bloc.add(
                                  DoneEvent(
                                    id: item.id,
                                  ),
                                ),
                              ),
                              Text(
                                item.title,
                                // TODO(me): replace with appStyles
                                style: Flutter95.headerTextStyle
                                    .copyWith(fontSize: 22),
                              ),
                            ],
                          ),
                        ),
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
        child: const Icon(Icons.add),
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
