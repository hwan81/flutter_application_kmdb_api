import 'package:flutter/material.dart';
import 'package:read_more_text/read_more_text.dart';

class MovieDetailPage extends StatelessWidget {
  final dynamic movieItem;
  const MovieDetailPage({super.key, required this.movieItem});

  @override
  Widget build(BuildContext context) {
    String movieTitle = movieItem['title']
        .toString()
        .replaceAll('!HS ', '')
        .replaceAll('!HE ', '')
        .trim();

    Image movieImage = Image.asset('images/no-image.jpg');
    if (movieItem['posters'].toString().isNotEmpty) {
      movieImage = Image.network(movieItem['posters'].split('|').last);
    }

    List<dynamic> actorList = [];
    for (var k in movieItem['actors']['actor']) {
      actorList.add(k['actorNm']);
    }

    List<dynamic> staffList = [];
    for (var k in movieItem['staffs']['staff']) {
      if (k['staffRoleGroup'].toString().contains('감독')) {
        staffList.add('${k['staffNm']}(${k['staffRoleGroup']})');
      }
    }

    var plot = movieItem['plots']['plot'][0]['plotText'];

    return Scaffold(
      appBar: AppBar(
        title: Text('상세정보($movieTitle)'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  movieTitle,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: movieItem['DOCID'],
                    child: SizedBox(width: 200, child: movieImage),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🤔 장르',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${movieItem['genre']}'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '📆 개봉일',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${movieItem['repRatDate']}'),
                      const SizedBox(height: 10),
                      const Text(
                        '🤵 배우',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ReadMoreText(
                          actorList
                              .toString()
                              .replaceAll('!HS ', '')
                              .replaceAll('!HE ', '')
                              .trim(),
                          numLines: 1,
                          readMoreText: 'more',
                          readLessText: 'hide'),
                      const Text(
                        '👩‍🌾 Staff',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ReadMoreText(
                          staffList
                              .toString()
                              .replaceAll('!HS ', '')
                              .replaceAll('!HE ', '')
                              .trim(),
                          numLines: 1,
                          readMoreText: 'more',
                          readLessText: 'hide'),
                    ],
                  ))
                ],
              ),
              const Divider(),
              const Text(
                '🎞 줄거리',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReadMoreText(
                  plot.toString().replaceAll('!', '.\n'),
                  numLines: 5,
                  readLessText: '줄이기',
                  readMoreText: '더보기..',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
