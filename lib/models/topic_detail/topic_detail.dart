class TopicDetail {
  String lastReplyBy;
  int lastTouched;
  String url;
  String content;
  int lastModified;
  int replies;

  int created;

  String title;
  String contentRendered;
  int id;

  DateTime publishTime;

  TopicDetail({
    this.lastReplyBy,
    this.lastTouched,
    this.title,
    this.url,
    this.created,
    this.content,
    this.contentRendered,
    this.lastModified,
    this.replies,
    this.id,
  });

  TopicDetail.fromJson(Map<String, dynamic> json) {
    lastReplyBy = json['last_reply_by'];
    lastTouched = json['last_touched'];
    title = json['title'];
    url = json['url'];
    created = json['created'];
    content = json['content'];
    contentRendered = json['content_rendered'];
    lastModified = json['last_modified'];
    replies = json['replies'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_reply_by'] = this.lastReplyBy;
    data['last_touched'] = this.lastTouched;
    data['title'] = this.title;
    data['url'] = this.url;
    data['created'] = this.created;
    data['content'] = this.content;
    data['content_rendered'] = this.contentRendered;
    data['last_modified'] = this.lastModified;
    data['replies'] = this.replies;
    data['id'] = this.id;
    return data;
  }
}
