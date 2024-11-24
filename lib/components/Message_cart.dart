import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../models/Message.dart';

class MessageCard extends StatelessWidget {
  final Message mess;

  const MessageCard({super.key, required this.mess});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    const r = Radius.circular(15);

    return mess.msgType == MessageType.bot
        // Bot Message with Pink Theme
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 6),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink.shade100.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: Colors.pink.shade200.withOpacity(0.3)),
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/applogo.png', width: 24),
                ),
              ),
              Flexible(
                child: Container(
                  constraints: BoxConstraints(maxWidth: mq.width * .6),
                  margin: EdgeInsets.only(
                    bottom: mq.height * .02,
                    left: mq.width * .02,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: mq.height * .01,
                    horizontal: mq.width * .03,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.pink.shade100.withOpacity(0.2),
                        Colors.pink.shade200.withOpacity(0.15),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                        color: Colors.pink.shade200.withOpacity(0.3)),
                    borderRadius: const BorderRadius.only(
                      topRight: r,
                      bottomLeft: r,
                      bottomRight: r,
                    ),
                  ),
                  child: mess.msg.isEmpty
                      ? DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.pink.shade100,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText(
                                'Typing...',
                                speed: Duration(milliseconds: 200),
                              ),
                            ],
                            repeatForever: true,
                          ),
                        )
                      : Text(
                          mess.msg,
                          style: TextStyle(
                            color: Colors.pink.shade50,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                ),
              ),
            ],
          )
        // User Message (keeping blue theme)
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(maxWidth: mq.width * .6),
                  margin: EdgeInsets.only(
                    bottom: mq.height * .02,
                    right: mq.width * .02,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: mq.height * .01,
                    horizontal: mq.width * .03,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                    borderRadius: const BorderRadius.only(
                      topLeft: r,
                      topRight: r,
                      bottomLeft: r,
                    ),
                  ),
                  child: Text(
                    mess.msg,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                ),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.person, color: Colors.blue, size: 24),
                ),
              ),
              const SizedBox(width: 6),
            ],
          );
  }
}
