import 'package:flutter/material.dart';
import 'package:listview_data/model/movie.dart';
import 'package:listview_data/ui/movie_ui/movie_ui.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> movieList = Movie.getMovies();
  final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I Am Legend",
    "300",
    "The Wolf of the Wall Street",
    "Interstllar",
    "Game of Thrones",
    "Vikings"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        //centerTitle: true,
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Positioned(child: movieCard(movieList[index], context)),
                Positioned(
                    top: 10, child: movieImage(movieList[index].images[0])),
              ],
            );
            // return Card(
            //   elevation: 4.5,
            //   color: Colors.white,
            //   child: ListTile(
            //     leading: CircleAvatar(
            //       child: Container(
            //         width: 200,
            //         height: 200,
            //         decoration: BoxDecoration(
            //           image: DecorationImage(
            //             image: NetworkImage(movieList[index].images[0]),
            //             fit: BoxFit.cover,
            //           ),
            //           //color: Colors.blue,
            //           borderRadius: BorderRadius.circular(13.9),
            //         ),
            //         child: null,
            //       ),
            //     ),
            //     trailing: Text("..."),
            //     title: Text(movieList[index].title),
            //     subtitle: Text("${movieList[0].title}"),
            //     // onTap: () =>
            //     //     debugPrint("Movie name : ${movies.elementAt(index)}"),
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => MovieListViewDetails(
            //                     //movieName: movieList[index].title, /also works fime
            //                     movieName: movieList.elementAt(index).title,
            //                     movie: movieList[index],
            //                   )));
            //     },
            //   ),
            // );
          }),
    );
  }
}

Widget movieCard(Movie movie, BuildContext context) {
  return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 54),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Text(
                          movie.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "Ratting : ${movie.imdbrating} /10",
                        style: mainTextStyle(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Released: ${movie.released}",
                          style: mainTextStyle()),
                      Text(
                        movie.runtime,
                        style: mainTextStyle(),
                      ),
                      Text(
                        movie.rated,
                        style: mainTextStyle(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieListViewDetails(
                          //movieName: movieList[index].title, /also works fime
                          movieName: movie.title,
                          movie: movie,
                        )))
          });
}

TextStyle mainTextStyle() {
  return TextStyle(
    fontSize: 15,
    color: Colors.grey,
  );
}

Widget movieImage(String imageUrl) {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        )),
  );
}

class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieListViewDetails({Key key, this.movieName, this.movie})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Movies $movieName"), also worksss fine
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          MovieDetailsThumbnail(
            thumbnail: movie.images[0],
          ),
          MovieDetailsHeaderWithPoster(
            movie: movie,
          ),
          HorizontalLine(),
          MovieDetailsCast(
            movie: movie,
          ),
          HorizontalLine(),
          MovieDetailsExtraPosters(
            posters: movie.images,
          )
        ],
      ),
      // body: Container(
      //   child: Center(
      //     child: RaisedButton(
      //       child: Text("${this.movie.director}"),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // )
    );
  }
}
