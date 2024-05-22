import 'package:flutter/material.dart';
import 'package:todo_testwork/src/app/app_constants/app_constants.dart';
import 'package:todo_testwork/src/app/extensions/string_hardcoded.dart';


/// Shows a dialog that allows the user to enter a new todo description.
///
/// [context] The BuildContext used to display the dialog.
/// [initialText] An optional initial text to pre-fill the dialog's text field.
///
/// Returns the text entered by the user, or `null` if the dialog was canceled.
Future<String?> showDescriptionDialog(BuildContext context,
    [String? initialText]) async {
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
  const _TodoDialog({required this.onEditing, this.initialText});
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