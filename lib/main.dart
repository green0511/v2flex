import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

Future<List<ItemSummary>> fetchItems(http.Client client) async {
  final response = await client.get('http://www.mocky.io/v2/5ea06b5a320000934394af09');
  print(response.body.length);
  return compute(parseItems, response.body);
}

List<ItemSummary> parseItems(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ItemSummary>((json) => ItemSummary.fromJSON(json)).toList();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Scaffold(
        appBar: AppBar(
          title: Text(
            'v2flex'.toUpperCase(),
            style: TextStyle(
              letterSpacing: 4,
            ),
          ),
        ),
        body: FutureBuilder<List<ItemSummary>>(
          future: fetchItems(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
              ? ItemsList(items: snapshot.data)
              : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ItemsList extends StatelessWidget {
  final List<ItemSummary> items;

  ItemsList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        ItemSummary item = items[index];

        return Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    item.member.avatarLarge,
                    width:48,
                    height:48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class ItemMember {
  final String avatarLarge;
  final String avatarMini;
  final String avatarNormal;
  final String bio;
  final String btc;
  final int created;
  final int id;
  final String github;
  final String location;
  final String psn;
  final String tagline;
  final String twitter;
  final String url;
  final String username;
  final String website;

  ItemMember.fromJSON(Map<String, dynamic> json):
    avatarLarge = json['avatar_large'],
    avatarMini = json['avatar_mini'],
    avatarNormal = json['avatar_normal'],
    bio = json['bio'],
    btc = json['btc'],
    created = json['created'],
    id = json['id'],
    github = json['github'],
    location = json['location'],
    psn = json['psn'],
    tagline = json['tagline'],
    twitter = json['twitter'],
    url = json['url'],
    username = json['username'],
    website = json['website'];
}

class ItemSummary {
  final String title;
  final int id;
  final String content;
  final String contentRendered;
  final int created;
  final int lastModified;
  final int lastTouched;
  final int replies;
  final String url;
  final ItemMember member;

  ItemSummary.fromJSON(Map<String, dynamic> json):
    title = json['title'],
    id = json['id'],
    content = json['content'],
    contentRendered = json['content_rendered'],
    created = json['created'],
    lastModified = json['last_modified'],
    lastTouched = json['last_touched'],
    replies = json['replies'],
    url = json['url'],
    member = ItemMember.fromJSON(json['member']);
}
