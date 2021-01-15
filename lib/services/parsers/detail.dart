import 'package:html/dom.dart';

import 'package:v2flex/models/models.dart';

TopicDetail parseDetail(
  Document document, {
  int id,
}) {
  TopicDetail detail = TopicDetail(
    id: id,
  );

  // String title;
  // int created;
  // String content;
  // String contentRendered;
  // int lastModified;
  // int replies;

  try {
    detail.title = document.querySelector('h1').text;
    String publishTimeString = document
        .querySelector('meta[property="article:published_time"]')
        .attributes['content'];
    detail.publishTime = DateTime.parse(publishTimeString);
    detail.contentRendered = document.querySelector('.topic_content').outerHtml;
  } catch (e) {}

  return detail;
}
