// import 'dart:convert';

// import 'package:flutter/material.dart';
// // import 'package:quill_html_editor/quill_html_editor.dart';
// // import 'package:quill_html_editor/quill_html_editor.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   runApp();
// // }

// class QuillHtml extends StatefulWidget {
//   const QuillHtml({super.key});

//   @override
//   State<QuillHtml> createState() => _QuillHtmlState();
// }

// class _QuillHtmlState extends State<QuillHtml> {
//   ///[controller] create a QuillEditorController to access the editor methods
//   late QuillEditorController controller;

//   ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

//   final customToolBarList = [
//     ToolBarStyle.headerOne,
//     ToolBarStyle.headerTwo,
//     ToolBarStyle.bold,
//     ToolBarStyle.italic,
//     ToolBarStyle.underline,
//     ToolBarStyle.strike,
//     ToolBarStyle.align,
//     ToolBarStyle.listBullet,
//     ToolBarStyle.listOrdered,
//     ToolBarStyle.undo,
//     ToolBarStyle.redo,
//     // ToolBarStyle.clean,
//   ];

//   final _toolbarColor = Colors.grey.shade200;
//   final _backgroundColor = Colors.white70;
//   final _toolbarIconColor = Colors.black87;
//   final _editorTextStyle = const TextStyle(
//       fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal);
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
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 1,
//           color: Colors.orange,
//         ),
//       ),
//       height: deviceSize.height,
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 border: Border.all(
//               width: 1,
//               color: Colors.red,
//             )),
//             width: deviceSize.width * .90,
//             child: ToolBar.scroll(
//               toolBarConfig: customToolBarList,
//               toolBarColor: _toolbarColor,
//               padding: const EdgeInsets.all(8),
//               iconSize: 25,
//               iconColor: _toolbarIconColor,
//               activeIconColor: Colors.greenAccent.shade400,
//               controller: controller,
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               direction: Axis.horizontal,
//               customButtons: [
//                 InkWell(
//                     onTap: () => unFocusEditor(),
//                     child: const Icon(
//                       Icons.favorite,
//                       color: Colors.black,
//                     )),
//                 InkWell(
//                     onTap: () async {
//                       var selectedText = await controller.getSelectedText();
//                       debugPrint('selectedText ');
//                       var selectedHtmlText =
//                           await controller.getSelectedHtmlText();
//                       debugPrint('selectedHtmlText ');
//                     },
//                     child: const Icon(
//                       Icons.add_circle,
//                       color: Colors.black,
//                     )),
//               ],
//             ),
//           ),
//           Flexible(
//             fit: FlexFit.tight,
//             child: QuillHtmlEditor(
//               text: "<p>This text must be valid</p>",
//               hintText: 'Hint text goes here',
//               controller: controller,
//               isEnabled: true,
//               minHeight: deviceSize.height,

//               textStyle: _editorTextStyle,
//               hintTextStyle: _hintTextStyle,
//               hintTextAlign: TextAlign.start,
//               padding: const EdgeInsets.only(left: 8, top: 8),
//               // hintTextPadding: const EdgeInsets.only(left: 20),
//               backgroundColor: _backgroundColor,
//               onFocusChanged: (hasFocus) => debugPrint('has focus $hasFocus'),
//               onTextChanged: (text) => debugPrint('widget text change '),
//               onEditorCreated: () {
//                 debugPrint('Editor has been loaded');
//                 setHtmlText(
//                     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.');
//               },
//               onEditorResized: (height) => debugPrint('Editor resized '),
//               onSelectionChanged: (sel) =>
//                   debugPrint('index ${sel.index}, range ${sel.length}'),
//             ),
//           ),
//         ],
//       ),
//     );
//     // bottomNavigationBar: Visibility(
//     //   visible: true,
//     //   child: Container(
//     //     width: double.maxFinite,
//     //     color: _toolbarColor,
//     //     child: Wrap(
//     //       children: [
//     //         textButton(
//     //             text: 'Set Text',
//     //             onPressed: () {
//     //               setHtmlText('This text is set by you 🫵');
//     //             }),
//     //         textButton(
//     //             text: 'Get Text',
//     //             onPressed: () {
//     //               getHtmlText();
//     //             }),
//     //         textButton(
//     //             text: 'Insert Video',
//     //             onPressed: () {
//     //               ////insert
//     //               insertVideoURL(
//     //                   'https://www.youtube.com/watch?v=4AoFA19gbLo');
//     //               insertVideoURL('https://vimeo.com/440421754');
//     //               insertVideoURL(
//     //                   'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4');
//     //             }),
//     //         textButton(
//     //             text: 'Insert Image',
//     //             onPressed: () {
//     //               insertNetworkImage('https://i.imgur.com/0DVAOec.gif');
//     //             }),
//     //         textButton(
//     //             text: 'Insert Index',
//     //             onPressed: () {
//     //               insertHtmlText(
//     //                   "This text is set by the insertText method",
//     //                   index: 10);
//     //             }),
//     //         textButton(
//     //             text: 'Undo',
//     //             onPressed: () {
//     //               controller.undo();
//     //             }),
//     //         textButton(
//     //             text: 'Redo',
//     //             onPressed: () {
//     //               controller.redo();
//     //             }),
//     //         textButton(
//     //             text: 'Clear History',
//     //             onPressed: () async {
//     //               controller.clearHistory();
//     //             }),
//     //         textButton(
//     //             text: 'Clear Editor',
//     //             onPressed: () {
//     //               controller.clear();
//     //             }),
//     //         textButton(
//     //             text: 'Get Delta',
//     //             onPressed: () async {
//     //               var delta = await controller.getDelta();
//     //               debugPrint('delta');
//     //               debugPrint(jsonEncode(delta));
//     //             }),
//     //         textButton(
//     //             text: 'Set Delta',
//     //             onPressed: () {
//     //               final Map<dynamic, dynamic> deltaMap = {
//     //                 "ops": [
//     //                   {
//     //                     "insert": {
//     //                       "video":
//     //                           "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
//     //                     }
//     //                   },
//     //                   {
//     //                     "insert": {
//     //                       "video":
//     //                           "https://player.vimeo.com/video/440421754"
//     //                     }
//     //                   },
//     //                   {
//     //                     "insert": {
//     //                       "video":
//     //                           "https://www.youtube.com/embed/4AoFA19gbLo"
//     //                     }
//     //                   },
//     //                   {"insert": "Hello"},
//     //                   {
//     //                     "attributes": {"header": 1},
//     //                     "insert": "\n"
//     //                   },
//     //                   {"insert": "You just set the Delta text 😊\n"}
//     //                 ]
//     //               };
//     //               controller.setDelta(deltaMap);
//     //             }),
//     //       ],
//     //     ),
//     //   ),
//     // ),
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
//             style: TextStyle(color: _toolbarColor),
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

class QuillHtml extends StatefulWidget {
  const QuillHtml({super.key});

  @override
  State<QuillHtml> createState() => _QuillHtmlState();
}

class _QuillHtmlState extends State<QuillHtml> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("centeer")),
    );
  }
}
