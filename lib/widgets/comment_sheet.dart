import 'package:flutter/material.dart';
import 'package:flutter_1/photocard.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet({
    super.key,
    required this.dragController
  });

final DraggableScrollableController dragController;

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  late final ScrollController _controller;
  final minExtent = 0.2;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: .9,
        snapSizes: [.6, .9],
        snap: true,
        minChildSize:0,
        shouldCloseOnMinExtent: true,
        controller: widget.dragController,
        builder: (BuildContext context, ScrollController _controller) {
          return 
          Container(
            color: Colors.grey,
            transformAlignment: Alignment.bottomCenter,
            child: CustomScrollView(
              controller: _controller,
              slivers: [
                const CommentsHeader(),
                SliverList.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(child:const Text('data'));
                  },
                  itemCount: 2,
                )
              ],
            ),
          );
        });
  }
}

class CommentsHeader extends StatelessWidget {
  const CommentsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
            color: const Color.fromARGB(255, 63, 63, 63),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Comments',
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            )));
  }
}
