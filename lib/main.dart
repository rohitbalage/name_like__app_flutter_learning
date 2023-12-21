import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
   void getNext() {
    current = WordPair.random();
    notifyListeners();
   }

   /*
   The new getNext() method reassigns current with a new random WordPair. It also calls notifyListeners()(a method of
    ChangeNotifier)that ensures that anyone watching MyAppState is notified.
   All that remains is to call the getNext method from the button's callback.
    */
     var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

   
}



class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Every widget defines a build() method that's automatically called every time the widget's 
    //circumstances change so that the widget is always up to date.
    var appState = context.watch<MyAppState>();  //MyHomePage tracks changes to the app's current state using the watch method.
    var pair = appState.current;   
    return Scaffold(  // Every build method must return a widget or (more typically) a nested tree of widgets. In this case, the top-level widget is Scaffold. You aren't going to work with Scaffold in this codelab,
                        //  but it's a helpful widget and is found in the vast majority of real-world Flutter apps.
      body: Center(
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center, 
           // Column is one of the most basic layout widgets in Flutter. It takes any number of children and puts them in a column from top to bottom. By default, 
          //the column visually places its children at the top. You'll soon change this so that the column is centered.
          children: [
          //You changed this Text widget in the first step
            BigCard(pair: pair), // This second Text widget takes appState, and accesses the only member of that class, 
            // current (which is a WordPair). WordPair provides several helpful getters, such as asPascalCase or asSnakeCase. Here, we use asLowerCase but you can change this now if you prefer one of the alternatives.
             SizedBox(height: 10),
            Row(
               mainAxisSize: MainAxisSize.min, 
              
              children: [
                ElevatedButton(
                  onPressed: () {
                
                  },
                  child: Text('Like'),
                ),

           

                ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text('Next'),
                ),
              ],
            ),
            /* Notice how Flutter code makes heavy use of trailing commas. This particular comma doesn't need to be here, because children is the last (and also only) member of this particular Column parameter list. Yet it is generally a good idea to use trailing commas: they make adding more members trivial, and 
            they also serve as a hint for Dart's auto-formatter to put a newline there. For more information, see Code formatting. */
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);     
     final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
        color: theme.colorScheme.primary,  
      child: Padding(
        padding: const EdgeInsets.all(20.0),
         child: Text(pair.asLowerCase, style: style,  semanticsLabel: "${pair.first} ${pair.second}",),
        
      ),
    );
  }
}