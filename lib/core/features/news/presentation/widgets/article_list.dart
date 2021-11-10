import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:libraria_news_application/core/features/news/data/helpers/ad_helper.dart';
import 'package:libraria_news_application/core/features/news/domain/entities/article.dart';
import 'package:libraria_news_application/core/features/news/presentation/pages/single_article_page.dart';

class ArticleList extends StatefulWidget {
  final List<Article> articles;
  final ScrollController controller;

  const ArticleList({Key? key, required this.articles, required this.controller}) : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  static final _kBannerAdIndex = 0;
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kBannerAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerdUnitID,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ListView.builder(
        itemCount: widget.articles.length + (_isAdLoaded ? 1 : 0),
        controller: widget.controller,
        itemBuilder: (context, index) {
          if (_isAdLoaded && index == _kBannerAdIndex) {
            return Container(
              child: AdWidget(ad: _bannerAd),
              width: _bannerAd.size.width.toDouble(),
              height: 72.0,
              alignment: Alignment.center,
            );
          } else {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 8.0),
              color: Color(0xFF1e1e22),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return SingleArticlePage(
                          url: widget.articles[_getDestinationItemIndex(index)].linkUrl,
                          category: widget.articles[_getDestinationItemIndex(index)].categories.first,
                        );
                      });
                },
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(widget.articles[_getDestinationItemIndex(index)].image)),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.articles[_getDestinationItemIndex(index)].categories.first,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: ThemeData.dark().errorColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            widget.articles[_getDestinationItemIndex(index)]
                                .dateFormatted(widget.articles[index].date)!,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.articles[_getDestinationItemIndex(index)].title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
