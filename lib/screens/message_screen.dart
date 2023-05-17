// import 'single_chat_screen.dart';

import 'package:evestech/screens/single_chat_screen.dart';
import 'package:flutter/material.dart';

import '../models/chat.dart';
import 'discussion_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Chat> chatList = [];

  List<Widget> _buildChatList() {
    List<Widget> list = [];

    list.add(const SizedBox(width: 8));

    for (int i = 0; i < chatList.length; i++) {
      list.add(_buildSingleChat(chatList[i]));
    }
    return list;
  }

  void createNewDiscussion(BuildContext ctx) {
    Navigator.pushNamed(context, DiscussionScreen.routeName);
    // showModalBottomSheet(
    //     // useSafeArea: true,
    //     constraints: BoxConstraints(
    //         maxHeight: MediaQuery.of(context).size.height * 0.90),
    //     shape: const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
    //     backgroundColor: Colors.white,
    //     context: context,
    //     isScrollControlled: true,
    //     builder: (context) => Padding(
    //           padding: EdgeInsets.only(
    //               bottom: MediaQuery.of(context).viewInsets.bottom),
    //           child: DiscussionScreen(addTx: () {}),
    //         ));
  }

  @override
  void initState() {
    super.initState();
    chatList = Chat.chatList();
  }

  Widget _buildSingleChat(Chat chat) {
    return Container(
      // onTap: () {
      //   Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      //       builder: (context) => MediCareSingleChatScreen(chat)));
      // },
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      // borderRadiusAll: 16,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => MessageSingleChatScreen(chat)));
        },
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(chat.image),
                ),
                // Container(
                //   padding: const EdgeInsets.all(0),
                //   child: Image(
                //     height: 54,
                //     width: 54,
                //     image: AssetImage(chat.image),
                //   ),
                // ),
                Positioned(
                  right: 4,
                  bottom: 2,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Container(),
                  ),
                )
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chat.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(chat.chat,
                      style: const TextStyle(fontWeight: FontWeight.normal)),
                  // FxText.bodySmall(
                  //   chat.chat,
                  //   xMuted: chat.replied,
                  //   muted: !chat.replied,
                  //   fontWeight: chat.replied ? 400 : 600,
                  // ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(chat.time,
                    style: const TextStyle(fontWeight: FontWeight.normal)),
                chat.replied
                    ? const SizedBox(height: 16)
                    : Container(
                        alignment: Alignment.center,
                        width: 20.0,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: Text(chat.messages,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal)),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussions',
            style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              createNewDiscussion(context);
              print('I\'m creating a discussion');
            },
          ),
          const SizedBox(width: 16)
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Search messages",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide.none),
                  // fillColor: customTheme.card,
                  filled: true,
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                ),
                textInputAction: TextInputAction.search,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: _buildChatList(),
            ),
          ],
        ),
      ),
    );
  }
}
