/*
 * Created by chenguang491 on 2019/8/21
 * Copyright (c) 2019. PING AN HEALTH CLOUD COMPANY LIMITED.
 * ALL rights reserved.
 */
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  Post({this.id, this.title, this.body}) : super([id, title, body]);

  @override
  String toString() => 'Post{id:$id}';
}
