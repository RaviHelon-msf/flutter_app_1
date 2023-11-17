import 'package:flutter/material.dart';

import 'my_cont_page.dart';
import 'my_search.dart';
import 'main.dart';
import 'my_fav_page.dart';

const String myAppTitle = "Mestre Tung";

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SizedBox(
        width: 200,
        child: Column(
          children: <Widget>[
            SizedBox(
              height:
                  MediaQuery.of(context).size.height, // Set a height constraint
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        myAppTitle,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 1.0,
                      ))),
                      padding: EdgeInsets.only(bottom: 12.0),
                      margin: EdgeInsets.all(0),
                      child: Text(
                        'Início',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 1.0,
                      ))),
                      padding: EdgeInsets.only(bottom: 12.0),
                      margin: EdgeInsets.all(0),
                      child: Text(
                        'Pesquisa',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MySearchPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 1.0,
                      ))),
                      padding: EdgeInsets.only(bottom: 12.0),
                      margin: EdgeInsets.all(0),
                      child: Text(
                        'Favoritos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyFavPage()),
                      );
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.55),
                  ListTile(
                    title: Text(
                      'Sobre',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 26,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyContPage()),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
