import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_testwork/src/app/app_constants/app_constants.dart';
import 'package:todo_testwork/src/app/extensions/string_hardcoded.dart';


Future<String?> showDescriptionDialog(
  BuildContext context,
  [String? initialText]
) async {
  String? storedText;
  String onChanged(String text) => storedText = text;
  final result = await showAdaptiveDialog<String?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add a new todo'.hardcoded),
        content: _TodoDialog(
          initialText: initialText,
          onEditing: onChanged,
        ),
        actions: [
          TextButton(
            child: Text('Cancel'.hardcoded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Add'.hardcoded),
            onPressed: () {
              Navigator.pop(context, storedText);
            },
          ),
        ],
      );
    },
  );
  return result;
}


class _TodoDialog extends StatefulWidget {
  const _TodoDialog({super.key, this.initialText, required this.onEditing});
  final String? initialText;
  final ValueChanged<String> onEditing;
  @override
  State<_TodoDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<_TodoDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    if (widget.initialText != null) {
      controller.text = widget.initialText!;
    }
    controller.addListener(
      () => widget.onEditing(
        controller.text,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      minLines: 4,
      maxLines: 4,
      decoration: InputDecoration(
          hintText: 'Think about the important things'.hardcoded),
      maxLength: AppConstants.maxTitleLenght,
    );
  }
}