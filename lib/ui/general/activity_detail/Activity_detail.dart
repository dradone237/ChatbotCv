/*
This is product detail page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading

include file in model/general/related_product_model.dart to get wishlistData
include file in model/general/review_model.dart to get wishlistData

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/bloc/general/related_product/bloc.dart';
import 'package:ijshopflutter/bloc/general/review/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/model/activity/activity_model.dart';
import 'package:ijshopflutter/model/general/related_product_model.dart';
import 'package:ijshopflutter/model/general/review_model.dart';
import 'package:ijshopflutter/ui/general/chat_us.dart';
import 'package:ijshopflutter/ui/general/product_detail/delivery_estimated.dart';
import 'package:ijshopflutter/ui/general/product_detail/product_description.dart';
import 'package:ijshopflutter/ui/general/notification.dart';
import 'package:ijshopflutter/ui/general/product_detail/product_review.dart';
import 'package:ijshopflutter/ui/home/category/product_category.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/home/search/search.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';
import 'package:ijshopflutter/ui/shopping_cart/shopping_cart.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ActivityDetailPage extends StatefulWidget {
  final String title;
  final String image;
  final double price;
  final double rating;
  final int review;
  final String service;
  ActivityModel? activity;

  ActivityDetailPage({
    Key? key,
    this.activity,
    this.title = 'text',
    this.image = '',
    this.price = 24,
    this.rating = 4,
    this.review = 45,
    this.service = "1",
  }) : super(key: key);

  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List<RelatedProductModel> relatedProductData = [];
  List<ReviewModel> reviewData = [];

  late RelatedProductBloc _relatedProductBloc;
  bool _lastDataRelated = false;

  late ReviewBloc _reviewBloc;
  bool _lastDataReview = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  final List<String> _imgProductSlider = [];
  int _currentImageSlider = 0;

  // size data
  List<String> _sizeList = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  int _sizeIndex = 0;

  // color data
  List<String> _colorList = [];
  int _colorIndex = 0;

  // wishlist
  bool _isLove = false;

  // shopping cart count
  int _shoppingCartCount = 3;

  @override
  void initState() {
    // get data when initState
    _relatedProductBloc = BlocProvider.of<RelatedProductBloc>(context);
    _relatedProductBloc
        .add(GetRelatedProduct(sessionId: SESSION_ID, apiToken: apiToken));

    _reviewBloc = BlocProvider.of<ReviewBloc>(context);
    _reviewBloc.add(GetReviewProduct(
        sessionId: SESSION_ID, skip: '0', limit: '3', apiToken: apiToken));

    // image slider for the product
    _imgProductSlider.add(widget.image);
    _imgProductSlider.add(widget.image);
    _imgProductSlider.add(widget.image);
    _imgProductSlider.add(widget.image);
    _imgProductSlider.add(widget.image);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initForLang();
    });

    super.initState();
  }

  void _initForLang() {
    setState(() {
      _colorList = [
        AppLocalizations.of(context)!.translate('red')!,
        AppLocalizations.of(context)!.translate('black')!,
        AppLocalizations.of(context)!.translate('green')!,
        AppLocalizations.of(context)!.translate('white')!,
        AppLocalizations.of(context)!.translate('blue')!,
        AppLocalizations.of(context)!.translate('yellow')!,
        AppLocalizations.of(context)!.translate('pink')!
      ];
    });
  }

  @override
  void dispose() {
    apiToken.cancel("cancelled"); // cancel fetch data from API
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          titleSpacing: 0.0,
          // create search text field in the app bar
          title: Container(
            margin: EdgeInsets.only(right: 16),
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) => Colors.grey[100]!,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Icon(Icons.search, color: Colors.grey[500], size: 18),
                    SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!
                          .translate('search_activity')!,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal),
                    )
                  ],
                )),
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          actions: [
            IconButton(
                padding: EdgeInsets.all(0),
                constraints: BoxConstraints(),
                icon: _customShoppingCart(_shoppingCartCount),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShoppingCartPage()));
                }),
            IconButton(
                icon: _globalWidget.customNotifIcon(8, BLACK_GREY),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                }),
          ],
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(true);
          },
          child: MultiBlocListener(
            listeners: [
              BlocListener<RelatedProductBloc, RelatedProductState>(
                  listener: (context, state) {
                //print('state atas : '+state.toString());
                if (state is RelatedProductError) {
                  _globalFunction.showToast(
                      type: 'error', message: state.errorMessage);
                }
                if (state is GetRelatedProductSuccess) {
                  relatedProductData.addAll(state.relatedProductData);
                }
              }),
              BlocListener<ReviewBloc, ReviewState>(
                listener: (context, state) {
                  if (state is ReviewProductError) {
                    _globalFunction.showToast(
                        type: 'error', message: state.errorMessage);
                  }
                  if (state is GetReviewProductSuccess) {
                    if (state.reviewData.length == 0) {
                      _lastDataReview = true;
                    } else {
                      reviewData.addAll(state.reviewData);
                    }
                  }
                },
              ),
            ],
            child: Column(
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      _createProductSlider(),
                      _createProductPriceTitleEtc(),
                      // _createProductVariant(),
                      _createDeliveryEstimated(),
                      _createProductInformation(),
                      _progressIndicator(context),
                      _createActivityDescription(),
                      _createProductRelated(boxImageSize),
                      // _createProductReview(),
                      SizedBox(height: 16)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatUsPage()));
                          },
                          child: ClipOval(
                            child: Container(
                                color: SOFT_BLUE,
                                padding: EdgeInsets.all(9),
                                child: Icon(Icons.chat,
                                    color: Colors.white, size: 16)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _shoppingCartCount++;
                            });
                            Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!
                                    .translate('added_to_cart')!,
                                toastLength: Toast.LENGTH_LONG);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 1, color: SOFT_BLUE),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        10) //         <--- border radius here
                                    )),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .translate('add_to_cart')!,
                                style: TextStyle(
                                    color: SOFT_BLUE,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _customShoppingCart(int count) {
    return Stack(
      children: <Widget>[
        Icon(Icons.shopping_cart, color: BLACK_GREY),
        Positioned(
          right: 0,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: ASSENT_COLOR,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: BoxConstraints(
              minWidth: 14,
              minHeight: 14,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _createProductSlider() {
    return Stack(
      children: [
        CarouselSlider(
          items: _imgProductSlider
              .map((item) => Container(
                    child:
                        buildCacheNetworkImage(width: 0, height: 0, url: item),
                  ))
              .toList(),
          options: CarouselOptions(
              aspectRatio: 1,
              viewportFraction: 1.0,
              autoPlay: false,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageSlider = index;
                });
              }),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            decoration: BoxDecoration(
                color: SOFT_BLUE, borderRadius: BorderRadius.circular(4)),
            child: Text(
                (_currentImageSlider + 1).toString() +
                    '/' +
                    _imgProductSlider.length.toString(),
                style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ),
      ],
    );
  }

  Widget _createProductPriceTitleEtc() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text('\$'+_globalFunction.removeDecimalZeroFormat(widget.price), style: GlobalStyle.detailProductPrice),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isLove == true) {
                      _isLove = false;
                      Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!
                              .translate('item_deleted_activity')!,
                          toastLength: Toast.LENGTH_LONG);
                    } else {
                      Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!
                              .translate('item_added_activity')!,
                          toastLength: Toast.LENGTH_LONG);
                      _isLove = true;
                    }
                  });
                },
                child: Icon(Icons.favorite,
                    color: _isLove == true ? ASSENT_COLOR : BLACK_GREY,
                    size: 28),
              )
            ],
          ),
          SizedBox(height: 12),
          Text(widget.title,
              style: TextStyle(
                fontSize: 14,
              )),
          SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductReviewPage()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[700], size: 18),
                      SizedBox(
                        width: 3,
                      ),
                      Text(widget.rating.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(
                        width: 3,
                      ),
                      Text('(' + widget.review.toString() + ')',
                          style: TextStyle(fontSize: 13, color: BLACK_GREY)),
                    ],
                  ),
                ),
                VerticalDivider(
                  width: 30,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                Text(
                    widget.service.toString() +
                        ' ' +
                        AppLocalizations.of(context)!.translate('action')!,
                    style: TextStyle(fontSize: 13, color: BLACK_GREY)),
                VerticalDivider(
                  width: 30,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                // Icon(Icons.location_on, color: SOFT_GREY, size: 16),
                Text('Brooklyn',
                    style: TextStyle(fontSize: 13, color: SOFT_GREY))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget radioSize(String txt, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sizeIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: EdgeInsets.only(right: 8, top: 8),
        decoration: BoxDecoration(
            color: _sizeIndex == index ? SOFT_BLUE : Colors.white,
            border: Border.all(
                width: 1,
                color: _sizeIndex == index ? SOFT_BLUE : Colors.grey[300]!),
            borderRadius: BorderRadius.all(
                Radius.circular(10) //         <--- border radius here
                )),
        child: Text(txt,
            style: TextStyle(
                color: _sizeIndex == index ? Colors.white : CHARCOAL)),
      ),
    );
  }

  Widget radioColor(String txt, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _colorIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: EdgeInsets.only(right: 8, top: 8),
        decoration: BoxDecoration(
            color: _colorIndex == index ? SOFT_BLUE : Colors.white,
            border: Border.all(
                width: 1,
                color: _colorIndex == index ? SOFT_BLUE : Colors.grey[300]!),
            borderRadius: BorderRadius.all(
                Radius.circular(10) //         <--- border radius here
                )),
        child: Text(txt,
            style: TextStyle(
                color: _colorIndex == index ? Colors.white : CHARCOAL)),
      ),
    );
  }

  Widget _createDeliveryEstimated() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DeliveryEstimatedPage()));
      },
      child: Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.translate('delivery')!,
                        style: GlobalStyle.sectionTitle),
                    SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: new TextStyle(
                          fontSize: 15.5,
                          color: BLACK_GREY,
                        ),
                        children: <TextSpan>[
                          new TextSpan(
                              text: AppLocalizations.of(context)!
                                  .translate('calculated_message')!),
                          new TextSpan(
                              text: 'West New York, NJ',
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 36, color: CHARCOAL)
            ],
          )),
    );
  }

  Widget _createProductInformation() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.translate('information')!,
                style: GlobalStyle.sectionTitle),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate('weight')!,
                    style: TextStyle(color: BLACK_GREY)),
                Text('300 ' + AppLocalizations.of(context)!.translate('gram')!,
                    style: TextStyle(color: BLACK_GREY))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate('condition')!,
                    style: TextStyle(color: BLACK_GREY)),
                Text(AppLocalizations.of(context)!.translate('second')!,
                    style: TextStyle(color: BLACK_GREY))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate('category')!,
                    style: TextStyle(color: BLACK_GREY)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryPage(
                                  categoryId: 3,
                                  categoryName: AppLocalizations.of(context)!
                                      .translate('electronic')!,
                                )));
                  },
                  child: Text(
                      AppLocalizations.of(context)!.translate('electronic')!,
                      style: TextStyle(color: SOFT_BLUE)),
                )
              ],
            ),
          ],
        ));
  }

  Widget _progressIndicator(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppLocalizations.of(context)!.translate('Progression')!,
              style: GlobalStyle.sectionTitle),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 20.0,

              animationDuration: 2500,
              percent: 0.8,
              center: Text("80.0%"),
              // linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createActivityDescription() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.translate('description')!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 16,
            ),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\nQuisque tortor tortor, ultrices id scelerisque a, elementum id elit. Maecenas feugiat tellus sed augue malesuada, id tempus ex sodales.'),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDescriptionPage(
                            name: widget.title, image: widget.image)));
              },
              child: Center(
                child: Text(
                    AppLocalizations.of(context)!.translate('read_more')!,
                    style: TextStyle(color: SOFT_BLUE)),
              ),
            ),
          ],
        ));
  }

  Widget _createProductRelated(boxImageSize) {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.only(bottom: 16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: Text(
                  AppLocalizations.of(context)!.translate('related_product')!,
                  style: GlobalStyle.sectionTitle),
            ),
            Container(
              height: boxImageSize *
                  GlobalStyle.horizontalProductHeightMultiplication,
              child: BlocBuilder<RelatedProductBloc, RelatedProductState>(
                builder: (context, state) {
                  //print('state bawah : '+state.toString());
                  if (state is RelatedProductError) {
                    return Container(
                        child: Center(
                            child: Text(ERROR_OCCURED,
                                style: TextStyle(
                                    fontSize: 14, color: BLACK_GREY))));
                  } else {
                    if (_lastDataRelated) {
                      return Container(
                          child: Center(
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .translate('no_related_product')!,
                                  style: TextStyle(
                                      fontSize: 14, color: BLACK_GREY))));
                    } else {
                      if (relatedProductData.length == 0) {
                        return _shimmerLoading
                            .buildShimmerRelatedProduct(boxImageSize + 10);
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          scrollDirection: Axis.horizontal,
                          itemCount: relatedProductData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _globalWidget.buildHorizontalProductCard(
                                context, relatedProductData[index]);
                          },
                        );
                      }
                    }
                  }
                },
              ),
            ),
          ],
        ));
  }

  // Widget _createProductReview(){
  //   return Container(
  //       margin: EdgeInsets.only(top: 12),
  //       padding: EdgeInsets.all(16),
  //       color: Colors.white,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(AppLocalizations.of(context)!.translate('review')!, style: GlobalStyle.sectionTitle),
  //               GestureDetector(
  //                 onTap: (){
  //                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProductReviewPage()));
  //                 },
  //                 child: Text(AppLocalizations.of(context)!.translate('view_all')!, style: GlobalStyle.viewAll.copyWith(color: SOFT_BLUE), textAlign: TextAlign.end),
  //               )
  //             ],
  //           ),
  //           SizedBox(
  //             height: 8,
  //           ),
  //           Row(
  //             children: [
  //               _globalWidget.createRatingBar(widget.rating),
  //               Text('('+widget.review.toString()+')', style: TextStyle(fontSize: 11, color: SOFT_GREY))
  //             ],
  //           ),
  //           BlocBuilder<ReviewBloc, ReviewState>(
  //             builder: (context, state) {
  //               if(state is ReviewProductError) {
  //                 return Container(
  //                     child: Center(
  //                         child: Text(ERROR_OCCURED, style: TextStyle(
  //                             fontSize: 14,
  //                             color: BLACK_GREY
  //                         ))
  //                     )
  //                 );
  //               } else {
  //                 if(_lastDataReview){
  //                   return Container(
  //                       child: Center(
  //                           child: Text(AppLocalizations.of(context)!.translate('no_review')!, style: TextStyle(
  //                               fontSize: 14,
  //                               color: BLACK_GREY
  //                           ))
  //                       )
  //                   );
  //                 } else {
  //                   if(reviewData.length==0){
  //                     return _shimmerLoading.buildShimmerReviewProduct();
  //                   } else {
  //                     return Column(
  //                         children: List.generate(reviewData.length, (index) {
  //                           return Column(
  //                             children: [
  //                               Divider(
  //                                 height: 32,
  //                                 color: Colors.grey[400],
  //                               ),
  //                               Container(
  //                                   child: Column(
  //                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text(reviewData[index].date, style: TextStyle(fontSize: 13, color: SOFT_GREY)),
  //                                       SizedBox(height: 4),
  //                                       Row(
  //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                         children: [
  //                                           Text(reviewData[index].name, style: TextStyle(
  //                                               fontSize: 14, fontWeight: FontWeight.bold
  //                                           )),
  //                                           _globalWidget.createRatingBar(reviewData[index].rating),
  //                                         ],
  //                                       ),
  //                                       SizedBox(height: 4),
  //                                       Text(reviewData[index].review)
  //                                     ],
  //                                   )
  //                               )
  //                             ],
  //                           );
  //                         })
  //                     );
  //                   }
  //                 }
  //               }
  //             },
  //           ),
  //         ],
  //       )
  //   );
  // }
}
