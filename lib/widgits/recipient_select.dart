import 'package:flutter/material.dart';

class RecipientsSelect extends StatelessWidget {
  final FocusNode? recipientSelectNode;
  const RecipientsSelect({super.key, this.recipientSelectNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(labelText: 'Recepients'),
      focusNode: recipientSelectNode,

      // controller: titleController,
      // onSubmitted: (_) => _submitData(),
    );
  }
}
