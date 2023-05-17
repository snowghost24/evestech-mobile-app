// import 'package:litlink/theme/app_theme.dart';
// import 'package:flutx/flutx.dart';
import 'dart:math';

import 'package:evestech/services/custom_theme.dart';

import '../models/chat.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';

enum SampleItem { notify, edit, archive, delete }

class MessageSingleChatScreen extends StatefulWidget {
  final Chat chat;

  const MessageSingleChatScreen(this.chat, {super.key});

  @override
  State<MessageSingleChatScreen> createState() =>
      _MessageSingleChatScreenState();
}

class _MessageSingleChatScreenState extends State<MessageSingleChatScreen> {
  late Chat chat;
  late ThemeData theme;
  SampleItem? selectedMenu;

  @override
  void initState() {
    super.initState();
    chat = widget.chat;
    theme = CustomTheme.lightTheme;
  }

  Widget _buildReceiveMessage({String? message, String? time}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(right: 140.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message!,
                    style: TextStyle(color: theme.colorScheme.onPrimary),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(time!),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendMessage({String? message, String? time}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              // color: customTheme.medicarePrimary,
              margin: const EdgeInsets.only(left: 140.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message!,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(time!),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'What happenens if i need to pull money',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            PopupMenuButton<SampleItem>(
              initialValue: selectedMenu,
              // Callback that sets the selected popup menu item.
              onSelected: (SampleItem item) {
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
                PopupMenuItem<SampleItem>(
                  value: SampleItem.notify,
                  child: Row(children: const [
                    Icon(
                      size: 18,
                      Icons.notifications,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Notify'),
                  ]),
                ),
                PopupMenuItem<SampleItem>(
                  value: SampleItem.edit,
                  child: Row(children: const [
                    Icon(
                      size: 18,
                      Icons.edit_document,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Edit Recipients'),
                  ]),
                ),
                PopupMenuItem<SampleItem>(
                  value: SampleItem.archive,
                  child: Row(children: const [
                    Icon(
                      size: 18,
                      Icons.archive,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Archive'),
                  ]),
                ),
                PopupMenuItem<SampleItem>(
                  value: SampleItem.delete,
                  child: Row(children: const [
                    Icon(
                      size: 18,
                      Icons.delete,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Delete'),
                  ]),
                ),
              ],
            ),
          ]),
      backgroundColor: theme.colorScheme.onPrimary,
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          children: [
            // Container(
            //   // color: Theme.of(context).colorScheme.secondary,
            //   child: Row(
            //     children: [
            //     ,
            //       const SizedBox(width: 8),

            //       // Container(
            //       //   padding: const EdgeInsets.all(0),
            //       //   child: Image(
            //       //     width: 40,
            //       //     height: 40,
            //       //     image: AssetImage(chat.image),
            //       //   ),
            //       // ),
            //       const SizedBox(width: 12),
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(chat.name,
            //                 style: const TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                 )),
            //             const SizedBox(height: 2),
            //             Row(
            //               children: [
            //                 Container(
            //                   padding: const EdgeInsets.all(3),
            //                   child: Container(),
            //                 ),
            //                 const SizedBox(width: 4),
            //                 const Text(
            //                   'Online',
            //                   // style: TextStyle(fontWeight: FontWeight.normal),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //       const SizedBox(width: 16),
            //       Container(
            //           // color: customTheme.medicarePrimary,
            //           padding: const EdgeInsets.all(8),
            //           child: const Icon(
            //             Icons.videocam_rounded,
            //             // color: customTheme.medicareOnPrimary,
            //             size: 16,
            //           )),
            //       const SizedBox(width: 8),
            //       Container(
            //         // color: customTheme.medicarePrimary,
            //         padding: const EdgeInsets.all(8),
            //         child: const Icon(
            //           Icons.call,
            //           // color: customTheme.medicareOnPrimary,
            //           size: 16,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(width: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              // color: customTheme.medicarePrimary.withAlpha(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.watch_later,
                    // color: customTheme.medicarePrimary,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Sun, Jan 19, 08:00am - 10:00am',
                    // color: customTheme.medicarePrimary,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildReceiveMessage(
                      message: 'Yes, What help do you need?', time: '08:25'),
                  const SizedBox(height: 16),
                  _buildSendMessage(
                      message: 'Should I come to hospital tomorrow?',
                      time: '08:30'),
                  const SizedBox(height: 16),
                  _buildReceiveMessage(
                      message: 'Yes sure, you can come after 2:00 pm',
                      time: '08:35'),
                  const SizedBox(height: 16),
                  _buildSendMessage(
                      message: 'Sure, Thank you!!', time: '08:40'),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
