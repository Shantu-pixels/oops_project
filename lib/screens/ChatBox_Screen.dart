import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:oops_project/components/Message_cart.dart';
import 'package:oops_project/controller/Chat_Controller.dart';

class ChatboxScreen extends StatefulWidget {
  const ChatboxScreen({super.key});

  @override
  State<ChatboxScreen> createState() => _ChatboxScreenState();
}

class _ChatboxScreenState extends State<ChatboxScreen> {
  final Chat_controller _c = Get.put(Chat_controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.blue.withOpacity(0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(Icons.arrow_back, color: Colors.blue.withOpacity(0.7)),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'AI ChatBox',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            // Chat Messages List
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Obx(
                  () => ListView(
                    controller: _c.scrollc,
                    padding: EdgeInsets.all(20),
                    children: _c.List.map((e) => MessageCard(mess: e)).toList(),
                  ),
                ),
              ),
            ),

            // Input Field and Send Button
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border(
                  top: BorderSide(
                    color: Colors.blue.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.5),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        controller: _c.textc,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onTapOutside: (e) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          hintText: 'Ask me anything...',
                          hintStyle: TextStyle(
                            color: Colors.blue.withOpacity(0.5),
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          border: InputBorder.none,
                          suffixIcon: Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.rocket_launch_outlined,
                                color: Colors.blue,
                                size: 24,
                              ),
                              onPressed: () {
                                _c.Ask_Question();
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
