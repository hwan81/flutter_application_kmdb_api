import 'package:flutter/material.dart';
import 'package:flutter_application_kmdb_api/movie_api.dart';
import 'package:flutter_application_kmdb_api/movie_datail_page.dart';
import 'movie_item_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MovieApi movieApi = MovieApi();
  TextEditingController textEditingController = TextEditingController();
  String keyword = '극한직업';
  late FutureBuilder result;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchResult('');
  }

  void showSearch() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        height: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '닫기',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('검색어를 입력하세요(감독, 영화제목, 배우 등)'),
            TextFormField(
              controller: textEditingController,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        keyword = textEditingController.text;
                        searchResult(keyword);
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('search'),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder searchResult(String keyword) {
    Future<List<Map<dynamic, dynamic>>> movies =
        movieApi.movieSearch(keyword: keyword);
    result = FutureBuilder(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  var item = snapshot.data![index];
                  // return Text(item['title']);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailPage(
                              movieItem: item,
                            ),
                          ));
                    },
                    child: MovieItemForm(
                      actors: item['actors'],
                      genre: item['genre'],
                      kmdbUrl: item['kmdbUrl'],
                      rating: item['rating'],
                      runtime: item['runtime'],
                      plots: item['plots'],
                      staffs: item['staffs'],
                      title: item['title'],
                      posters: item['posters'],
                      DOCID: item['DOCID'],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: snapshot.data!.length);
          } else {
            return const CircularProgressIndicator();
          }
        });
    setState(() {
      result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: const [
            Text('data'),
            Text('data'),
            Text('data'),
            Divider(),
            Text('data'),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Center(child: Text('Korea Moive Data')),
      ),
      bottomSheet: Container(
          decoration: const BoxDecoration(color: Colors.blueGrey),
          height: 30,
          child: const Center(
              child: Text(
            '이 앱은 KMDB 영화 데이터베이스를 사용하였습니다.',
            style: TextStyle(color: Colors.white),
          ))),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Flexible(flex: 1, child: result),
          const SizedBox(
            height: 40,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: showSearch,
          focusColor: Colors.indigoAccent,
          child: const Icon(Icons.search)),
    );
  }
}
