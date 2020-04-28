import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

import 'package:v2flex/models/Models.dart';
import 'package:v2flex/utils/http_client.dart';

import './model.dart';

Future<List<ItemSummary>> fetchItems(http.Client client) async {
  final response = await client.get('http://www.mocky.io/v2/5ea311804f00006829d9f75e');
  return compute(parseItems, response.body);
}

List<ItemSummary> parseItems(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ItemSummary>((json) => ItemSummary.fromJSON(json)).toList();
}

class V2Tab {
  final String name;
  final String id;

  V2Tab({
    this.name,
    this.id,
  });
}

List<V2Tab> fetchTabs() {
  return [
    V2Tab(name: '技术', id: 'tech'),
    V2Tab(name: '创意', id: 'creative'),
    V2Tab(name: '好玩', id: 'play'),
    // V2Tab(name: 'Apple', id: 'apple'),
    // V2Tab(name: '酷工作', id: 'jobs'),
    // V2Tab(name: '交易', id: 'deals'),
    // V2Tab(name: '城市', id: 'city'),
    // V2Tab(name: '问与答', id: 'qna'),
    // V2Tab(name: '最热', id: 'hot'),
    // V2Tab(name: '全部', id: 'all'),
  ];
}

Future<List<Topic>> fetchTab(V2Tab tab) async {
  final response = await dio.get('/', queryParameters: {
    'tab': tab.id,
  });
  Document document = parse(response.data);
  List<Element> posts = document.body.querySelectorAll('.box .cell.item');
  List<Topic> items = posts.map((ele) {
    // <span class="item_title">
    //   <a href="/t/666257#reply77" class="topic-link">
    //     踩坑记： go 服务内存暴涨
    //   </a>
    // </span>
    Element titleEl = ele.querySelector('.item_title a');

    String topicLink = titleEl.attributes['href'];

    // 从 url 中解析 topicId
    RegExpMatch idMath = RegExp(r"/t/(\d+)#").firstMatch(topicLink);
    String topicId = idMath.group(1);

    // 解析投票
    int vote = 0;
    Element voteEl = ele.querySelector('.votes');
    if (
      voteEl != null
      && voteEl.innerHtml != null
      && voteEl.innerHtml.length > 0
    ) {
      RegExpMatch voteMatch = RegExp(r"&nbsp;(\d+) &nbsp;&nbsp;").firstMatch(ele.innerHtml);

      String voteString = voteMatch.group(1);
      if (voteString != null && int.tryParse(voteString) > 0) {
        vote = int.tryParse(voteString);
      }
    }

    // 解析节点
    Element v2NodeEl = ele.querySelector('.node');
    String nodeName = v2NodeEl.text;
    RegExpMatch nodeIdMatch = RegExp(r"/go/(\w+)").firstMatch(v2NodeEl.attributes['href']);
    String nodeId = nodeIdMatch.group(1);

    // 解析用户
    Element avatarEl = ele.querySelector('.avatar');
    String avatarUrl = avatarEl.attributes['src'];
    String userName = avatarEl.attributes['alt'];

    // 解析最后回复
    //  &nbsp;•&nbsp; 1 小时 49 分钟前 &nbsp;•&nbsp; 最后回复来自 
    String lastTouchString = '';
    Element topicInfoEl = ele;
    if (topicInfoEl != null) {
      RegExpMatch lastTouchTimeMatch = RegExp(r"([^&|^>]+) &nbsp;•&nbsp; 最后回复来自 ", multiLine: true).firstMatch(topicInfoEl.innerHtml);
      if (lastTouchTimeMatch != null) {
        lastTouchString = lastTouchTimeMatch.group(1);
      }
    }

    String lastTouchMemberName = '';
    List<Element> allStrongs = topicInfoEl.querySelectorAll('strong');
    if (allStrongs.length > 1) {
      Element lastTouchMemberEl = allStrongs[1];
      if (lastTouchMemberEl != null) {
        lastTouchMemberName = lastTouchMemberEl.querySelector('a').text;
      }
    }

    // 解析回复数
    int replyCount = 0;
    Element countEl = ele.querySelector('.count_livid');
    if (countEl != null && int.tryParse(countEl.text) != null) {
      replyCount = int.tryParse(countEl.text);
    }
    return Topic(
      id: topicId,
      title: titleEl.text,
      author: SimpleMember(userName, avatar: avatarUrl),
      vote: vote,
      node: V2Node(id: nodeId, name: nodeName),
      lastTouchString: lastTouchString,
      lastTouchMember: lastTouchMemberName.length > 0 ? SimpleMember(lastTouchMemberName) : null,
      replyCount: replyCount,
      link: topicLink,
    );
  }).toList();

  return items;
}
