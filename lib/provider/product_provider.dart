import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product.dart';
import 'package:food_app/models/review.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/config.dart';
import '../const/image_base64.dart';
import '../services/snackbar.dart';
import 'address/address_provider.dart';
import 'cart_provider.dart';
import 'favourite_provider.dart';

class ProductProvider with ChangeNotifier {
  GlobalSnackBar snackBar = GlobalSnackBar();
  bool _data = true;
  bool get data {
    // boolData();
    return _data;
  }

  bool _homeScreenLoading = false;

  bool get homeScreenLoading {
    return _homeScreenLoading;
  }

  void boolDataFalse() async {
    _data = false;
  }

  void boolDataTrue() {
    _data = true;
  }

  // Future<void> boolData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('pages', true);
  //   _data = prefs.getBool('pages');
  //   notifyListeners();
  // }

  List<Product> _product = [
    // Product(
    //     productId: 'a',
    //     colories: '78',
    //     categories: 'Fast Food',
    //     subtitle: 'Chicken Hamburger',
    //     title: 'Hamburger',
    //     description:
    //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
    //     rating: 3.8,
    //     timer: 20,
    //     quantity: 1,
    //     imageUrl: [
    //       'https://barbecuebible.com/wp-content/uploads/2013/05/featured-great-american-hamburger.jpg',
    //       'https://barbecuebible.com/wp-content/uploads/2013/05/featured-great-american-hamburger.jpg',
    //     ],
    //     price: 140,
    //     review: [
    //       Review(
    //           id: 'q',
    //           profile: 'sushalt',
    //           reviewTitle: 'some most command',
    //           start: '3')
    //     ]),
    // Product(
    //     productId: 'b',
    //     colories: '78',
    //     categories: 'Spicy Food',
    //     subtitle: 'Extra spicy',
    //     title: 'Spicy',
    //     description:
    //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
    //     rating: 3.5,
    //     quantity: 1,
    //     timer: 40,
    //     imageUrl: [
    //       'https://th.bing.com/th/id/OIP.YNCdxOuZSnO4Lk6FtWhEpQHaE7?pid=ImgDet&rs=1',
    //       'https://th.bing.com/th/id/OIP.YNCdxOuZSnO4Lk6FtWhEpQHaE7?pid=ImgDet&rs=1',
    //     ],
    //     price: 230,
    //     review: [
    //       Review(
    //           id: 'q',
    //           profile: 'sushalt',
    //           reviewTitle: 'some most command',
    //           start: '3')
    //     ]),
    // Product(
    //     productId: 'c',
    //     colories: '78',
    //     categories: 'Sea Food',
    //     subtitle: 'Tasty Sea food',
    //     title: 'Fish Fry',
    //     description:
    //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
    //     rating: 2.9,
    //     quantity: 1,
    //     timer: 50,
    //     imageUrl: [
    //       'https://patch.com/img/cdn20/users/20883540/20180823/043051/styles/raw/public/processed_images/ccb-1535056233-8118.jpg',
    //       'https://patch.com/img/cdn20/users/20883540/20180823/043051/styles/raw/public/processed_images/ccb-1535056233-8118.jpg',
    //     ],
    //     price: 370,
    //     review: [
    //       Review(
    //           id: 'q',
    //           profile: 'sushalt',
    //           reviewTitle: 'some most command',
    //           start: '3')
    //     ]),
    // Product(
    //     productId: 'd',
    //     colories: '56',
    //     categories: 'Meat and poultry',
    //     subtitle: 'Meat pizza',
    //     title: 'Meat',
    //     description:
    //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
    //     rating: 4.3,
    //     quantity: 1,
    //     timer: 60,
    //     // imageUrl: [
    //     //   'https://images.hindustantimes.com/rf/image_size_960x540/HT/p2/2019/06/05/Pictures/_3062edc4-879d-11e9-ab40-33c30d629efb.jpg',
    //     //   'https://images.hindustantimes.com/rf/image_size_960x540/HT/p2/2019/06/05/Pictures/_3062edc4-879d-11e9-ab40-33c30d629efb.jpg',
    //     // ],
    //     price: 400,
    //     review: [
    //       Review(
    //           id: 'q',
    //           profile: 'sushalt',
    //           reviewTitle: 'some most command',
    //           start: '3')
    //     ]),
    // Product(
    //     productId: 'e',
    //     colories: '55',
    //     categories: 'Drinks',
    //     subtitle: 'Happy drinks',
    //     title: 'Mocktails',
    //     description:
    //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
    //     rating: 5.0,
    //     quantity: 1,
    //     timer: 20,
    //     imageUrl: [
    //       'https://www.visitlichfield.co.uk/sites/default/files/images/Mocktails.JPG',
    //       'https://www.visitlichfield.co.uk/sites/default/files/images/Mocktails.JPG',
    //     ],
    //     price: 140,
    //     review: [
    //       Review(
    //           id: 'q',
    //           profile: 'sushalt',
    //           reviewTitle: 'some most command',
    //           start: '3')
    //     ]),
    // Product(
    //     productId: 'f',
    //     colories: '89',
    //     categories: 'Fast Food',
    //     subtitle: 'Fasy Food',
    //     title: 'Fast Food',
    //     description:
    //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
    //     rating: 4.3,
    //     quantity: 2,
    //     timer: 30,
    //     imageUrl: [
    //       'https://img.gentside.co.uk/s3/ukgts/1280/health/default_2020-02-27_2efa0f99-42f0-4917-90fb-053d64b862a9.jpeg',
    //       'https://img.gentside.co.uk/s3/ukgts/1280/health/default_2020-02-27_2efa0f99-42f0-4917-90fb-053d64b862a9.jpeg',
    //     ],
    //     price: 140,
    //     review: [
    //       Review(
    //           id: 'q',
    //           profile: 'sushalt',
    //           reviewTitle: 'some most command',
    //           start: '3')
    //     ]),
    // Product(
    //     productId: 'g',
    //     colories: '65',
    //     categories: 'Spicy Food',
    //     subtitle: 'Spicy Tasty Food',
    //     title: 'Hamburger',
    //     description:
    //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
    //     rating: 4.7,
    //     quantity: 1,
    //     timer: 40,
    //     imageUrl: [
    //       'https://th.bing.com/th/id/OIP.yEpJmEvGcbsnkYyjF5SmwAHaFU?pid=ImgDet&rs=1',
    //       'https://th.bing.com/th/id/OIP.yEpJmEvGcbsnkYyjF5SmwAHaFU?pid=ImgDet&rs=1',
    //     ],
    //     price: 370,
    //     review: [
    //       Review(
    //           id: 'q',
    //           profile: 'sushalt',
    //           reviewTitle: 'some most command',
    //           start: '3')
    //     ]),
    // Product(
    //     productId: 'h',
    //     colories: '56',
    //     categories: 'Sea Food',
    //     subtitle: 'Happy lunch',
    //     title: 'Sea Food',
    //     description:
    //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
    //     rating: 2.3,
    //     quantity: 1,
    //     timer: 20,
    //     imageUrl: [
    //       'https://6head.com.au/wp-content/uploads/2018/12/domcherry-2820.jpg',
    //       'https://6head.com.au/wp-content/uploads/2018/12/domcherry-2820.jpg',
    //     ],
    //     price: 170,
    //     review: [
    //       Review(
    //           id: 'q',
    //           profile: 'sushalt',
    //           reviewTitle: 'some most command',
    //           start: '3')
    //     ]),
    // Product(
    //     productId: 'i',
    //     colories: '70',
    //     categories: 'Meat and poultry',
    //     subtitle: 'Meat with burger',
    //     title: 'Meat',
    //     description:
    //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
    //     rating: 3.3,
    //     quantity: 1,
    //     timer: 60,
    //     imageUrl: [
    //       'https://s-i.huffpost.com/gen/1309014/images/o-RED-MEAT-facebook.jpg',
    //       'https://s-i.huffpost.com/gen/1309014/images/o-RED-MEAT-facebook.jpg',
    //     ],
    //     price: 190,
    //     review: [
    //       Review(
    //           id: 'q',
    //           profile: 'sushalt',
    //           reviewTitle: 'some most command',
    //           start: '3')
    //     ]),
    // Product(
    //     productId: 'j',
    //     colories: '75',
    //     categories: 'Drinks',
    //     subtitle: 'Drinks',
    //     title: 'Drinks',
    //     description:
    //         'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
    //     rating: 4.3,
    //     quantity: 1,
    //     timer: 20,
    //     imageUrl: [
    //       'https://th.bing.com/th/id/OIP.eWEiLdq83Odm9eSgqazg7AHaHa?pid=ImgDet&rs=1',
    //       'https://th.bing.com/th/id/OIP.eWEiLdq83Odm9eSgqazg7AHaHa?pid=ImgDet&rs=1',
    //       'https://th.bing.com/th/id/OIP.eWEiLdq83Odm9eSgqazg7AHaHa?pid=ImgDet&rs=1',
    //     ],
    //     price: 240,
    //     review: [
    //       Review(
    //           id: 'q',
    //           profile: 'sushalt',
    //           reviewTitle: 'some most command',
    //           start: '3')
    //     ]),
  ];

  List<Product> get product {
    return [..._product];
  }

  bool _loadingSpinner = false;

  bool get loadingSpinner {
    return _loadingSpinner;
  }

  Future<void> valuePart({BuildContext context}) async {
    try {
      _homeScreenLoading = true;
      final data = Provider.of<ProductProvider>(context, listen: false);
      print('hekllo hello hello');
      final prefs = await SharedPreferences.getInstance();
      print(data.data.toString() + ' confirmation');
      if (data.data == true) {
        print('count');
        Provider.of<ProductProvider>(context, listen: false).boolDataFalse();
        await Provider.of<AddressProvider>(context, listen: false)
            .getAddressData(context)
            .then((value) async {
          await Provider.of<FavouriteProvider>(context, listen: false)
              .getFavouriteProductId(context: context)
              .then((value) async {
            await Provider.of<CartProvider>(context, listen: false)
                .cartProductId(
              context: context,
            )
                .then((value) async {
              await Provider.of<ProductProvider>(context, listen: false)
                  .getProductData(context)
                  .then((value) {
                _homeScreenLoading = false;
                notifyListeners();
                // Timer.periodic(Duration(seconds: 3), (timer) {
                //   setState(() {
                //     isLoadings = false;
                //     print(isLoadings.toString() +
                //         ' timer All data is loading -- >>');
                //   });
                // });
              });
            });
          });
        });
      } else if (data.data == false) {
        print('false false false');
        _homeScreenLoading = false;
        notifyListeners();
      }
      // setState(() {
      //   isLoadings = false;
      // });
    } catch (e) {
      _homeScreenLoading = false;
      notifyListeners();
    }
  }

  Future<void> getProductData(BuildContext context) async {
    print('product api start -- 1');
    try {
      _loadingSpinner = true;
      notifyListeners();
      List<Product> _loadedProduct = [];
      print('product api start -- 2');
      var headers = {
        'Content-Type': 'application/json',
      };
      print('product api start -- 3');
      var body = json.encode({
        "clientid": client_id,
        "type": "products",
        "fields":
            "{'active','id','categ_id','image_1024','list_price','description','display_name','pricelist_id','product_variant_id','product_variant_ids'}"
      });
      print('fields is loading--->');
      print(body);

      var response = await http.post(
          Uri.parse('http://eiuat.seedors.com:8290/get-all-details'),
          headers: headers,
          body: body);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        for (var i = 0; i < extractedData.length; i++) {
          print(extractedData[i]['display_name']);
          double price = extractedData[i]['list_price'];
          print('bool 1 is loading --->');

          final base64 = extractedData[i]['image_1024'].toString() == 'false'
              ? customBase64
              : extractedData[i]['image_1024'].toString();
          var image = base64Decode(base64);
          print('bool 2 is loading--->');
          print('bool 3 is loading--->');

          _loadedProduct.add(Product(
              categories: extractedData[i]['categ_id'][0].toString(),
              colories: '40',
              description: extractedData[i]['list_price'].toString(),
              imageUrl: image,
              price: price.toInt(),
              productId: extractedData[i]['id'].toString(),
              quantity: 1,
              rating: 3,
              review: [],
              subtitle: extractedData[i]['categ_id'][1],
              timer: 40,
              varient: extractedData[i]['product_variant_id'][0],
              title: extractedData[i]['display_name'].toString()));
        }
        _product = _loadedProduct;
        _loadingSpinner = false;
        print('loading completed -->>');
        notifyListeners();
      } else {
        snackBar.generalSnackbar(
            context: context, text: 'Something went wrong');
        _loadingSpinner = false;
        notifyListeners();
      }

      // _categories.map((data) {
      //   return Categories.fromMap(data);
      // }).toList();
      _loadingSpinner = false;

      notifyListeners();
    } on HttpException catch (e) {
      print('error in category prod -->>' + e.toString());
      _loadingSpinner = false;
      notifyListeners();
      snackBar.generalSnackbar(context: context, text: 'Something went wrong');
    }
  }

  List<Product> categoryProduct(String categoryName) {
    final category = product.where((element) =>
        element.categories.toLowerCase().contains(categoryName.toLowerCase()));
    return category.toList();
  }

  Product findById(String id) {
    return product.firstWhere((element) => element.productId == id);
  }

  double minPrice = 100;
  double maxPrice = 300;

  Product filterProduct(
      {@required int startingPrice, @required int endingPrice}) {
    List<Product> _filter = [];
    final filter = product.where((element) {
      return (element.price > minPrice && element.price < maxPrice);
    }).toList();
    for (var i = 0; i < _filter.length; i++) {
      _filter.add(filter[i]);
    }

    print(filter.toList().length.toString() + 'length of list in filter');
    print(filter.toList().length.toString() + 'length of set in filter');
  }

  List<Product> searchQuery(String text) {
    var searchList = _product
        .where((element) =>
            element.title.toLowerCase().contains(text.toLowerCase()))
        .toList();

    return searchList;
  }
}
