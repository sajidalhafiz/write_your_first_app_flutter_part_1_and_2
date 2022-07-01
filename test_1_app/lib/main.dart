import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);// why this line?

  @override
  Widget build(BuildContext context){

    //final wordPair = WordPair.random();
    return MaterialApp(          // Remove the const from here
      debugShowCheckedModeBanner: false,
      title: 'Startup Name Generator',
      theme: ThemeData(          // Add the 5 lines from here...
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
        ),
      ),                         // ... to here.
      home: const RandomWords(), // And add the const back here.
    );
  }
}


class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _biggerFont = const TextStyle(fontSize: 18);
  final _suggestions = <WordPair>[];
  final _saved = <WordPair> {};

  void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );
  }

  @override
  Widget build(BuildContext context) {

    //final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadySaved = _saved.contains(_suggestions[index]);

          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(    // NEW from here ...
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {          // NEW from here ...
              setState(() {
                if (alreadySaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });                // to here.
            },
          );
        },
      ),
    );
  }
}






