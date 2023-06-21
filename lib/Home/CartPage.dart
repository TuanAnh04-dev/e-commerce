import 'package:e_commerce/Authenticaiton/Model/Product.dart';
import 'package:e_commerce/Provider/CartProvider.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'ProductDetail.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    getIt.isReady<CartProvider>().then((_) => getIt<CartProvider>().addListener(update));
    super.initState();
  }

  @override
  void dispose() {
    getIt<CartProvider>().removeListener(update);
    super.dispose();
  }

  void update() => setState(() {});
  @override
  Widget build(BuildContext context) {
    List<Products> listPro = getIt<CartProvider>().getListProInCart;
    TextStyle TextSize = const TextStyle(fontSize: 20, color: Colors.yellow);

    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;

    var curencyFormat = NumberFormat.currency(locale: 'en_US', symbol: "\$");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: widthScreen,
              height: heightScreen,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: listPro.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: InkWell(
                      onTap: () => Get.to(() => const ProductDetail(), arguments: [listPro[index]]),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        width: widthScreen * 0.5,
                        height: heightScreen * 0.5,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: heightScreen * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(listPro[index].thumbnail.toString()),
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
                                          '-' + listPro[index].discountPercentage.toString() + '%',
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
                                    listPro[index].title.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          curencyFormat.format(listPro[index].price),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.pink,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 7),
                                          child: Text(
                                            (curencyFormat
                                                .format((listPro[index].price! * listPro[index].discountPercentage! / 100) + listPro[index].price!)),
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
                                        rating: listPro[index].rating! * 1.0,
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
                                        child: Text('Đã bán ' + listPro[index].stock.toString(),
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
            )
          ],
        ),
      ),
    );
  }
}
