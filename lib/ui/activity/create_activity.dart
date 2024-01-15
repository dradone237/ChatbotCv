import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ijshopflutter/model/activity/activity_model.dart';
import 'package:ijshopflutter/services/network/api_service.dart';
import 'package:ijshopflutter/ui/activity/activity.dart';
import 'package:ijshopflutter/ui/general/activity_detail/Activity_detail.dart';
import 'package:ijshopflutter/ui/reuseable/dropdown_form_input.dart';
import 'package:ijshopflutter/ui/reuseable/text_form_input.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';
import '../../config/global_style.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class CreateActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateActivityForm(),
    );
  }
}

enum CustomFileType {
  image,
  pdf,
}

class CreateActivityForm extends StatefulWidget {
  @override
  _CreateActivityFormState createState() => _CreateActivityFormState();
}

class _CreateActivityFormState extends State<CreateActivityForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;
  final apiService = ApiService();
  CancelToken apiToken = CancelToken();
  // int currentStep = 0;
  List<PlatformFile> activityImages = [];
  List<File> listFile = [];
  String fileName = '';
  TextEditingController title = TextEditingController();
  TextEditingController service = TextEditingController();
  TextEditingController content = TextEditingController();

  TextEditingController siZe = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController printFormat = TextEditingController();
  TextEditingController language = TextEditingController();
  TextEditingController targetLanguage = TextEditingController();
  TextEditingController slideCount = TextEditingController();
  String selectedLanguage = 'fr';
  String selectedService = 'impression';
  String type = 'pdf';

  List<DropdownItem> languageItems = [
    DropdownItem('Français', 'fr'),
    DropdownItem('Anglais', 'en'),
  ];
  List<DropdownItem> typeItems = [
    DropdownItem('PDF', 'pdf'),
    DropdownItem('JPG', 'jpd'),
  ];

  List<DropdownItem> serviceItems = [
    DropdownItem('Impression', 'impression'),
    DropdownItem('Saisie', 'saisie'),
    DropdownItem('Traduction', 'traduction'),
  ];

  CustomFileType? selectedFileType;

  List<File>? selectedFiles = [];

  int pageIndex = 0;
  Uint8List? image;

  bool open = false;

  PdfImageRendererPdf? pdf;
  int? count;
  PdfImageRendererPageSize? size;

  bool cropped = false;

  int asyncTasks = 0;

  late Color screenPickerColor;
  // Color for the picker in a dialog using onChanged.
  late Color dialogPickerColor;
  // Color for picker using the color select dialog.
  late Color dialogSelectColor;

  @override
  void initState() {
    super.initState();

    screenPickerColor = Colors.blue; // Material blue.
    dialogPickerColor = Colors.red; // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
  }

  Future<void> renderPage() async {
    size = await pdf!.getPageSize(pageIndex: pageIndex);
    final i = await pdf!.renderPage(
      pageIndex: pageIndex,
      x: cropped ? 100 : 0,
      y: cropped ? 100 : 0,
      width: cropped ? 100 : size!.width,
      height: cropped ? 100 : size!.height,
      scale: 3,
      background: Colors.white,
    );

    setState(() {
      image = i;
    });
  }

  Future<void> openPdf({required String path}) async {
    if (pdf != null) {
      await pdf!.close();
    }
    pdf = PdfImageRendererPdf(path: path);
    await pdf!.open();
    setState(() {
      open = true;
    });
  }

  Future<void> openPdfPage({required int pageIndex}) async {
    await pdf!.openPage(pageIndex: pageIndex);
  }

// Define custom colors. The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: GlobalStyle.appBarIconThemeColor,
        ),
        // elevation: GlobalStyle.appBarElevation,
        title: Text(
          'ACTIVITY',
          style: GlobalStyle.appBarTitle,
        ),
        elevation: 1,
        centerTitle: true,
        backgroundColor: GlobalStyle.appBarBackgroundColor,
        systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
        // bottom: _globalWidget.bottomAppBar(),
      ),
      body: FormBuilder(
        key: _fbKey,
        child: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
            primary: Colors.cyan,
          )),
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            onStepTapped: (step) => setState(() => _currentStep = step),
            onStepCancel: _currentStep == 0
                ? null
                : () => setState(() => _currentStep -= 1),
            onStepContinue: () {
              setState(() async {
                if (_currentStep < 2) {
                  // _currentStep++;
                  _currentStep += 1;
                }
                //else {
                //   if (_fbKey.currentState!.saveAndValidate()) {
                //     // Collecter les données du formulaire
                //     final activity = ActivityModel(
                //       id: 0,
                //       title: title.text,
                //       image: selectedFiles != null && selectedFiles!.isNotEmpty
                //           ? selectedFiles![0].path
                //           : '',
                //       review: 0,
                //       service: selectedService,
                //       printFormat: 'A4',
                //       selectedLanguage: 'fr',
                //     );

                //     // Envoyer les données à l'API
                //     try {
                //       await apiService.createActivity(activity, apiToken);

                //       // Après la création réussie, naviguez vers la page de détails
                //       Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (context) => ActivityPage(activity),
                //         ),
                //       );
                //     } catch (error) {
                //       // Gérer les erreurs d'API, par exemple en affichant un message d'erreur.
                //       print(
                //           'Erreur lors de la création de l\'activité : $error');
                //     }
                //   }
                // }

                else {
                  //Submit your form data here
                  if (_fbKey.currentState!.saveAndValidate()) {
                    // Handle the form data
                    print(_fbKey.currentState!.value);
                  }
                }
              });
            },
            controlsBuilder:
                (BuildContext context, ControlsDetails controlsDetails) {
              return Row(
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: controlsDetails.onStepCancel,
                    child: const Text('EXIT'),
                  ),
                  const SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Colors.cyan,
                                  Color.fromARGB(255, 123, 228, 241),
                                  Color.fromARGB(255, 161, 229, 238),
                                  // Color.fromARGB(0, 108, 238, 238),
                                  // Color(0xccffff),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment
                              .centerRight, // Définit l'alignement à droite
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(10.0),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: controlsDetails.onStepContinue,
                            child: const Text('NEXT'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            steps: [
              Step(
                state:
                    _currentStep > 0 ? StepState.complete : StepState.indexed,
                isActive: _currentStep >= 0,
                title: Text('Étape 1'),
                content: Column(
                  children: [
                    TextFormInput(
                      controller: title,
                      label: 'Nom de l activité',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Activity Name ';
                        }
                        return null;
                      },
                    ),
                    TextFormInput(
                      controller: content,
                      label: 'Nom de l activité',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Activity Name ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomDropdown(
                      items: serviceItems,
                      selectedValue: selectedService,
                      onChanged: (newValue) {
                        setState(() {
                          selectedService = newValue!;
                        });
                      },
                      label: 'Type de service',
                      icon: Icons.settings,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sélectionnez le type de fichier',
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: CustomFileType.image,
                                  groupValue: selectedFileType,
                                  onChanged: (CustomFileType? value) {
                                    setState(() {
                                      selectedFileType = value;
                                    });
                                  },
                                ),
                                Text('Image'),
                                Radio(
                                  value: CustomFileType.pdf,
                                  groupValue: selectedFileType,
                                  onChanged: (CustomFileType? value) {
                                    setState(() {
                                      selectedFileType = value;
                                    });
                                  },
                                ),
                                Text('PDF'),
                              ],
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                if (selectedFileType == CustomFileType.image) {
                                  // Code pour sélectionner des images
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.image,
                                    allowMultiple: true,
                                  );

                                  if (result != null) {
                                    // Traitez les fichiers image sélectionnés (result.files)
                                    // print('Images sélectionnées : ${result.files}');
                                    setState(() {
                                      selectedFiles = result.paths
                                          .map((path) => File(path!))
                                          .toList();
                                    });
                                  }
                                } else if (selectedFileType ==
                                    CustomFileType.pdf) {
                                  // Code pour sélectionner des fichiers PDF
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf'],
                                  );

                                  if (result != null) {
                                    await openPdf(path: result.paths[0]!);
                                    pageIndex = 0;
                                    count = await pdf!.getPageCount();
                                    await renderPage();
                                  }
                                } else {
                                  // Aucune option sélectionnée
                                  print(
                                    Text(
                                        'Veuillez sélectionner un type de fichier'),
                                  );
                                }
                              },
                              child: Text('Sélectionner un fichier'),
                            ),
                            if (selectedFileType == CustomFileType.image)
                              Container(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: selectedFiles?.length,
                                  itemBuilder: (context, index) {
                                    if (selectedFiles?[index] != null)
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.file(
                                          selectedFiles![index],
                                          height: 70,
                                          width: 70,
                                        ),
                                      );
                                    else
                                      return Container();
                                  },
                                ),
                              ),
                            if (selectedFileType == CustomFileType.pdf)
                              if (image != null) ...[
                                Container(
                                    padding: const EdgeInsets.all(8.0),
                                    height: 70,
                                    width: 70,
                                    child: Image.memory(image!)
                                    // Image(image: MemoryImage(image!)),
                                    )
                              ],
                          ]),
                    ),
                  ],
                ),
              ),
              Step(
                state:
                    _currentStep > 0 ? StepState.complete : StepState.indexed,
                isActive: _currentStep >= 1,
                title: Text('Étape 2'),
                content: Column(
                  children: [
                    CustomDropdown(
                      items: typeItems,
                      selectedValue: type,
                      onChanged: (newValue) {
                        setState(() {
                          type = newValue!;
                        });
                      },
                      label: 'Type de document',
                      icon: Icons.language,
                    ),

                    TextFormInput(
                      controller: siZe,
                      label: 'taille du fichier',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'veillez entrer la taille  ';
                        }
                        return null;
                      },
                    ),

                    TextFormInput(
                      controller: printFormat,
                      label: 'format d impression',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'veillez entrer le format ';
                        }
                        return null;
                      },
                    ),

                    TextFormInput(
                      controller: slideCount,
                      label: 'Nombre de page',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'veillez entre le nombre de page ';
                        }
                        return null;
                      },
                    ),

                    CustomDropdown(
                      items: languageItems,
                      selectedValue: selectedLanguage,
                      onChanged: (newValue) {
                        setState(() {
                          selectedLanguage = newValue!;
                        });
                      },
                      label: 'Langue',
                      icon: Icons.language,
                    ),

                    // Text('Langue sélectionnée: $selectedLanguage'),
                    // Text('Service sélectionné: $selectedService'),

                    ListTile(
                      title:
                          const Text('Cliquez pour selectionner une couleur'),
                      subtitle: Text(
                        '${ColorTools.materialNameAndCode(dialogPickerColor, colorSwatchNameMap: colorsNameMap)} '
                        'aka ${ColorTools.nameThatColor(dialogPickerColor)}',
                      ),
                      trailing: ColorIndicator(
                        width: 44,
                        height: 44,
                        borderRadius: 4,
                        color: dialogPickerColor,
                        onSelectFocus: false,
                        onSelect: () async {
                          final Color colorBeforeDialog = dialogPickerColor;

                          if (!(await colorPickerDialog())) {
                            setState(() {
                              dialogPickerColor = colorBeforeDialog;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      transitionBuilder: (BuildContext context, Animation<double> a1,
          Animation<double> a2, Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
}

class FormBuilderqs {
  static required(BuildContext context) {}
}
