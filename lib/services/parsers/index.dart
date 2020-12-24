import 'package:html/dom.dart';

import 'package:v2flex/models/models.dart';

List<V2Tab> parseTabsFromIndexHTML(Document document) {
  try {
    var tabs = document.querySelectorAll('a.tab');
    var currentTab = document.querySelector('a.tab_current');
    tabs.insert(0, currentTab);

    return tabs.map((element) {
      RegExp tabHrefExp = RegExp(r'\?tab\=(.*)');

      var href = element.attributes['href'];
      var matchRes = tabHrefExp.firstMatch(href);
      String id = matchRes.groupCount >= 1 ? matchRes.group(1) : '';
      return V2Tab(
        id: id ?? '',
        name: element.text,
      );
    }).toList();
  } catch (e) {
    return [];
  }
}

List<Topic> parseTopicFromIndexHTML(Document document) {
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
    if (voteEl != null &&
        voteEl.innerHtml != null &&
        voteEl.innerHtml.length > 0) {
      RegExpMatch voteMatch =
          RegExp(r"&nbsp;(\d+) &nbsp;&nbsp;").firstMatch(ele.innerHtml);

      String voteString = voteMatch.group(1);
      if (voteString != null && int.tryParse(voteString) > 0) {
        vote = int.tryParse(voteString);
      }
    }

    // 解析节点
    Element v2NodeEl = ele.querySelector('.node');
    String nodeName = v2NodeEl.text;
    RegExpMatch nodeIdMatch =
        RegExp(r"/go/(\w+)").firstMatch(v2NodeEl.attributes['href']);
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
      RegExpMatch lastTouchTimeMatch =
          RegExp(r"([^&|^>]+) &nbsp;•&nbsp; 最后回复来自 ", multiLine: true)
              .firstMatch(topicInfoEl.innerHtml);
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
      lastTouchMember: lastTouchMemberName.length > 0
          ? SimpleMember(lastTouchMemberName)
          : null,
      replyCount: replyCount,
      link: topicLink,
    );
  }).toList();

  return items;
}
