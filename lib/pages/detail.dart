import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import 'package:v2flex/models/models.dart';
import 'package:v2flex/services/services.dart';

class PageDetail extends StatefulWidget {
  final Topic topic;

  PageDetail({
    this.topic,
  });

  @override
  _PageDetailState createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  TopicDetail topicDetail;

  @override
  void initState() {
    super.initState();

    initData();
  }

  Future<void> initData() async {
    TopicDetail res = await fetchTopicDetail(widget.topic.id);
    setState(() {
      topicDetail = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Text(
                  widget.topic.title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildInfo(),
              _buildMainContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 68,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.topic.author.avatar,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.topic.author.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${widget.topic.node.name}',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    if (topicDetail == null) return Container();

    double fontSize = 20;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Html(
        data: topicDetail.contentRendered ?? '',
        style: {
          'p': Style(
            fontSize: FontSize(fontSize),
            lineHeight: 1.4,
          ),
        },
      ),
    );
  }
}
