import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LanguePage(),
    );
  }
}

class LanguePage extends StatefulWidget {
  @override
  _LanguePageState createState() => _LanguePageState();
}

class _LanguePageState extends State<LanguePage> {
  double _currentValueEnglish = 50;
  double _currentValueFrench = 30;
  DateTime? date;
  var currentOption = 0; // Pour la première option
  var options = [0, 1]; // Les valeurs pour les boutons radio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Langue'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 120),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ENTREZ VOTRE POURCENTAGE SUR LA LANGUE ANGLAISE ?  ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      value: _currentValueEnglish,
                      min: 0,
                      max: 100,
                      divisions: 20, // Nombre de divisions du curseur
                      label: _currentValueEnglish.round().toString() + '%',
                      onChanged: (double value) {
                        setState(() {
                          _currentValueEnglish = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Pourcentage sélectionné : ${_currentValueEnglish.round()}%',
                      style: TextStyle(fontSize: 16),
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     labelText: 'Entrez vos differentes langues ',
                    //     labelStyle: TextStyle(fontSize: 12),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 150),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ENTREZ VOTRE POURCENTAGE SUR LA LANGUE FRANCAIS ? ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      value: _currentValueFrench,
                      min: 0,
                      max: 100,
                      divisions: 20, // Nombre de divisions du curseur
                      label: _currentValueFrench.round().toString() + '%',
                      onChanged: (double value) {
                        setState(() {
                          _currentValueFrench = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Pourcentage sélectionné : ${_currentValueFrench.round()}%',
                      style: TextStyle(fontSize: 16),
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     labelText: 'Entrez vos differentes langues ',
                    //     labelStyle: TextStyle(fontSize: 12),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 150),
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();

                          // Action à effectuer lors du clic sur le bouton "Suivant"
                        },
                        child: Text('Retour',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Action à effectuer lors du clic sur le bouton "Retour"
                        },
                        child: Text('Suivant',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
