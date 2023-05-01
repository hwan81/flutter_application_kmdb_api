import 'package:flutter/material.dart';

class MovieItemForm extends StatelessWidget {
  final dynamic actors,
      genre,
      kmdbUrl,
      rating,
      runtime,
      plots,
      staffs,
      title,
      posters,
      DOCID;

  const MovieItemForm(
      {super.key,
      required this.actors,
      required this.genre,
      required this.kmdbUrl,
      required this.rating,
      required this.runtime,
      required this.plots,
      required this.staffs,
      required this.title,
      required this.posters,
      required this.DOCID});

  @override
  Widget build(BuildContext context) {
    String movieTitle =
        title.toString().replaceAll('!HS ', '').replaceAll('!HE ', '').trim();
    Image movieImage = Image.asset('images/no-image.jpg');
    if (posters.toString().isNotEmpty) {
      movieImage = Image.network(posters.split('|').last);
    }
    List<dynamic> actorList = actors['actor'];
    List<String> actor = [];
    int actorMaxCount = 3;
    int i = 0;
    for (var k in actorList) {
      if (++i > actorMaxCount) break;
      actor.add(
          k['actorNm'].replaceAll('!HS ', '').replaceAll('!HE ', '').trim());
    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: DOCID,
            child: SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: movieImage,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movieTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '$genre | $rating | ($runtime분)',
              style: const TextStyle(color: Colors.black45, fontSize: 12),
            ),
            Text(actor.toString().substring(1, actor.toString().length - 1))
          ],
        ))
      ],
    );
  }
}
