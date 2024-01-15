/*
This is signin page

include file in reuseable/global_function.dart to call function from GlobalFunction

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/bottom_navigation_bar.dart';
//import 'package:ijshopflutter/ui/authentication/signin/signin_email.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin_phone_number_choose_verification.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../signup/signup_phone_number_verification.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  bool _buttonDisabled = true;
  String _validate = '';
  late int phoneNumber;
  late int pin_code;
  // String initialCountry = 'CM';
  //honeNumber number = PhoneNumber(isoCode: 'CM');
  String phone = " ";

  // gestion du controle des champs de text

  //TextEditingController _etEmailPhone = TextEditingController();

  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerPincode = TextEditingController();
  //TextEditingController _controllerName = TextEditingController();
  //TextEditingController _controllerEmail = TextEditingController();

  // creation et utilisation de la classe ApiService

  ApiService apiService = ApiService(); // instance de la classe api service
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  @override
  void initState() {
    // cette fonction est la premiere fonction qui est lance a l'overture d'une page
    super.initState();
    //autoConnect(); // cette est utilise pour verifier si l'utilisateur c'est deja connecte si c'est oui il serais diriger directement vers la page principale qui la page home
  }

  @override
  void dispose() {
    // cette fonction est appelle lors de la fermerture de la page
    //_etEmailPhone.dispose();
    _controllerPhoneNumber.dispose();
    _controllerPincode.dispose();
    //_controllerName.dispose();
    //_controllerEmail.dispose();
    super.dispose();
  }

  void _saveData(int phoneNumber, int pin_code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('phoneNumber', phoneNumber);
    await prefs.setInt('pin_code', pin_code);
  }

  void signin({String? password}) async {
    // la fonction signin prends en paramettre le numero de telephne et le mot de passe
    // ici notre fonction signin prends seulement en parametre le password de type String ou null car La présence du symbole ? après le type String indique que le paramètre peut être null.
    try {
      final data = {
        //creation de l'objet data qui va nous permettre t'envoie les donnees a partir de L'API
        'phoneNumber': phone,
        'password': password,
      };
      print(data);

      // la variable response de l'objet data qui va contenir le resultat de la requette  login depuis  l'API
      final response = await apiService.login(data,
          apiToken); // pour realise cette ligne il faut creer une variable apiToken, pour ce fais dans la page home faire ctrl + f et recherche apiToken et copier cette ligne qui contient apiToken et le coller apres la ligne qui nous permet de creer une instance de notre class et faire les inportation
      print(response);
      print(
          'lklkkmkkmkjnjhhbnlllllllllllllllllllllllpppppppppppppppppppppppppppppoiiiiiiiiiiiii');

      // si le login c'est bien passe car l'utilisateur a bien entre les informations puis l'utiliateur seras rediriger directemment dans le menu principal c'est dire la page Home en cliquan sur le boutton navigation
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarPage()));
    } catch (e) {
      print(e);
      print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
    }
  }

  // void getPhoneNumber(String phoneNumber) async {
  //   PhoneNumber number =
  //       await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'CM');

  //   setState(() {
  //     this.phone = number.phoneNumber ?? "";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
      children: <Widget>[
        //Center(child: Image.asset('assets/images/logo_light.png', height: 50)),
        SizedBox(
          height: 70,
        ),
        Text('Se connecter: ', style: GlobalStyle.authTitle),
        SizedBox(
          height: 0,
        ),

        InternationalPhoneNumberInput(
          onInputValidated: (value) {
            print(value);
            setState(() {
              if (value) {
                _buttonDisabled = false;
                _validate = 'phone_number';
              } else {
                _buttonDisabled = true;
              }
            });
          },
          onInputChanged: (PhoneNumber number) {
            print(number.phoneNumber);
            setState(() {
              phone = number.phoneNumber ?? "";
            });
          },
          selectorConfig: SelectorConfig(
            //Cette ligne de code permet de configurer le sélecteur de pays dans le widget InternationalPhoneNumberInput. Elle définit le type de sélecteur utilisé pour choisir le pays du numéro de téléphone.
            selectorType: PhoneInputSelectorType.DIALOG,
          ),
          initialValue: PhoneNumber(
            // est utilisée pour définir une valeur initiale dans le champ de saisie du numéro de téléphone.
            phoneNumber: '',
            isoCode:
                'CM', // ISO code for Cameroon et crée un objet PhoneNumber avec un numéro de téléphone vide (phoneNumber: '') et un code de pays spécifié (isoCode: 'CM' pour le Cameroun).
          ),
          inputDecoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: (''),
              labelStyle: TextStyle(color: BLACK_GREY)),
        ),

        // TextFormField(
        //   keyboardType: TextInputType.phone,
        //   controller: _controllerPhoneNumber,
        //   style: TextStyle(color: CHARCOAL),

        //   //la fonction onChanged qui est appelée chaque fois que l'utilisateur modifie le texte dans le champ de saisie.
        //   onChanged: (textValue) {
        //     setState(() {
        //       if (_globalFunction.validateMobileNumber(textValue)) {
        //         _buttonDisabled = false;
        //         _validate = 'phone_number';
        //         //} else if(_globalFunction.validateEmail(textValue)){
        //         //_buttonDisabled = false;
        //         //_validate = 'email';
        //       } else {
        //         _buttonDisabled = true;
        //       }
        //     });
        //   },

        //   decoration: InputDecoration(
        //       focusedBorder: UnderlineInputBorder(
        //           borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
        //       enabledBorder: UnderlineInputBorder(
        //         borderSide: BorderSide(color: Color(0xFFCCCCCC)),
        //       ),
        //       labelText:
        //           AppLocalizations.of(context)!.translate('phone_number')!,
        //       labelStyle: TextStyle(color: BLACK_GREY)),
        // ),
        SizedBox(
          height: 5,
        ),

        Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.translate('example')! + ' : ',
                  style: GlobalStyle.authNotes),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('237658833784', style: GlobalStyle.authNotes),
                  //Text('example@domain.com', style: GlobalStyle.authNotes)
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        // creation du champ de saisie pour le passe world
        TextFormField(
          keyboardType: TextInputType.text,
          controller: _controllerPincode,
          style: TextStyle(color: CHARCOAL),
          //la fonction onChanged qui est appelée chaque fois que l'utilisateur modifie le texte dans le champ de saisie.
          onChanged: (textValue) {
            setState(() {
              if (_globalFunction.validateMobileNumber(textValue)) {
                _buttonDisabled =
                    false; // si le champs de saisr est vide alors le boutton sera active
                _validate = 'Pin_code';
              } else {
                _buttonDisabled =
                    false; // cette ligne active egalement le boutton
              }
            });
          },

          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: 'Mot de passe',
              labelStyle: TextStyle(color: BLACK_GREY)),
        ),
        SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.translate('example')! + ' : ',
                  style: GlobalStyle.authNotes),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('568923149', style: GlobalStyle.authNotes),
                  //Text('example@domain.com', style: GlobalStyle.authNotes)
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),

        Text(
          'mot de passe  oublie ?',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          textAlign: TextAlign.right,
        ),

        SizedBox(
          height: 50,
        ),

        // creation du boutton Next avec ses differentes apparence en fonction de son etat active ou desactive
        Container(
          child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) =>
                      states.contains(MaterialState.disabled)
                          ? Colors.grey[300]!
                          : _buttonDisabled
                              ? Colors.grey[300]!
                              : PRIMARY_COLOR,
                ),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                )),
              ),
              onPressed: () {
                //verification si la valeur du phone number est correct
                if (!_buttonDisabled) {
                  // vérifie si la variable _buttonDisabled est false. Si c'est le cas, cela signifie que le bouton associé à cette condition n'a pas été désactivé, et le code à l'intérieur du bloc d'instructions sera exécuté. Si _buttonDisabled est true, cela signifie que le bouton est désactivé et le code à l'intérieur du bloc d'instructions ne sera pas exécuté.
                  // appel de la fonction login
                  signin(password: _controllerPincode.text);
                  //signin( _controllerPhoneNumber.text , _controllerPincode.text);// le probleme ici est la fonction signin est declare depuis le haut avec un seule parametre qui est le password qui peut etre null ou defini directement sa valeur dnas le code
                }
              },
              // verification si la valeur du code pin est correct

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'connexion',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _buttonDisabled ? Colors.grey[600] : Colors.white),
                  textAlign: TextAlign.center,
                ),
              )),
        ),
        SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            ' Ou connectez-vous avec !',
            style: GlobalStyle.authSignWith,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationBarPage()));
                  Fluttertoast.showToast(
                      msg: 'signin_google', toastLength: Toast.LENGTH_LONG);
                },
                child: Image(
                  image: AssetImage("assets/images/google.png"),
                  width: 40,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SignupPhoneNumberVerificationPage(
                                phoneNumber: '658833784',
                              )));
                  Fluttertoast.showToast(
                      msg: 'signin_facebook', toastLength: Toast.LENGTH_LONG);
                },
                child: Image(
                  image: AssetImage("assets/images/facebook.png"),
                  width: 40,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationBarPage()));
                  Fluttertoast.showToast(
                      msg: 'signin_twitter', toastLength: Toast.LENGTH_LONG);
                },
                child: Image(
                  image: AssetImage("assets/images/twitter.png"),
                  width: 40,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupPage()));
              FocusScope.of(context).unfocus();
            },
            child: Wrap(
              children: [
                Text(
                  'pas encore de compte ?',
                  style: GlobalStyle.authBottom1,
                ),
                Text(
                  'Creez-en un !',
                  style: GlobalStyle.authBottom2,
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
