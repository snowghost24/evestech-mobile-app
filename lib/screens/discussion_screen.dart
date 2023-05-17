// import 'package:evestech/multi_select.dart';
// import 'package:evestech/quill_html.dart';
// // import 'package:evestech/widgits/recipient_select.dart';
// import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// class DiscussionScreen extends StatefulWidget {
//   static const routeName = 'discussion_screen';
//   final Function addTx;

//   const DiscussionScreen({super.key, required this.addTx});

//   @override
//   State<DiscussionScreen> createState() => _DiscussionScreenState();
// }

// class _DiscussionScreenState extends State<DiscussionScreen> {
//   DateTime? _selectedDate;

//   final titleController = TextEditingController();
//   final amountController = TextEditingController();

//   final quilTextController = TextEditingController();
//   final _recipientSelectNode = FocusNode();
//   final _quillTextNode = FocusNode();
//   bool showSelect = false;

//   void _submitData() {
//     final enteredTitle = titleController.text;
//     final enteredQuillValue = quilTextController.text;
//     print(enteredQuillValue);
//     final enteredAmount = amountController.text.isEmpty
//         ? 0.00
//         : double.parse(amountController.text);

//     if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
//       return;
//     }
//     widget.addTx(titleController.text, double.parse(amountController.text),
//         _selectedDate);
//     // closes the current model
//     // no need to pass context is passed automatically to state widgits just like the widget thing.
//     Navigator.of(context).pop();
//   }

//   void _switchState() {
//     setState(() {
//       showSelect = _recipientSelectNode.hasFocus;
//     });

//     print('im switching state ${_recipientSelectNode.hasFocus}');
//   }

//   @override
//   void initState() {
//     _recipientSelectNode.addListener(_switchState);
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _recipientSelectNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color: Colors.blue,
//             ),
//           ),
//           margin: EdgeInsets.only(
//               top: 10,
//               left: 10,
//               right: 10,
//               bottom: MediaQuery.of(context).viewInsets.bottom + 10),
//           child: Container(
//             padding: const EdgeInsets.all(10),
//             child: Column(children: const [
//               MultiSelectBottomSheetWidget(),
//               QuillHtml()
//               // RecipientsSelect(recipientSelectNode: _recipientSelectNode),
//               // TextFormField(
//               //   // initialValue: '',
//               //   decoration: const InputDecoration(labelText: 'Title'),
//               //   textInputAction: TextInputAction.next,
//               //   keyboardType: TextInputType.text,
//               //   controller: quilTextController,
//               //   onFieldSubmitted: (value) {
//               //     // move the focus to the next field
//               //     FocusScope.of(context).requestFocus(_quillTextNode);
//               //   },
//               //   // this is triggered when validate is called on the form
//               //   validator: (value) {
//               //     if (value!.isEmpty) {
//               //       // returning text means you have an error
//               //       return 'Please provide a value.';
//               //     }
//               //     // returning null means input is correct
//               //     return null;
//               //   },
//               //   onSaved: (value) {
//               //     // _editedProduct = Product(
//               //     //     title: value as String,
//               //     //     price: _editedProduct.price,
//               //     //     description: _editedProduct.description,
//               //     //     imageUrl: _editedProduct.imageUrl,
//               //     //     id: _editedProduct.id,
//               //     //     isFavorite: _editedProduct.isFavorite);
//               //   },
//               // ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';

// import 'package:evestech/multi_select.dart';
// import 'package:flutter/material.dart';
// import 'package:quill_html_editor/quill_html_editor.dart';

// class DiscussionScreen extends StatefulWidget {
//   static const routeName = 'discussion_screen';
//   final Function addTx;

//   const DiscussionScreen({super.key, required this.addTx});

//   @override
//   State<DiscussionScreen> createState() => _DiscussionScreenState();
// }

// class _DiscussionScreenState extends State<DiscussionScreen> {
//   ///[controller] create a QuillEditorController to access the editor methods
//   late QuillEditorController controller;

//   ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

//   final customToolBarList = [
//     ToolBarStyle.bold,
//     ToolBarStyle.italic,
//     ToolBarStyle.align,
//     ToolBarStyle.color,
//     ToolBarStyle.background,
//     ToolBarStyle.listBullet,
//     ToolBarStyle.listOrdered,
//     ToolBarStyle.clean,
//     ToolBarStyle.addTable,
//     ToolBarStyle.editTable,
//   ];
//   var fieldHasFocus = false;

//   final _backgroundColor = Colors.grey.shade100;
//   final _toolbarIconColor = Colors.white;
//   final _editorTextStyle = const TextStyle(
//       fontSize: 17, color: Colors.black, fontWeight: FontWeight.w200);
//   final _hintTextStyle = const TextStyle(
//       fontSize: 18, color: Colors.black12, fontWeight: FontWeight.normal);

//   @override
//   void initState() {
//     controller = QuillEditorController();
//     controller.onTextChanged((text) {
//       debugPrint('listening to $text');
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     /// please do not forget to dispose the controller
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     final toolbarColor = Theme.of(context).colorScheme.primary;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Create new message'),
//         ),
//         backgroundColor: Colors.white,
//         resizeToAvoidBottomInset: true,
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const MultiSelectBottomSheetWidget(),
//               Flexible(
//                 fit: FlexFit.tight,
//                 child: QuillHtmlEditor(
//                     text:
//                         "<h1>Hello</h1>This is a quill html editor example 😊",
//                     hintText: 'Hint text goes here',
//                     controller: controller,
//                     isEnabled: true,
//                     minHeight: 500,
//                     textStyle: _editorTextStyle,
//                     hintTextStyle: _hintTextStyle,
//                     hintTextAlign: TextAlign.start,
//                     padding: const EdgeInsets.only(left: 10, top: 8),
//                     hintTextPadding: const EdgeInsets.only(left: 20),
//                     backgroundColor: _backgroundColor,
//                     onFocusChanged: (hasFocus) {
//                       debugPrint('has focus $hasFocus');
//                     },
//                     onTextChanged: (text) =>
//                         debugPrint('widget text change $text'),
//                     onEditorCreated: () {
//                       debugPrint('Editor has been loaded');
//                       setHtmlText('Testing text on load');
//                     },
//                     onEditorResized: (height) =>
//                         debugPrint('Editor resized $height'),
//                     onSelectionChanged: (sel) {
//                       debugPrint('index ${sel.index}, range ${sel.length}');
//                       // unFocusEditor();
//                     }),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Visibility(
//           visible: true,
//           child: Container(
//             width: double.maxFinite,
//             color: toolbarColor,
//             child: Wrap(
//               children: [
//                 SizedBox(
//                   width: deviceSize.width * .98,
//                   child: ToolBar.scroll(
//                     toolBarColor: toolbarColor,
//                     padding: const EdgeInsets.all(8),
//                     iconSize: 25,
//                     iconColor: _toolbarIconColor,
//                     activeIconColor: Colors.greenAccent.shade400,
//                     controller: controller,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     direction: Axis.horizontal,
//                     customButtons: [
//                       InkWell(
//                           onTap: () => unFocusEditor(),
//                           child: const Icon(
//                             Icons.favorite,
//                             color: Colors.black,
//                           )),
//                       InkWell(
//                           onTap: () async {
//                             var selectedText =
//                                 await controller.getSelectedText();
//                             debugPrint('selectedText $selectedText');
//                             var selectedHtmlText =
//                                 await controller.getSelectedHtmlText();
//                             debugPrint('selectedHtmlText $selectedHtmlText');
//                           },
//                           child: const Icon(
//                             Icons.add_circle,
//                             color: Colors.black,
//                           )),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 90,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget textButton({required String text, required VoidCallback onPressed}) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: MaterialButton(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           color: _toolbarIconColor,
//           onPressed: onPressed,
//           child: Text(
//             text,
//             // style: TextStyle(color: toolbarColor),
//           )),
//     );
//   }

//   ///[getHtmlText] to get the html text from editor
//   void getHtmlText() async {
//     String? htmlText = await controller.getText();
//     debugPrint(htmlText);
//   }

//   ///[setHtmlText] to set the html text to editor
//   void setHtmlText(String text) async {
//     await controller.setText(text);
//   }

//   ///[insertNetworkImage] to set the html text to editor
//   void insertNetworkImage(String url) async {
//     await controller.embedImage(url);
//   }

//   ///[insertVideoURL] to set the video url to editor
//   ///this method recognises the inserted url and sanitize to make it embeddable url
//   ///eg: converts youtube video to embed video, same for vimeo
//   void insertVideoURL(String url) async {
//     await controller.embedVideo(url);
//   }

//   /// to set the html text to editor
//   /// if index is not set, it will be inserted at the cursor postion
//   void insertHtmlText(String text, {int? index}) async {
//     await controller.insertText(text, index: index);
//   }

//   /// to clear the editor
//   void clearEditor() => controller.clear();

//   /// to enable/disable the editor
//   void enableEditor(bool enable) => controller.enableEditor(enable);

//   /// method to un focus editor
//   void unFocusEditor() => controller.unFocus();
// }

import 'package:flutter/material.dart';
// import 'package:flutter/material.dart/Text';

import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../multi_select.dart';

class DiscussionScreen extends StatefulWidget {
  static const routeName = 'discussion_screen';
  const DiscussionScreen({super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  final _controller = quill.QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.abc),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: MultiSelectBottomSheetWidget(),
                    ),
                    const Expanded(
                      child: SizedBox(
                        // color: Colors.green,
                        child: Text(
                          'body',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: quill.QuillEditor.basic(
                          controller: _controller, readOnly: false),
                    ),
                    quill.QuillToolbar.basic(
                      // showQuote: false,
                      controller: _controller,
                      showFontFamily: false,
                      showCodeBlock: false,
                      showBackgroundColorButton: false,
                      showLink: false,
                      showSearchButton: false,
                      showDividers: false,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom + 20)
                  ]),
                )));
      }),
    );
  }
}
