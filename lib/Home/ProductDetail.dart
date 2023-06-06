import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/Authenticaiton/Model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var product = Get.arguments[0];
  var sameCate = Get.arguments[1];
  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    List<String> images = product.images;
    var curencyFormat = NumberFormat.currency(locale: 'en_US', symbol: "\$");

    // print(sameCate);

    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          scrolledUnderElevation: 1,
          surfaceTintColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
          ),
          actions: const [
            Icon(
              Icons.share,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.amber,
                height: heightScreen * 0.5,
                width: widthScreen,
                child: CarouselSlider(
                  options: CarouselOptions(autoPlay: true, viewportFraction: 1, height: heightScreen * 0.5),
                  items: images
                      .map((e) => Image.network(
                            e,
                            fit: BoxFit.fill,
                          ))
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title.toString(),
                    ),
                    const Icon(
                      Icons.discount_rounded,
                      color: Color.fromRGBO(255, 64, 129, 1),
                    )
                  ],
                ),
              ),
              //Giá
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      curencyFormat.format(product.price),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(255, 64, 129, 1),
                      ),
                    ),
                    Text(
                      (curencyFormat.format((product.price * product.discountPercentage / 100) + product.price)),
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        RatingBarIndicator(
                          rating: product.rating * 1.0,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15,
                          direction: Axis.horizontal,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7, right: 10),
                          child: Text(product.rating.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                // fontSize: 12,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            '|  Đã bán  + ${product.stock.toString()}',
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      children: [
                        Icon(
                          Icons.monitor_heart_rounded,
                          color: Colors.grey[600],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.share_outlined,
                            color: Colors.grey[600],
                          ),
                        ),
                        const Icon(
                          Icons.facebook,
                          color: Color.fromRGBO(66, 103, 178, 1),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //deivde
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: widthScreen,
                  height: 7,
                  color: Colors.grey[200],
                ),
              ),

              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                    child: Icon(
                      Icons.fire_truck,
                      color: Color.fromRGBO(80, 203, 152, 1),
                      size: 20,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Miễn phí vận chuyển',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        'Miễn phí vận chuyển cho đơn hàng trên 99.000đ',
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                    child: Icon(
                      Icons.fire_truck,
                      color: Colors.grey[500],
                      size: 20,
                    ),
                  ),
                  const Text('Phí vận chuyển : 0đ'),
                ],
              ),
              //devide
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: widthScreen,
                  height: 7,
                  color: Colors.grey[200],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Voucher của bạn',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              //devide
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: widthScreen,
                  height: 7,
                  color: Colors.grey[200],
                ),
              ),
              //Sản phẩm cùng loại
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top sản phẩm cùng loại',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 64, 129, 1),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(255, 64, 129, 1),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: widthScreen,
                height: heightScreen * 0.4,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: sameCate.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Container(
                        width: widthScreen * 0.3,
                        height: heightScreen * 0.25,
                        color: Colors.grey[200],
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Thumbnail
                            Container(
                              height: heightScreen * 0.26,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(sameCate[index].thumbnail),
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
                                          '-${sameCate[index].discountPercentage.toString()}%',
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
                              padding: const EdgeInsets.only(left: 5, top: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sameCate[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          curencyFormat.format(sameCate[index].price),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        RatingBarIndicator(
                                          rating: sameCate[index].rating * 1.0,
                                          itemBuilder: (context, index) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 15,
                                          direction: Axis.horizontal,
                                        ),
                                        Text(
                                          'Đã bán  + ${sameCate[index].stock.toString()}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
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
              ),

              //deivde
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: widthScreen,
                  height: 7,
                  color: Colors.grey[200],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Chi tiết sản phẩm',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'kho, Thương hiệu,..',
                          style: TextStyle(
                              // color: Color.fromRGBO(255, 64, 129, 1),
                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            // color: Color.fromRGBO(255, 64, 129, 1),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              //deivde nhỏ
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: widthScreen,
                  height: 1,
                  color: Colors.grey[200],
                ),
              ),

              buildText(product.description),
              //deivde nhỏ
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: widthScreen,
                  height: 1,
                  color: Colors.grey[200],
                ),
              ),

              InkWell(
                onTap: () {
                  setState(() {
                    isReadMore = !isReadMore;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isReadMore ? 'Thu gọn  ' : 'Xem thêm  ',
                        style: const TextStyle(
                          color: Color.fromRGBO(255, 64, 129, 1),
                        ),
                      ),
                      Icon(
                        isReadMore ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: const Color.fromRGBO(255, 64, 129, 1),
                      ),
                    ],
                  ),
                ),
              ),

              //deivde
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: widthScreen,
                  height: 7,
                  color: Colors.grey[200],
                ),
              ),
              //rating
              Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Đánh giá sản phẩm',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: product.rating * 1.0,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 15,
                              direction: Axis.horizontal,
                            ),
                            Text(
                              '  ${product.rating * 1.0}/5',
                              style: const TextStyle(color: Color.fromRGBO(255, 64, 129, 1)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 64, 129, 1),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(255, 64, 129, 1),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 8.0,
          color: Colors.red,
          child: SizedBox(
            height: heightScreen * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          right: BorderSide(color: Color.fromARGB(255, 210, 210, 210)),
                        ),
                      ),
                      height: heightScreen * 0.06,
                      width: widthScreen * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.chat,
                            color: Colors.red,
                          ),
                          Text(
                            'chat ngay',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: heightScreen * 0.06,
                      width: widthScreen * 0.25,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.local_grocery_store_rounded,
                            color: Colors.red,
                          ),
                          Text(
                            'Thêm vào giỏ hàng',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: heightScreen * 0.06,
                  width: widthScreen * 0.5,
                  child: const Text(
                    'Mua hàng',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildText(String text) {
    final lines = isReadMore ? null : 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Mô tả sản phẩm',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            text,
            maxLines: lines,
            overflow: isReadMore ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
