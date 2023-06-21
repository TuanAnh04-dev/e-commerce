// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce/Authenticaiton/Model/Product.dart';
import 'package:e_commerce/Authenticaiton/fetchCategory.dart';
import 'package:e_commerce/Home/CartPage.dart';
import 'package:e_commerce/Home/ProductDetail.dart';
import 'package:e_commerce/Provider/CartProvider.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:e_commerce/Util/userAuth.dart' as global;
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../Authenticaiton/fetchProduct.dart';

class HomePage_Route extends StatelessWidget {
  const HomePage_Route({super.key});

  // const HomePage_Route({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage_Route());
  }

  @override
  Widget build(BuildContext context) {
    return const Homepage();
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

Future? _getCates;
Future? _getProduct;

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  @override
  void initState() {
    final _getCates = fetchCategoryPro();
    final _getProduct = fetchProduct();
    _initPackageInfo();

    //set up provider
    WidgetsBinding.instance.addObserver(this);
    // Create instance of DI
    getIt.isReady<CartProvider>().then((_) => getIt<CartProvider>().addListener(update));
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    getIt<CartProvider>().removeListener(update);
    super.dispose();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  List<bool> _selected = [false];

  void update() => setState(() {});
  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var userAuth = global.userAuth;
    var curencyFormat = NumberFormat.currency(locale: 'en_US', symbol: "\$");
    List<Products> listPro = getIt<CartProvider>().getListProInCart;
    int quantity = listPro.length;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // app bar
              Container(
                padding: EdgeInsets.only(top: 10),
                // color: Colors.amber,
                height: heightScreen * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Icon(
                            Icons.person,
                            size: 40,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hey,  ' + userAuth.name.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              userAuth.email.toString(),
                              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.search,
                          size: 40,
                        ),
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 15, right: 10),
                              child: InkWell(
                                onTap: () => Get.to(Cart()),
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 40,
                                ),
                              ),
                            ),
                            // if (quantity != 0)
                            Positioned(
                              top: 5,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.all(2.5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: ChangeNotifierProvider<CartProvider>(
                                  create: (_) => CartProvider(),
                                  builder: (context, child) {
                                    List<Products> lst = context.watch<CartProvider>().getListProInCart;
                                    var num = lst.length;

                                    return Text(
                                      getIt.get<CartProvider>().getQuantity.toString(),
                                      style: TextStyle(color: Colors.white),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              //banner quảng cáo
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: SizedBox(
                  // padding: EdgeInsets.only(left: 10.0),
                  height: heightScreen * 0.18,
                  width: widthScreen,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: widthScreen * 0.9,
                          height: heightScreen * 0.1,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.yellowAccent,
                          ),
                          child: const Center(child: Text('Hello World')),
                        ),
                      );
                    },
                  ),
                ),
              ),
              //category
              Padding(
                padding: EdgeInsets.all(5.0),
                child: SizedBox(
                    height: heightScreen * 0.1,
                    width: widthScreen,
                    child: FutureBuilder(
                        future: fetchCategoryPro(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            // print(snapshot.error);
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          }
                          if (snapshot.hasData) {
                            List<dynamic> data = snapshot.data;
                            List<bool> sle = data.map((e) => false).toList();
                            sle[0] = true;
                            // print(sle);
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 20),
                              child: Container(
                                color: Colors.white,
                                height: heightScreen * 0.12,
                                width: widthScreen,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: GroupButton(
                                    enableDeselect: true,
                                    options: GroupButtonOptions(
                                      borderRadius: BorderRadius.circular(8.0),
                                      selectedColor: Colors.pink[200],
                                      elevation: 0,
                                      selectedBorderColor: Colors.pink,
                                      unselectedBorderColor: Colors.pink,
                                    ),
                                    buttons: data,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        })),
              ),
              //Sản phẩm nổi bật
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nổi bật",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Xem tất cả",
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: FutureBuilder(
                    future: fetchProduct(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        // print(snapshot.error);
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        var highlight = [];
                        var pros = data.products;
                        pros.forEach((e) {
                          if (e.rating > 3) {
                            // print(e.rating);
                            highlight.add(e);
                          }
                        });
                        // print(highlight.length);
                        return SizedBox(
                          width: widthScreen,
                          height: heightScreen * 0.4,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: highlight.length,
                            itemBuilder: (context, index) {
                              var sameCategoryProduct = [];
                              var pros = data.products;
                              pros.forEach((e) {
                                if (e.category == highlight[index].category) {
                                  sameCategoryProduct.add(e);
                                }
                              });
                              return Padding(
                                padding: const EdgeInsets.only(right: 10, left: 10),
                                child: InkWell(
                                  onTap: () async {
                                    var check = await Get.to(
                                      ProductDetail(),
                                      arguments: [highlight[index], sameCategoryProduct],
                                    );
                                    if (check == true) {
                                      setState(() {});
                                      print('object');
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[200],
                                    ),
                                    width: widthScreen * 0.5,
                                    height: heightScreen * 0.35,
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: heightScreen * 0.3,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                            image: DecorationImage(
                                              image: NetworkImage(highlight[index].thumbnail),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Color.fromRGBO(255, 64, 129, 0.7),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      '-' + highlight[index].discountPercentage.toString() + '%',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // color: Colors.amber,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, top: 15),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                highlight[index].title,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 3, bottom: 3),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      curencyFormat.format(highlight[index].price),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.pink,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 7),
                                                      child: Text(
                                                        (curencyFormat.format((highlight[index].price * highlight[index].discountPercentage / 100) +
                                                            highlight[index].price)),
                                                        style: TextStyle(
                                                          decoration: TextDecoration.lineThrough,
                                                          fontSize: 14,
                                                          color: Colors.grey[600],
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  RatingBarIndicator(
                                                    rating: highlight[index].rating * 1.0,
                                                    itemBuilder: (context, index) => Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: 15,
                                                    direction: Axis.horizontal,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 5),
                                                    child: Text('Đã bán ' + highlight[index].stock.toString(),
                                                        style: TextStyle(
                                                          color: Colors.grey[600],
                                                          fontSize: 12,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              //Sản phẩm nổi bật
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Khuyến mãi",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Xem tất cả",
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: FutureBuilder(
                    future: fetchProduct(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        // print(snapshot.error);
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        // List<bool> sle = data.map((e) => false).toList();
                        // sle[0] = true;
                        var highlight = [];
                        var pros = data.products;
                        pros.forEach((e) {
                          if (e.discountPercentage > 10) {
                            // print(e.rating);
                            highlight.add(e);
                          }
                        });
                        // print(highlight.length);
                        return Container(
                          width: widthScreen,
                          height: heightScreen * 0.4,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: highlight.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: widthScreen * 0.5,
                                  height: heightScreen * 0.35,
                                  color: Colors.grey[200],
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: heightScreen * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                          image: DecorationImage(
                                            image: NetworkImage(highlight[index].thumbnail),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Color.fromRGBO(255, 64, 129, 0.7),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '-' + highlight[index].discountPercentage.toString() + '%',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // color: Colors.amber,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 15),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              highlight[index].title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    curencyFormat.format(highlight[index].price),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 7),
                                                    child: Text(
                                                      (curencyFormat.format((highlight[index].price * highlight[index].discountPercentage / 100) +
                                                          highlight[index].price)),
                                                      style: TextStyle(
                                                        decoration: TextDecoration.lineThrough,
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                RatingBarIndicator(
                                                  rating: highlight[index].rating * 1.0,
                                                  itemBuilder: (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 15,
                                                  direction: Axis.horizontal,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 5),
                                                  child: Text('Đã bán ' + highlight[index].stock.toString(),
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 12,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              //Gợi ý sản phẩm
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Gợi ý",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Xem tất cả",
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: FutureBuilder(
                    future: fetchProduct(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        // print(snapshot.error);
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        var data = snapshot.data;

                        List<Products> pros = data.products;
                        pros.sort((a, b) => b.discountPercentage!.compareTo(a.discountPercentage!));
                        return SizedBox(
                          width: widthScreen,
                          height: heightScreen * 0.4,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: widthScreen * 0.5,
                                  height: heightScreen * 0.35,
                                  color: Colors.grey[200],
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: heightScreen * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                          image: DecorationImage(
                                            image: NetworkImage(pros[index].thumbnail!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Color.fromRGBO(255, 64, 129, 0.7),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '-' + pros[index].discountPercentage.toString() + '%',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // color: Colors.amber,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 15),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pros[index].title!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    curencyFormat.format(pros[index].price),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 7),
                                                    child: Text(
                                                      (curencyFormat
                                                          .format((pros[index].price! * pros[index].discountPercentage! / 100) + pros[index].price!)),
                                                      style: TextStyle(
                                                        decoration: TextDecoration.lineThrough,
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                RatingBarIndicator(
                                                  rating: pros[index].rating! * 1.0,
                                                  itemBuilder: (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 15,
                                                  direction: Axis.horizontal,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 5),
                                                  child: Text('Đã bán ' + pros[index].stock.toString(),
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 12,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
