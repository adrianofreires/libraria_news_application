import 'package:flutter/material.dart';

class ArticleLoading extends StatelessWidget {
  const ArticleLoading();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
