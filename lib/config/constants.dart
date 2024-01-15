/*
this is constant pages
 */
// ce fichier contient les constantes qui sont utilise dans l'application et sont définies en tant que variables de portée globale et sont utilisées pour éviter de répéter du code ou des valeurs dans l'ensemble de l'application, Ces constantes comprennent des couleurs, des messages d'erreur, des URL d'API, des codes de statut HTTP et des informations de session.
import 'package:flutter/material.dart';

const String APP_NAME = 'ROSHUB';

// color for apps
const Color PRIMARY_COLOR = Color.fromARGB(255, 143, 3, 185);
const Color ASSENT_COLOR = Color(0xFFe75f3f);

const Color CHARCOAL = Color(0xFF515151);
const Color BLACK_GREY = Color(0xff777777);
const Color SOFT_GREY = Color(0xFFaaaaaa);
const Color SOFT_BLUE = Color.fromARGB(255, 116, 237, 253);

const int STATUS_OK = 200;
const int STATUS_BAD_REQUEST = 400;
const int STATUS_NOT_AUTHORIZED = 403;
const int STATUS_NOT_FOUND = 404;
const int STATUS_INTERNAL_ERROR = 500;

const String ERROR_OCCURED = 'Error occured, please try again later';

const String SESSION_ID = '5f0e6bfbafe255.00218389';
const int LIMIT_PAGE = 8;

const String GLOBAL_URL = 'https://ijtechnology.net/assets/images/api/ijshop';
//const String GLOBAL_URL = 'http://192.168.0.4/ijshop';

const String SERVER_URL = 'https://ijtechnology.net/api_ijshop/';
// pour l'application roshub
// declaration de notre constante BASE_URL qui contient l'URL de base de notre API et va nous permettre d'effectuer les apples a notre API , en ajoutant des extensions d'URL spécifiques pour les différentes actions de l'API explemle d'URL specifique : pour le login:"public/user/login",pour le sign up:public/user/sign-up
// connecxion avec l'api pour le login de l'utilisateur cette nouvelle constante est appel BASE_URL
const String BASE_URL = 'https://api.amphimill.com/api/v1/'; // login
const String COMPTE_URL = 'https://api.amphimill.com/api/v1/'; // signup

// pour l'application de Chat
const String DADA_URL = 'http://192.168.201.96:3000'; //
const String DORA_URL = 'http://192.168.201.96:3000'; //

//const String SERVER_URL = 'http://192.168.0.4/ijshop/api/';

const String DADO_URL = 'http:// 192.168.201.96:3000';

const String ADDRESS_API = SERVER_URL + "account/getAddress";
const String LAST_SEEN_PRODUCT_API = SERVER_URL + "account/getLastSeen";
const String ORDER_LIST_API = SERVER_URL + "account/getOrderList";
const String RELATED_PRODUCT_API = SERVER_URL + "general/getRelatedProduct";
const String REVIEW_API = SERVER_URL + "general/getReview";
const String CATEGORY_API = SERVER_URL + "home/category/getCategory";
const String CATEGORY_All_PRODUCT_API =
    SERVER_URL + "home/category/getCategoryAllProduct";
const String CATEGORY_BANNER_API =
    SERVER_URL + "home/category/getCategoryBanner";
const String CATEGORY_FOR_YOU_API =
    SERVER_URL + "home/category/getCategoryForYou";
const String CATEGORY_TRENDING_PRODUCT_API =
    SERVER_URL + "home/category/getCategoryTrendingProduct";
const String CATEGORY_NEW_PRODUCT_API =
    SERVER_URL + "home/category/getCategoryNewProduct";
const String SEARCH_API = SERVER_URL + "home/search/getSearch";
const String SEARCH_PRODUCT_API = SERVER_URL + "home/search/getSearchProduct";
const String COUPON_API = SERVER_URL + "home/getCoupon";
const String COUPON_DETAIL_API = SERVER_URL + "home/getCouponDetail";
const String FLASHSALE_API = SERVER_URL + "home/getFlashsale";
const String HOME_BANNER_API = SERVER_URL + "home/getHomeBanner";
const String HOME_TRENDING_API = SERVER_URL + "home/getHomeTrending";
const String LAST_SEARCH_API = SERVER_URL + "home/getLastSearch";
const String LAST_SEARCH_INFINITE_API =
    SERVER_URL + "home/getLastSearchInfinite";
const String RECOMENDED_PRODUCT_API = SERVER_URL + "home/getRecomendedProduct";
const String SHOPPING_CART_API = SERVER_URL + "shopping_cart/getShoppingCart";
const String WISHLIST_API = SERVER_URL + "wishlist/getWishlist";

//ROSHUB Ressource pour le login et le sign up
// const String LOGIN_API = BASE_URL +
//     "public/user/login";  qui est le lien de l'API vers la ressource login en ligne

// const String SIGNUP_API = BASE_URL +
//     "public/user/sign-up";  qui est le lien de l'API vers la ressource signup en ligne

const String ACTIVITY_API = BASE_URL + "requests";

// pour l'application de chat
// le lien vers L"API vers le backend en local
const String LOGIN_API = DADA_URL + "/login";
// le lien vers l"API vers le backend en local
const String SIGNUP_API = DADA_URL + "/inscription";
