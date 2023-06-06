import 'package:e_commerce/Authenticaiton/fetchCategory.dart';
import 'package:e_commerce/Home/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Authenticaiton/fetchProduct.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  getCate() {
    return fetchCategoryPro();
  }

  @override
  void initState() {
    var getCates = getCate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var curencyFormat = NumberFormat.currency(locale: 'en_US', symbol: "\$");
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //appbar
              SizedBox(
                width: widthScreen,
                height: heightScreen * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        width: widthScreen * 0.75,
                        height: heightScreen * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Icon(Icons.search),
                                ),
                                Text(
                                  ' SomethingMall',
                                  style: TextStyle(color: Color.fromRGBO(255, 64, 129, 1)),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Wrap(
                      children: const [
                        Icon(Icons.shopping_cart_outlined, size: 25.0),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 10),
                          child: Icon(Icons.chat_outlined, size: 25.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Banner
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: heightScreen * 0.2,
                  width: widthScreen,
                  color: const Color.fromRGBO(255, 64, 129, 1),
                  child: const Center(
                    child: Text('Banner quảng cáo nè'),
                  ),
                ),
              ),
              //small title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: const [
                        Icon(
                          Icons.arrow_circle_left_outlined,
                          color: Colors.red,
                          size: 15,
                        ),
                        Text(
                          '  Miễn phí trả hàng',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Wrap(
                      children: const [
                        Icon(
                          Icons.check_box,
                          size: 15,
                          color: Colors.red,
                        ),
                        Text(
                          '  Chính hãng 100%',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Wrap(
                      children: const [
                        Icon(
                          size: 15,
                          Icons.local_shipping,
                          color: Colors.red,
                        ),
                        Text(
                          '  Giao miễn phí',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //   title
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0, top: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromRGBO(224, 224, 224, 1)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Icon(
                            Icons.diamond,
                            color: Colors.amber[600],
                            size: 35,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'SHOPEE PREMIUM',
                            style: TextStyle(fontSize: 10),
                            softWrap: true,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromRGBO(224, 224, 224, 1)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Icon(
                            Icons.menu_book_outlined,
                            color: Colors.orange[600],
                            size: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: SizedBox(
                            width: widthScreen / 4.5,
                            child: const Text(
                              'SHOPEE BOOK CLUB',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              softWrap: true,
                              maxLines: 2,
                              textAlign: TextAlign.center,

                              // overflow: TextOverflow.,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromRGBO(224, 224, 224, 1)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Icon(
                            Icons.card_membership_rounded,
                            color: Colors.red[600],
                            size: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: SizedBox(
                            width: widthScreen / 4,
                            child: const Text(
                              'BRAND MEMBERSHIP',
                              style: TextStyle(fontSize: 10),
                              softWrap: true,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromRGBO(224, 224, 224, 1)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Icon(
                            Icons.circle,
                            color: Colors.red[600],
                            size: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: SizedBox(
                            width: widthScreen / 4.5,
                            child: const Text(
                              'THƯƠNG HIỆU QUỐC TẾ',
                              style: TextStyle(fontSize: 10),
                              softWrap: true,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              //Small banner
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: heightScreen * 0.14,
                  width: widthScreen,
                  color: const Color.fromRGBO(255, 64, 129, 1),
                  child: const Center(
                    child: Text('Banner quảng cáo nè'),
                  ),
                ),
              ),

              Container(
                width: widthScreen,
                height: 10.0,
                color: Colors.grey[200],
              ),
              //Category
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Danh mục',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: getCate(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        // print(snapshot.error);
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        var data = snapshot.data;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            width: widthScreen,
                            height: heightScreen * 0.14,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber[300],
                                          size: 60,
                                        ),
                                        SizedBox(
                                          width: widthScreen / 4.5,
                                          child: Text(
                                            data[index],
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 5.0, left: 8.0),
                child: Text(
                  'THƯƠNG HIỆU NỔI BẬT TRONG NGÀY',
                  style: TextStyle(color: Color.fromRGBO(255, 34, 34, 1), fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
              //Small banner
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: heightScreen * 0.1,
                  width: widthScreen,
                  color: const Color.fromRGBO(255, 64, 129, 1),
                  child: const Center(
                    child: Text('Banner quảng cáo nè'),
                  ),
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
                          height: heightScreen * 0.35,
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
                                padding: const EdgeInsets.only(left: 5.0),
                                child: InkWell(
                                  onTap: () => Get.to(() => const ProductDetail(), arguments: [highlight[index], sameCategoryProduct]),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[200],
                                    ),
                                    width: widthScreen * 0.4,
                                    height: heightScreen * 0.3,
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: heightScreen * 0.2,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
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
                                                    color: const Color.fromRGBO(255, 64, 129, 0.7),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      '- ${highlight[index].discountPercentage.toString()} %',
                                                      style: const TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // color: Colors.amber,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5, top: 5),
                                          child: Container(
                                            // color: Colors.blueAccent,
                                            height: heightScreen * 0.14,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    highlight[index].title,
                                                    softWrap: true,
                                                    maxLines: 2,
                                                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                                  ),
                                                ),
                                                Wrap(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            curencyFormat.format(highlight[index].price),
                                                            style: const TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.pink,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 7),
                                                            child: Text(
                                                              (curencyFormat.format(
                                                                  (highlight[index].price * highlight[index].discountPercentage / 100) +
                                                                      highlight[index].price)),
                                                              style: TextStyle(
                                                                decoration: TextDecoration.lineThrough,
                                                                fontSize: 12,
                                                                color: Colors.grey[600],
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          RatingBarIndicator(
                                                            rating: highlight[index].rating * 1.0,
                                                            itemBuilder: (context, index) => const Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 15,
                                                            direction: Axis.horizontal,
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(right: 5),
                                                            child: Text('Đã bán ${highlight[index].stock.toString()}',
                                                                style: TextStyle(
                                                                  color: Colors.grey[600],
                                                                  fontSize: 12,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
