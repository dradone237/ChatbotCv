import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:ijshopflutter/ui/account/education.dart';
import 'package:ijshopflutter/ui/account/preferences.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? date;
  var currentOption = 0; // Pour la première option
  var options = [0, 1]; // Les valeurs pour les boutons radio

  void refreshData() {
    // Implémentez le code pour rafraîchir les données ici
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenu dans nottre application'),
      ),
      body: Column(
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
                      'CLIQUE SUR SUIVANT POUR DEMARE VOTRE CV AVEC L\'\ IA  ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     labelText: ' ',
                    //     labelStyle: TextStyle(fontSize: 12),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Action à effectuer lors du clic sur le bouton "Suivant"
                        },
                        child: Text('Retour',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          versPreferencesPage(context);
                        },
                        // Action à effectuer lors du clic sur le bouton "suivant "

                        child: Text('Suivant',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                      ),
                    ],
                  ),
                )
                // ... Autres champs et widgets ici ...
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void versPreferencesPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PreferencesPage(),
    ),
  );
}








// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _Home1PageState createState() => _Home1PageState();
// }

// class _Home1PageState extends State<HomePage> {
//   DateTime? date;
//   var currentOption = 0; // Pour la première option
//   var options = [0, 1]; // Les valeurs pour les boutons radio

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Resume'),
//       ),
//       body: Column(
//         children: <Widget>[
//           SizedBox(height: 120),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'REDIGEZ UNE SYNTHESE PROFESSIONNELLE ',
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Entrez votre synthese ',
//                         labelStyle: TextStyle(fontSize: 12),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // SizedBox(height: 20),
//                 // Column(
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: <Widget>[
//                 //     Text(
//                 //       'OU AS-TU OBTENU LE CERTIFICAT?',
//                 //       style: TextStyle(
//                 //         fontSize: 15,
//                 //         fontWeight: FontWeight.bold,
//                 //       ),
//                 //     ),
//                 //     TextFormField(
//                 //       decoration: InputDecoration(
//                 //         labelText: 'Entrez le nom du centre de formation ',
//                 //         labelStyle: TextStyle(fontSize: 12),
//                 //         border: OutlineInputBorder(
//                 //           borderRadius: BorderRadius.circular(10.0),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 // SizedBox(height: 20),
//                 // Column(
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: <Widget>[
//                 //     Text(
//                 //       'QUAND AS-TU OBTENU LE CERTIFICAT ?',
//                 //       style: TextStyle(
//                 //         fontSize: 15,
//                 //         fontWeight: FontWeight.bold,
//                 //       ),
//                 //     ),
//                 //     TextFormField(
//                 //       decoration: InputDecoration(
//                 //         labelText: 'Ddate 2024  ',
//                 //         labelStyle: TextStyle(fontSize: 12),
//                 //         border: OutlineInputBorder(
//                 //           borderRadius: BorderRadius.circular(10.0),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 // SizedBox(height: 20),
//                 // Column(
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: <Widget>[
//                 //     Text(
//                 //       'EN QUOI LE CERTIFICAT EST-IL PERTIMENT ?',
//                 //       style: TextStyle(
//                 //         fontSize: 15,
//                 //         fontWeight: FontWeight.bold,
//                 //       ),
//                 //     ),
//                 //     TextFormField(
//                 //       decoration: InputDecoration(
//                 //         labelText: 'Defini la competence du certificat  ',
//                 //         labelStyle: TextStyle(fontSize: 12),
//                 //         border: OutlineInputBorder(
//                 //           borderRadius: BorderRadius.circular(10.0),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 SizedBox(height: 150),
//                 Container(
//                   color: Colors.blue,
//                   width: double.infinity,
//                   height: 50,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();

//                           // Action à effectuer lors du clic sur le bouton "Suivant"
//                         },
//                         child: Text('Retour',
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 20)),
//                         style: ElevatedButton.styleFrom(primary: Colors.blue),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Action à effectuer lors du clic sur le bouton "Retour"
//                         },
//                         child: Text('Suivant',
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 20)),
//                         style: ElevatedButton.styleFrom(primary: Colors.blue),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





// /*
// This is home page

// For this homepage, appBar is created at the bottom after CustomScrollView
// we used AutomaticKeepAliveClientMixin to keep the state when moving from 1 navbar to another navbar, so the page is not refresh overtime

// include file in reuseable/global_function.dart to call function from GlobalFunction
// include file in reuseable/global_widget.dart to call function from GlobalWidget
// include file in reuseable/cache_image_network.dart to use cache image network
// include file in reuseable/shimmer_loading.dart to use shimmer loading
// include file in model/home/category/category_for_you_model.dart to get categoryForYouData
// include file in model/home/category/category_model.dart to get categoryData
// include file in model/home/coupon_model.dart to get couponData
// include file in model/home/flashsale_model.dart to get flashsaleData
// include file in model/home/home_banner_model.dart to get homeBannerData
// include file in model/home/last_search_model.dart to get lastSearchData
// include file in model/home/trending_model.dart to get homeTrendingData
// include file in model/home/recomended_product_model.dart to get recomendedProductData

// install plugin in pubspec.yaml
// - carousel_slider => slider images (https://pub.dev/packages/carousel_slider)
// - fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

// Don't forget to add all images and sound used in this pages at the pubspec.yaml
//  */

// import 'dart:async';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ijshopflutter/bloc/home/category/category/bloc.dart';
// import 'package:ijshopflutter/bloc/home/category/category_for_you/bloc.dart';
// import 'package:ijshopflutter/bloc/home/flashsale/bloc.dart';
// import 'package:ijshopflutter/bloc/home/home_banner/bloc.dart';
// import 'package:ijshopflutter/bloc/home/home_trending/bloc.dart';
// import 'package:ijshopflutter/bloc/home/last_search/bloc.dart';
// import 'package:ijshopflutter/bloc/home/recomended_product/bloc.dart';
// import 'package:ijshopflutter/config/constants.dart';
// import 'package:ijshopflutter/config/global_style.dart';
// import 'package:ijshopflutter/model/home/category/category_for_you_model.dart';
// import 'package:ijshopflutter/model/home/category/category_model.dart';
// import 'package:ijshopflutter/model/home/flashsale_model.dart';
// import 'package:ijshopflutter/model/home/home_banner_model.dart';
// import 'package:ijshopflutter/model/home/last_search_model.dart';
// import 'package:ijshopflutter/model/home/trending_model.dart';
// import 'package:ijshopflutter/model/home/recomended_product_model.dart';
// import 'package:ijshopflutter/ui/general/chat_us.dart';
// import 'package:ijshopflutter/ui/home/coupon.dart';
// import 'package:ijshopflutter/ui/home/flashsale.dart';
// import 'package:ijshopflutter/ui/home/last_search.dart';
// import 'package:ijshopflutter/ui/general/product_detail/product_detail.dart';
// import 'package:ijshopflutter/ui/general/notification.dart';
// import 'package:ijshopflutter/ui/home/category/product_category.dart';
// import 'package:ijshopflutter/ui/home/search/search_product.dart';
// import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
// import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
// import 'package:ijshopflutter/ui/home/search/search.dart';
// import 'package:ijshopflutter/ui/reuseable/global_function.dart';
// import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
// import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
//   // initialize global function, global widget and shimmer loading
//   final _globalFunction = GlobalFunction();
//   final _globalWidget = GlobalWidget();
//   final _shimmerLoading = ShimmerLoading();

//   List<HomeBannerModel> homeBannerData = [];
//   List<FlashsaleModel> flashsaleData = [];
//   List<LastSearchModel> lastSearchData = [];
//   List<HomeTrendingModel> homeTrendingData = [];
//   List<CategoryForYouModel> categoryForYouData = [];
//   List<CategoryModel> categoryData = [];

//   late HomeBannerBloc _homeBannerBloc;
//   bool _lastDataHomeBanner = false;

//   late FlashsaleBloc _flashsaleBloc;
//   bool _lastDataFlashsale = false;

//   late LastSearchBloc _lastSearchBloc;
//   bool _lastDataSeach = false;

//   late HomeTrendingBloc _homeTrendingBloc;
//   bool _lastDataTrending = false;

//   late CategoryForYouBloc _categoryForYouBloc;
//   bool _lastDataCategoryForYou = false;

//   late CategoryBloc _categoryBloc;
//   bool _lastDataCategory = false;

//   List<RecomendedProductModel> recomendedProductData = [];
//   late RecomendedProductBloc _recomendedProductBloc;
//   int _apiPageRecomended = 0;
//   bool _lastDataRecomended = false;
//   bool _processApiRecomended = false;

//   CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

//   int _currentImageSlider = 0;

//   late ScrollController _scrollController;
//   Color _topIconColor = Colors.white;
//   Color _topSearchColor = Colors.white;
//   late AnimationController _topColorAnimationController;
//   late Animation _appBarColor;
//   SystemUiOverlayStyle _appBarSystemOverlayStyle = SystemUiOverlayStyle.light;

//   Timer? _flashsaleTimer;
//   late int _flashsaleSecond;

//   void _startFlashsaleTimer() {
//     const period = const Duration(seconds: 1);
//     _flashsaleTimer = Timer.periodic(period, (timer) {
//       setState(() {
//         _flashsaleSecond--;
//       });
//       if (_flashsaleSecond == 0) {
//         _cancelFlashsaleTimer();
//         Fluttertoast.showToast(
//             msg: AppLocalizations.of(context)!.translate('flash_sale_is_over')!,
//             toastLength: Toast.LENGTH_LONG);
//       }
//     });
//   }

//   void _cancelFlashsaleTimer() {
//     if (_flashsaleTimer != null) {
//       _flashsaleTimer?.cancel();
//       _flashsaleTimer = null;
//     }
//   }

//   // keep the state to do not refresh when switch navbar
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     // get data when initState
//     _homeBannerBloc = BlocProvider.of<HomeBannerBloc>(context);
//     _homeBannerBloc
//         .add(GetHomeBanner(sessionId: SESSION_ID, apiToken: apiToken));

//     _flashsaleBloc = BlocProvider.of<FlashsaleBloc>(context);
//     _flashsaleBloc.add(GetFlashsaleHome(
//         sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));

//     _lastSearchBloc = BlocProvider.of<LastSearchBloc>(context);
//     _lastSearchBloc.add(GetLastSearchHome(
//         sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));

//     _homeTrendingBloc = BlocProvider.of<HomeTrendingBloc>(context);
//     _homeTrendingBloc.add(GetHomeTrending(
//         sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));

//     _categoryForYouBloc = BlocProvider.of<CategoryForYouBloc>(context);
//     _categoryForYouBloc
//         .add(GetCategoryForYou(sessionId: SESSION_ID, apiToken: apiToken));

//     _categoryBloc = BlocProvider.of<CategoryBloc>(context);
//     _categoryBloc.add(GetCategory(sessionId: SESSION_ID, apiToken: apiToken));

//     _recomendedProductBloc = BlocProvider.of<RecomendedProductBloc>(context);
//     _recomendedProductBloc.add(GetRecomendedProduct(
//         sessionId: SESSION_ID,
//         skip: _apiPageRecomended.toString(),
//         limit: LIMIT_PAGE.toString(),
//         apiToken: apiToken));

//     setupAnimateAppbar();

//     // set how many times left for flashsale
//     var timeNow = DateTime.now();

//     // 8000 second = 2 hours 13 minutes 20 second for flashsale timer
//     var flashsaleTime =
//         timeNow.add(Duration(seconds: 8000)).difference(timeNow);
//     _flashsaleSecond = flashsaleTime.inSeconds;
//     _startFlashsaleTimer();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     apiToken.cancel("cancelled"); // cancel fetch data from API

//     _scrollController.dispose();
//     _topColorAnimationController.dispose();

//     _cancelFlashsaleTimer();
//     super.dispose();
//   }

//   void setupAnimateAppbar() {
//     // use this function and paramater to animate top bar
//     _topColorAnimationController =
//         AnimationController(vsync: this, duration: Duration(seconds: 0));
//     _appBarColor = ColorTween(begin: Colors.transparent, end: Colors.white)
//         .animate(_topColorAnimationController);
//     _scrollController = ScrollController()
//       ..addListener(() {
//         _topColorAnimationController.animateTo(_scrollController.offset / 120);
//         // if scroll for above 150, then change app bar color to white, search button to dark, and top icon color to dark
//         // if scroll for below 150, then change app bar color to transparent, search button to white and top icon color to light
//         if (_scrollController.hasClients &&
//             _scrollController.offset > (150 - kToolbarHeight)) {
//           if (_topIconColor != BLACK_GREY) {
//             _topIconColor = BLACK_GREY;
//             _topSearchColor = Colors.grey[100]!;
//             _appBarSystemOverlayStyle = SystemUiOverlayStyle.dark;
//           }
//         } else {
//           if (_topIconColor != Colors.white) {
//             _topIconColor = Colors.white;
//             _topSearchColor = Colors.white;
//             _appBarSystemOverlayStyle = SystemUiOverlayStyle.light;
//           }
//         }
//       });
//   }

//   // this function used to fetch data from API if we scroll to the bottom of the page
//   void _onScroll() {
//     double maxScroll = _scrollController.position.maxScrollExtent;
//     double currentScroll = _scrollController.position.pixels;

//     if (currentScroll == maxScroll) {
//       if (_lastDataRecomended == false && !_processApiRecomended) {
//         _recomendedProductBloc.add(GetRecomendedProduct(
//             sessionId: SESSION_ID,
//             skip: _apiPageRecomended.toString(),
//             limit: LIMIT_PAGE.toString(),
//             apiToken: apiToken));
//         _processApiRecomended = true;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // if we used AutomaticKeepAliveClientMixin, we must call super.build(context);
//     super.build(context);

//     final double boxImageSize = (MediaQuery.of(context).size.width / 3);
//     final double categoryForYouHeightShort = boxImageSize;
//     final double categoryForYouHeightLong = (boxImageSize * 2);

//     return Scaffold(
//       body: MultiBlocListener(
//         listeners: [
//           BlocListener<HomeBannerBloc, HomeBannerState>(
//             listener: (context, state) {
//               if (state is HomeBannerError) {
//                 _globalFunction.showToast(
//                     type: 'error', message: state.errorMessage);
//               }
//               if (state is GetHomeBannerSuccess) {
//                 if (state.homeBannerData.length == 0) {
//                   _lastDataHomeBanner = true;
//                 } else {
//                   homeBannerData.addAll(state.homeBannerData);
//                 }
//               }
//             },
//           ),
//           BlocListener<FlashsaleBloc, FlashsaleState>(
//             listener: (context, state) {
//               if (state is FlashsaleHomeError) {
//                 _globalFunction.showToast(
//                     type: 'error', message: state.errorMessage);
//               }
//               if (state is GetFlashsaleHomeSuccess) {
//                 if (state.flashsaleData.length == 0) {
//                   _lastDataFlashsale = true;
//                 } else {
//                   flashsaleData.addAll(state.flashsaleData);
//                 }
//               }
//             },
//           ),
//           BlocListener<LastSearchBloc, LastSearchState>(
//             listener: (context, state) {
//               if (state is LastSearchHomeError) {
//                 _globalFunction.showToast(
//                     type: 'error', message: state.errorMessage);
//               }
//               if (state is GetLastSearchHomeSuccess) {
//                 if (state.lastSearchData.length == 0) {
//                   _lastDataSeach = true;
//                 } else {
//                   lastSearchData.addAll(state.lastSearchData);
//                 }
//               }
//             },
//           ),
//           BlocListener<HomeTrendingBloc, HomeTrendingState>(
//             listener: (context, state) {
//               if (state is HomeTrendingError) {
//                 _globalFunction.showToast(
//                     type: 'error', message: state.errorMessage);
//               }
//               if (state is GetHomeTrendingSuccess) {
//                 homeTrendingData.addAll(state.homeTrendingData);
//               }
//             },
//           ),
//           BlocListener<CategoryForYouBloc, CategoryForYouState>(
//             listener: (context, state) {
//               if (state is CategoryForYouError) {
//                 _globalFunction.showToast(
//                     type: 'error', message: state.errorMessage);
//               }
//               if (state is GetCategoryForYouSuccess) {
//                 if (state.categoryForYouData.length == 0) {
//                   _lastDataCategoryForYou = true;
//                 } else {
//                   categoryForYouData.addAll(state.categoryForYouData);
//                 }
//               }
//             },
//           ),
//           BlocListener<RecomendedProductBloc, RecomendedProductState>(
//             listener: (context, state) {
//               if (state is RecomendedProductError) {
//                 _globalFunction.showToast(
//                     type: 'error', message: state.errorMessage);
//               }
//               if (state is GetRecomendedProductSuccess) {
//                 _scrollController.addListener(_onScroll);
//                 if (state.recomendedProductData.length == 0) {
//                   _lastDataRecomended = true;
//                 } else {
//                   _apiPageRecomended += LIMIT_PAGE;
//                   recomendedProductData.addAll(state.recomendedProductData);
//                 }
//                 _processApiRecomended = false;
//               }
//             },
//           ),
//           BlocListener<CategoryBloc, CategoryState>(
//             listener: (context, state) {
//               if (state is CategoryError) {
//                 _globalFunction.showToast(
//                     type: 'error', message: state.errorMessage);
//               }
//               if (state is GetCategorySuccess) {
//                 if (state.categoryData.length == 0) {
//                   _lastDataCategory = true;
//                 } else {
//                   categoryData.addAll(state.categoryData);
//                 }
//               }
//             },
//           ),
//         ],
//         child: RefreshIndicator(
//           onRefresh: refreshData,
//           child: Stack(
//             children: [
//               CustomScrollView(
//                 controller: _scrollController,
//                 slivers: [
//                   SliverList(
//                       delegate: SliverChildListDelegate([
//                     _createHomeBannerSlider(),
//                     _createCoupon(),
//                     _createGridCategory(),
//                     Container(
//                       margin: EdgeInsets.only(top: 10, left: 16, right: 16),
//                       child: Text(
//                           AppLocalizations.of(context)!
//                               .translate('flash_sale')!,
//                           style: GlobalStyle.sectionTitle),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 4, left: 16, right: 16),
//                       child: Row(
//                         children: [
//                           Text(
//                               AppLocalizations.of(context)!
//                                   .translate('flash_sale_end_in')!,
//                               style: TextStyle(
//                                   fontWeight: FontWeight.normal,
//                                   fontSize: 13,
//                                   color: CHARCOAL)),
//                           _buildFlashsaleTime(),
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => FlashSalePage(
//                                             seconds: _flashsaleSecond)));
//                               },
//                               child: Text(
//                                   AppLocalizations.of(context)!
//                                       .translate('view_all')!,
//                                   style: GlobalStyle.viewAll,
//                                   textAlign: TextAlign.end),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 16),
//                       height: boxImageSize *
//                           GlobalStyle.horizontalProductHeightMultiplication,
//                       child: BlocBuilder<FlashsaleBloc, FlashsaleState>(
//                         builder: (context, state) {
//                           if (state is FlashsaleHomeError) {
//                             return Container(
//                                 child: Center(
//                                     child: Text(ERROR_OCCURED,
//                                         style: TextStyle(
//                                             fontSize: 14, color: BLACK_GREY))));
//                           } else {
//                             if (_lastDataFlashsale) {
//                               return Container(
//                                   child: Center(
//                                       child: Text(
//                                           AppLocalizations.of(context)!
//                                               .translate('no_flash_sale')!,
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color: BLACK_GREY))));
//                             } else {
//                               if (flashsaleData.length == 0) {
//                                 return _shimmerLoading
//                                     .buildShimmerHomeFlashsale(boxImageSize);
//                               } else {
//                                 return ListView.builder(
//                                   padding: EdgeInsets.only(left: 12, right: 12),
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: flashsaleData.length + 1,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     if (index == flashsaleData.length) {
//                                       return _buildLastBox(
//                                           boxImageSize, FlashSalePage());
//                                     } else {
//                                       return _buildFlashsaleCard(
//                                           index, boxImageSize);
//                                     }
//                                   },
//                                 );
//                               }
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 30, left: 16, right: 16),
//                       child: Text(
//                           AppLocalizations.of(context)!
//                               .translate('trending_product')!,
//                           style: GlobalStyle.sectionTitle),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
//                       child: BlocBuilder<HomeTrendingBloc, HomeTrendingState>(
//                         builder: (context, state) {
//                           if (state is HomeTrendingError) {
//                             return Container(
//                                 child: Center(
//                                     child: Text(ERROR_OCCURED,
//                                         style: TextStyle(
//                                             fontSize: 14, color: BLACK_GREY))));
//                           } else {
//                             if (_lastDataTrending) {
//                               return Container(
//                                   child: Center(
//                                       child: Text(
//                                           AppLocalizations.of(context)!
//                                               .translate(
//                                                   'no_trending_product')!,
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color: BLACK_GREY))));
//                             } else {
//                               if (homeTrendingData.length == 0) {
//                                 return _shimmerLoading.buildShimmerTrending(
//                                     MediaQuery.of(context).size.width / 2);
//                               } else {
//                                 return GridView.count(
//                                   padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
//                                   primary: false,
//                                   childAspectRatio: 4 / 1.6,
//                                   shrinkWrap: true,
//                                   crossAxisSpacing: 2,
//                                   mainAxisSpacing: 2,
//                                   crossAxisCount: 2,
//                                   children: List.generate(
//                                       homeTrendingData.length, (index) {
//                                     return _buildTrendingProductCard(index);
//                                   }),
//                                 );
//                               }
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 30, left: 16, right: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                               AppLocalizations.of(context)!
//                                   .translate('your_last_search')!,
//                               style: GlobalStyle.sectionTitle),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => LastSearchPage()));
//                             },
//                             child: Text(
//                                 AppLocalizations.of(context)!
//                                     .translate('view_all')!,
//                                 style: GlobalStyle.viewAll,
//                                 textAlign: TextAlign.end),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 16),
//                       height: boxImageSize *
//                           GlobalStyle.horizontalProductHeightMultiplication,
//                       child: BlocBuilder<LastSearchBloc, LastSearchState>(
//                         builder: (context, state) {
//                           if (state is LastSearchHomeError) {
//                             return Container(
//                                 child: Center(
//                                     child: Text(ERROR_OCCURED,
//                                         style: TextStyle(
//                                             fontSize: 14, color: BLACK_GREY))));
//                           } else {
//                             if (_lastDataSeach) {
//                               return Container(
//                                   child: Center(
//                                       child: Text(
//                                           AppLocalizations.of(context)!
//                                               .translate('no_last_search')!,
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color: BLACK_GREY))));
//                             } else {
//                               if (lastSearchData.length == 0) {
//                                 return _shimmerLoading
//                                     .buildShimmerHorizontalProduct(
//                                         boxImageSize);
//                               } else {
//                                 return ListView.builder(
//                                   padding: EdgeInsets.only(left: 12, right: 12),
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: lastSearchData.length + 1,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     if (index == lastSearchData.length) {
//                                       return _buildLastBox(
//                                           boxImageSize, LastSearchPage());
//                                     } else {
//                                       return _globalWidget
//                                           .buildHorizontalProductCard(
//                                               context, lastSearchData[index]);
//                                     }
//                                   },
//                                 );
//                               }
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 30, left: 16, right: 16),
//                       child: Text(
//                           AppLocalizations.of(context)!
//                               .translate('category_for_you')!,
//                           style: GlobalStyle.sectionTitle),
//                     ),
//                     _createCategoryForYou(boxImageSize,
//                         categoryForYouHeightShort, categoryForYouHeightLong),
//                     Container(
//                       margin: EdgeInsets.only(top: 30, left: 16, right: 16),
//                       child: Text(
//                           AppLocalizations.of(context)!
//                               .translate('recomended_product')!,
//                           style: GlobalStyle.sectionTitle),
//                     ),
//                     BlocBuilder<RecomendedProductBloc, RecomendedProductState>(
//                       builder: (context, state) {
//                         if (state is RecomendedProductError) {
//                           return Container(
//                               child: Center(
//                                   child: Text(ERROR_OCCURED,
//                                       style: TextStyle(
//                                           fontSize: 14, color: BLACK_GREY))));
//                         } else {
//                           if (_lastDataRecomended && _apiPageRecomended == 0) {
//                             return Container(
//                                 child: Text(
//                                     AppLocalizations.of(context)!
//                                         .translate('no_recomended_product')!,
//                                     style: TextStyle(
//                                         fontSize: 14, color: BLACK_GREY)));
//                           } else {
//                             if (recomendedProductData.length == 0) {
//                               return _shimmerLoading.buildShimmerProduct(
//                                   ((MediaQuery.of(context).size.width) - 24) /
//                                           2 -
//                                       12);
//                             } else {
//                               return CustomScrollView(
//                                   shrinkWrap: true,
//                                   primary: false,
//                                   slivers: <Widget>[
//                                     SliverPadding(
//                                       padding:
//                                           EdgeInsets.fromLTRB(12, 8, 12, 8),
//                                       sliver: SliverGrid(
//                                         gridDelegate:
//                                             SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount: 2,
//                                           mainAxisSpacing: 8,
//                                           crossAxisSpacing: 8,
//                                           childAspectRatio:
//                                               GlobalStyle.gridDelegateRatio,
//                                         ),
//                                         delegate: SliverChildBuilderDelegate(
//                                           (BuildContext context, int index) {
//                                             return _globalWidget
//                                                 .buildProductGrid(
//                                                     context,
//                                                     recomendedProductData[
//                                                         index]);
//                                           },
//                                           childCount:
//                                               recomendedProductData.length,
//                                         ),
//                                       ),
//                                     ),
//                                     SliverToBoxAdapter(
//                                       child:
//                                           (_apiPageRecomended == LIMIT_PAGE &&
//                                                   recomendedProductData.length <
//                                                       LIMIT_PAGE)
//                                               ? Wrap()
//                                               : _globalWidget
//                                                   .buildProgressIndicator(
//                                                       _lastDataRecomended),
//                                     ),
//                                   ]);
//                             }
//                           }
//                         }
//                       },
//                     ),
//                   ])),
//                 ],
//               ),
//               // Create AppBar with Animation
//               Container(
//                 height: AppBar().preferredSize.height +
//                     MediaQuery.of(context).padding.top -
//                     20 +
//                     22,
//                 child: AnimatedBuilder(
//                   animation: _topColorAnimationController,
//                   builder: (context, child) => AppBar(
//                     backgroundColor: _appBarColor.value,
//                     systemOverlayStyle: _appBarSystemOverlayStyle,
//                     elevation: GlobalStyle.appBarElevation,
//                     title: Container(
//                       child: TextButton(
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.resolveWith<Color>(
//                               (Set<MaterialState> states) => _topSearchColor,
//                             ),
//                             overlayColor:
//                                 MaterialStateProperty.all(Colors.transparent),
//                             shape: MaterialStateProperty.all(
//                                 RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5.0),
//                             )),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SearchPage()));
//                           },
//                           child: Row(
//                             children: [
//                               SizedBox(width: 8),
//                               Icon(
//                                 Icons.search,
//                                 color: Colors.grey[500],
//                                 size: 18,
//                               ),
//                               SizedBox(width: 8),
//                               Text(
//                                 AppLocalizations.of(context)!
//                                     .translate('search_product')!,
//                                 style: TextStyle(
//                                     color: Colors.grey[500],
//                                     fontWeight: FontWeight.normal),
//                               )
//                             ],
//                           )),
//                     ),
//                     actions: [
//                       GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ChatUsPage()));
//                           },
//                           child: Icon(Icons.email, color: _topIconColor)),
//                       IconButton(
//                           icon: _globalWidget.customNotifIcon(8, _topIconColor),
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => NotificationPage()));
//                           }),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future refreshData() async {
//     setState(() {
//       _apiPageRecomended = 0;
//       homeBannerData.clear();
//       flashsaleData.clear();
//       lastSearchData.clear();
//       homeTrendingData.clear();
//       categoryForYouData.clear();
//       categoryData.clear();
//       recomendedProductData.clear();
//       _homeBannerBloc
//           .add(GetHomeBanner(sessionId: SESSION_ID, apiToken: apiToken));
//       _flashsaleBloc.add(GetFlashsaleHome(
//           sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));
//       _lastSearchBloc.add(GetLastSearchHome(
//           sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));
//       _homeTrendingBloc.add(GetHomeTrending(
//           sessionId: SESSION_ID, skip: '0', limit: '8', apiToken: apiToken));
//       _categoryForYouBloc
//           .add(GetCategoryForYou(sessionId: SESSION_ID, apiToken: apiToken));
//       _categoryBloc.add(GetCategory(sessionId: SESSION_ID, apiToken: apiToken));
//       _recomendedProductBloc.add(GetRecomendedProduct(
//           sessionId: SESSION_ID,
//           skip: _apiPageRecomended.toString(),
//           limit: LIMIT_PAGE.toString(),
//           apiToken: apiToken));
//     });
//   }

//   Widget _createHomeBannerSlider() {
//     double homeBannerWidth = MediaQuery.of(context).size.width;
//     double homeBannerHeight = MediaQuery.of(context).size.width * 6 / 8;

//     return BlocBuilder<HomeBannerBloc, HomeBannerState>(
//       builder: (context, state) {
//         if (state is HomeBannerError) {
//           return Container(
//               width: homeBannerWidth,
//               height: homeBannerHeight,
//               child: Center(
//                   child: Text(ERROR_OCCURED,
//                       style: TextStyle(fontSize: 14, color: BLACK_GREY))));
//         } else {
//           if (_lastDataHomeBanner) {
//             return Container(
//                 width: homeBannerWidth,
//                 height: homeBannerHeight,
//                 child: Center(
//                     child: Text(
//                         AppLocalizations.of(context)!
//                             .translate('no_home_banner_data')!,
//                         style: TextStyle(fontSize: 14, color: BLACK_GREY))));
//           } else {
//             if (homeBannerData.length == 0) {
//               return _shimmerLoading.buildShimmerHomeBanner(
//                   homeBannerWidth, homeBannerHeight);
//             } else {
//               return Column(
//                 children: [
//                   CarouselSlider(
//                     items: homeBannerData
//                         .map((item) => Container(
//                               child: buildCacheNetworkImage(
//                                   width: 0, height: 0, url: item.image),
//                             ))
//                         .toList(),
//                     options: CarouselOptions(
//                         aspectRatio: 8 / 6,
//                         viewportFraction: 1.0,
//                         autoPlay: true,
//                         autoPlayInterval: Duration(seconds: 6),
//                         autoPlayAnimationDuration: Duration(milliseconds: 300),
//                         enlargeCenterPage: false,
//                         onPageChanged: (index, reason) {
//                           setState(() {
//                             _currentImageSlider = index;
//                           });
//                         }),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: homeBannerData.map((item) {
//                       int index = homeBannerData.indexOf(item);
//                       return Container(
//                         width: 8.0,
//                         height: 8.0,
//                         margin: EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 2.0),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: _currentImageSlider == index
//                               ? PRIMARY_COLOR
//                               : Colors.grey[300],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               );
//             }
//           }
//         }
//       },
//     );
//   }

//   Widget _createCoupon() {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => CouponPage()));
//       },
//       child: Container(
//         padding: EdgeInsets.all(12),
//         margin: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//             color: SOFT_BLUE, borderRadius: BorderRadius.circular(5)),
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 child: Text(
//                   AppLocalizations.of(context)!.translate('coupon_waiting')!,
//                   style: TextStyle(
//                       fontSize: 14,
//                       color: Color(0xffffffff),
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             Icon(Icons.local_offer, color: Colors.white)
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFlashsaleTime() {
//     int hour = _flashsaleSecond ~/ 3600;
//     int minute = _flashsaleSecond % 3600 ~/ 60;
//     int second = _flashsaleSecond % 60;

//     return Row(
//       children: [
//         Container(
//           padding: EdgeInsets.fromLTRB(3, 4, 3, 4),
//           decoration: BoxDecoration(
//               color: Colors.red, borderRadius: BorderRadius.circular(5)), //
//           child: Text(_globalFunction.formatTime(hour),
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold)),
//         ),
//         Text(' : ',
//             style: TextStyle(
//                 color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold)),
//         Container(
//           padding: EdgeInsets.fromLTRB(3, 4, 3, 4),
//           decoration: BoxDecoration(
//               color: Colors.red, borderRadius: BorderRadius.circular(5)), //
//           child: Text(_globalFunction.formatTime(minute),
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold)),
//         ),
//         Text(' : ',
//             style: TextStyle(
//                 color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold)),
//         Container(
//           padding: EdgeInsets.fromLTRB(3, 4, 3, 4),
//           decoration: BoxDecoration(
//               color: Colors.red, borderRadius: BorderRadius.circular(5)), //
//           child: Text(_globalFunction.formatTime(second),
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold)),
//         )
//       ],
//     );
//   }

//   Widget _createGridCategory() {
//     return BlocBuilder<CategoryBloc, CategoryState>(
//       builder: (context, state) {
//         if (state is CategoryError) {
//           return Container(
//               child: Center(
//                   child: Text(ERROR_OCCURED,
//                       style: TextStyle(fontSize: 14, color: BLACK_GREY))));
//         } else {
//           if (_lastDataCategory) {
//             return Wrap();
//           } else {
//             if (categoryData.length == 0) {
//               return _shimmerLoading.buildShimmerCategory();
//             } else {
//               return GridView.count(
//                 padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
//                 primary: false,
//                 childAspectRatio: 1.1,
//                 shrinkWrap: true,
//                 crossAxisSpacing: 0,
//                 mainAxisSpacing: 0,
//                 crossAxisCount: 4,
//                 children: List.generate(categoryData.length, (index) {
//                   return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ProductCategoryPage(
//                                     categoryId: categoryData[index].id,
//                                     categoryName: categoryData[index].name)));
//                       },
//                       child: Column(children: [
//                         buildCacheNetworkImage(
//                             width: 40,
//                             height: 40,
//                             url: categoryData[index].image,
//                             plColor: Colors.transparent),
//                         Flexible(
//                           child: Container(
//                             margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                             child: Text(
//                               categoryData[index].name,
//                               style: TextStyle(
//                                 color: CHARCOAL,
//                                 fontWeight: FontWeight.normal,
//                                 fontSize: 12,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         )
//                       ]));
//                 }),
//               );
//             }
//           }
//         }
//       },
//     );
//   }

//   Widget _buildLastBox(boxImageSize, StatefulWidget page) {
//     return Container(
//       width: boxImageSize + 10,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         elevation: 2,
//         color: Colors.white,
//         child: GestureDetector(
//           behavior: HitTestBehavior.translucent,
//           onTap: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => page));
//           },
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 width: 50,
//                 child: TextButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                         (Set<MaterialState> states) => PRIMARY_COLOR,
//                       ),
//                       overlayColor:
//                           MaterialStateProperty.all(Colors.transparent),
//                       shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(3.0),
//                       )),
//                     ),
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => page));
//                     },
//                     child: Text(
//                       AppLocalizations.of(context)!.translate('go')!,
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                       textAlign: TextAlign.center,
//                     )),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 AppLocalizations.of(context)!
//                     .translate('check_another_product')!,
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFlashsaleCard(index, boxImageSize) {
//     return Container(
//       width: boxImageSize + 10,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         elevation: 2,
//         color: Colors.white,
//         child: GestureDetector(
//           behavior: HitTestBehavior.translucent,
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => ProductDetailPage(
//                         name: flashsaleData[index].name,
//                         image: flashsaleData[index].image,
//                         price: flashsaleData[index].price,
//                         rating: 4,
//                         review: 45,
//                         sale: flashsaleData[index].sale)));
//           },
//           child: Column(
//             children: <Widget>[
//               Stack(
//                 children: [
//                   ClipRRect(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           topRight: Radius.circular(10)),
//                       child: buildCacheNetworkImage(
//                           width: boxImageSize + 10,
//                           height: boxImageSize + 10,
//                           url: flashsaleData[index].image)),
//                   Positioned(
//                     right: 0,
//                     top: 10,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(6),
//                               bottomLeft: Radius.circular(6))),
//                       padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
//                       child: Text(
//                           flashsaleData[index].discount.toString() + '%',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12)),
//                     ),
//                   )
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       flashsaleData[index].name,
//                       style: GlobalStyle.productName,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 5),
//                       child: Text(
//                           '\$ ' +
//                               _globalFunction.removeDecimalZeroFormat(
//                                   flashsaleData[index].price),
//                           style: GlobalStyle.productPriceDiscounted),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 2),
//                       child: Text(
//                           '\$ ' +
//                               _globalFunction.removeDecimalZeroFormat(
//                                   ((100 - flashsaleData[index].discount) *
//                                       flashsaleData[index].price /
//                                       100)),
//                           style: GlobalStyle.productPrice),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTrendingProductCard(index) {
//     return GestureDetector(
//       onTap: () {
//         StatefulWidget menuPage =
//             SearchProductPage(words: homeTrendingData[index].name);
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => menuPage));
//       },
//       child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           elevation: 2,
//           color: Colors.white,
//           child: Row(
//             children: [
//               ClipRRect(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       bottomLeft: Radius.circular(10)),
//                   child: buildCacheNetworkImage(
//                       width:
//                           (MediaQuery.of(context).size.width / 2) * (1.6 / 4) -
//                               12 -
//                               1,
//                       height:
//                           (MediaQuery.of(context).size.width / 2) * (1.6 / 4) -
//                               12 -
//                               1,
//                       url: homeTrendingData[index].image)),
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.all(10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(homeTrendingData[index].name,
//                           style: TextStyle(
//                               fontSize: 11, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 4),
//                       Text(
//                           homeTrendingData[index].sale +
//                               ' ' +
//                               AppLocalizations.of(context)!
//                                   .translate('product')!,
//                           style: TextStyle(fontSize: 9, color: BLACK_GREY))
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           )),
//     );
//   }

//   Widget _createCategoryForYou(
//       boxImageSize, categoryForYouHeightShort, categoryForYouHeightLong) {
//     return BlocBuilder<CategoryForYouBloc, CategoryForYouState>(
//       builder: (context, state) {
//         if (state is CategoryForYouError) {
//           return Container(
//               width: categoryForYouHeightShort * 3,
//               height: categoryForYouHeightLong,
//               child: Center(
//                   child: Text(ERROR_OCCURED,
//                       style: TextStyle(fontSize: 14, color: BLACK_GREY))));
//         } else {
//           if (_lastDataCategoryForYou) {
//             return Container(
//                 width: categoryForYouHeightShort * 3,
//                 height: categoryForYouHeightLong,
//                 child: Center(
//                     child: Text(
//                         AppLocalizations.of(context)!
//                             .translate('no_category_for_you')!,
//                         style: TextStyle(fontSize: 14, color: BLACK_GREY))));
//           } else {
//             if (categoryForYouData.length == 0) {
//               return _shimmerLoading.buildShimmerCategoryForYou(
//                   categoryForYouHeightShort * 3, categoryForYouHeightLong);
//             } else {
//               return Container(
//                 margin: EdgeInsets.only(top: 8),
//                 width: MediaQuery.of(context).size.width,
//                 height: categoryForYouHeightLong,
//                 child: Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ProductCategoryPage(
//                                     categoryId: categoryForYouData[0].id,
//                                     categoryName: categoryData[0].name)));
//                       },
//                       child: Container(
//                         width: boxImageSize,
//                         height: categoryForYouHeightLong,
//                         child: buildCacheNetworkImage(
//                             width: 0,
//                             height: 0,
//                             url: categoryForYouData[0].image),
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             ProductCategoryPage(
//                                                 categoryId:
//                                                     categoryForYouData[1].id,
//                                                 categoryName:
//                                                     categoryData[1].name)));
//                               },
//                               child: Container(
//                                 width: boxImageSize,
//                                 height: categoryForYouHeightShort,
//                                 child: buildCacheNetworkImage(
//                                     width: 0,
//                                     height: 0,
//                                     url: categoryForYouData[1].image),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             ProductCategoryPage(
//                                                 categoryId:
//                                                     categoryForYouData[2].id,
//                                                 categoryName:
//                                                     categoryData[2].name)));
//                               },
//                               child: Container(
//                                 width: boxImageSize,
//                                 height: categoryForYouHeightShort,
//                                 child: buildCacheNetworkImage(
//                                     width: 0,
//                                     height: 0,
//                                     url: categoryForYouData[2].image),
//                               ),
//                             )
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             ProductCategoryPage(
//                                                 categoryId:
//                                                     categoryForYouData[3].id,
//                                                 categoryName:
//                                                     categoryData[3].name)));
//                               },
//                               child: Container(
//                                 width: boxImageSize,
//                                 height: categoryForYouHeightShort,
//                                 child: buildCacheNetworkImage(
//                                     width: 0,
//                                     height: 0,
//                                     url: categoryForYouData[3].image),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             ProductCategoryPage(
//                                                 categoryId:
//                                                     categoryForYouData[4].id,
//                                                 categoryName:
//                                                     categoryData[4].name)));
//                               },
//                               child: Container(
//                                 width: boxImageSize,
//                                 height: categoryForYouHeightShort,
//                                 child: buildCacheNetworkImage(
//                                     width: 0,
//                                     height: 0,
//                                     url: categoryForYouData[4].image),
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               );
//             }
//           }
//         }
//       },
//     );
//   }
// }
