/*
This is signup page

include file in reuseable/global_function.dart to call function from GlobalFunction

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup_phone_number_verification.dart';
import 'package:ijshopflutter/ui/bottom_navigation_bar.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup_email_choose_verification.dart';
import 'package:ijshopflutter/ui/authentication/signup/signup_phone_number_choose_verification.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/network/api_service.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  bool _buttonDisabled = true;
  String _validate = '';
  String phone = " ";

  //TextEditingController _etEmailPhone = TextEditingController();
  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerPincode = TextEditingController();
  // TextEditingController _controllerName = TextEditingController();
  //TextEditingController _controllerEmail = TextEditingController();

  // creation et utilisation de la classe ApiService  et inportation des des differents packages
  ApiService apiService = ApiService(); // instance de la classe api service
  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //_etEmailPhone.dispose();
    _controllerPhoneNumber.dispose();
    _controllerPincode.dispose();
    //_controllerName.dispose();
    //_controllerEmail.dispose();
    super.dispose();
  }

  void autoCompte(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final hasAccount = prefs.getBool('hasAccount') ?? false;

    if (hasAccount) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarPage()));
    }
  }

  void signup(String phoneNumber, String password) {
    try {
      final data = {
        'phoneNumber': phoneNumber,
        'password': password,
        //'name': name,
        // 'firstName': name,
        // 'lastName': name,
        // 'email': email,
        // 'sexe': "MAN",
        // 'type': "STUDENT"
      };
      final response = apiService.signup(data, apiToken);
      print(response);

      // si  le sign up  c'est bien passe car l'utilisateur a bien entre les informations puis l'utiliateur seras rediriger directemment dans le menu principale qui est le boutton navigation
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationBarPage()));
    } catch (e) {
      print(e);
      print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
      children: <Widget>[
        // Center(child: Image.asset('assets/images/logo_light.png', height: 50)),
        SizedBox(
          height: 50,
        ),
        Text(("S'inscrire"), style: GlobalStyle.authTitle),

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
            selectorType: PhoneInputSelectorType.DIALOG,
          ),
          initialValue: PhoneNumber(
            phoneNumber: '',
            isoCode: 'CM', // ISO code for Cameroon
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

        SizedBox(
          height: 0,
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
          height: 0,
        ),

        // creation du champ de saisie pour le code_pin

        TextFormField(
          keyboardType: TextInputType.text,
          controller: _controllerPincode,
          style: TextStyle(color: CHARCOAL),
          //la fonction onChanged qui est appelée chaque fois que l'utilisateur modifie le texte dans le champ de saisie.
          onChanged: (textValue) {
            setState(() {
              if (_globalFunction.validateMobileNumber(textValue)) {
                _buttonDisabled = false;
                _validate = 'pin_code';
                //} else if(_globalFunction.validateEmail(textValue)){
                //_buttonDisabled = false;
                //_validate = 'email';
              } else {
                _buttonDisabled = true;
              }
            });
          },

          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: 'Mot de passe: ',
              labelStyle: TextStyle(color: BLACK_GREY)),
        ),
        SizedBox(
          height: 0,
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
                  Text('Teranova12', style: GlobalStyle.authNotes),
                  //Text('example@domain.com', style: GlobalStyle.authNotes)
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 0,
        ),

        // // creation du champ de saisie pour le le nom

        // TextFormField(
        //   keyboardType: TextInputType.name,
        //   controller: _controllerName,
        //   style: TextStyle(color: CHARCOAL),
        //   //la fonction onChanged qui est appelée chaque fois que l'utilisateur modifie le texte dans le champ de saisie.
        //   onChanged: (textValue) {
        //     setState(() {
        //       if (_globalFunction.validateMobileNumber(textValue)) {
        //         _buttonDisabled = false;
        //         _validate = 'Name';
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
        //       labelText: 'Nom',
        //       labelStyle: TextStyle(color: BLACK_GREY)),
        // ),
        // SizedBox(
        //   height: 0,
        // ),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(AppLocalizations.of(context)!.translate('example')! + ' : ',
        //           style: GlobalStyle.authNotes),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text('Takougang', style: GlobalStyle.authNotes),
        //           //Text('example@domain.com', style: GlobalStyle.authNotes)
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 0,
        // ),
        // creation du champ de saisie pour l'email

        // TextFormField(
        //   //keyboardType: TextInputType.emailAddress,
        //   //controller: _etEmailPhone,
        //   keyboardType: TextInputType.emailAddress,
        //   controller: _controllerEmail,
        //   style: TextStyle(color: CHARCOAL),
        //   //la fonction onChanged qui est appelée chaque fois que l'utilisateur modifie le texte dans le champ de saisie.
        //   onChanged: (textValue) {
        //     setState(() {
        //       if (_globalFunction.validateMobileNumber(textValue)) {
        //         _buttonDisabled = false;
        //         _validate = 'email';
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
        //       labelText: 'Email',
        //       labelStyle: TextStyle(color: BLACK_GREY)),
        // ),
        // SizedBox(
        //   height: 0,
        // ),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(AppLocalizations.of(context)!.translate('example')! + ' : ',
        //           style: GlobalStyle.authNotes),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text('dradonetakougang@gmail.com',
        //               style: GlobalStyle.authNotes),
        //           //Text('example@domain.com', style: GlobalStyle.authNotes)
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 0,
        // ),

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
                if (!_buttonDisabled) {
                  signup(
                    _controllerPhoneNumber.text,
                    _controllerPincode.text,
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SignupPhoneNumberVerificationPage()));
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  AppLocalizations.of(context)!.translate('register')!,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _buttonDisabled ? Colors.grey[600] : Colors.white),
                  textAlign: TextAlign.center,
                ),
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            AppLocalizations.of(context)!.translate('or_signup_with')!,
            style: GlobalStyle.authSignWith,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationBarPage()),
                      (Route<dynamic> route) => false);
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!
                          .translate('signup_google')!,
                      toastLength: Toast.LENGTH_LONG);
                },
                child: Image(
                  image: AssetImage("assets/images/google.png"),
                  width: 40,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationBarPage()),
                      (Route<dynamic> route) => false);
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!
                          .translate('signup_facebook')!,
                      toastLength: Toast.LENGTH_LONG);
                },
                child: Image(
                  image: AssetImage("assets/images/facebook.png"),
                  width: 40,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationBarPage()),
                      (Route<dynamic> route) => false);
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!
                          .translate('signup_twitter')!,
                      toastLength: Toast.LENGTH_LONG);
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
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            },
            child: Wrap(
              children: [
                Text(
                  ('Deja menbre ?'),
                  style: GlobalStyle.authBottom1,
                ),
                Text(
                  ('Connexion'),
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
