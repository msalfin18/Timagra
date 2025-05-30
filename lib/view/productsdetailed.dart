import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timagra_new/constants/constants.dart';
import 'package:timagra_new/constants/detailed.dart';
import 'package:timagra_new/constants/productdetail.dart'
    as productdetailedstyle;
import 'package:timagra_new/constants/urls.dart';

class ProductsdetailedPage extends StatelessWidget {
  final int id;
  final String productType;
  final String productName;
  final String productCode;
  final String description;
  final String priceRange;
  final String quality;
  final String size;
  final String measurement;
  final String productImage1;

  String shopid;
  String shopName;
  String shoplogo;
  String shopfrontImage;
  String shoplocation;
  String shopaddress;
  String shopcontactNo;
  String shopwebsite;
  String shopemail;
  String shopinstapage;
  String shopyoutube;
  String shopmarble;
  String shopgranite;
  String shoptile;

  ProductsdetailedPage(
      {required this.id,
      required this.productType,
      required this.productName,
      required this.productCode,
      required this.description,
      required this.priceRange,
      required this.quality,
      required this.size,
      required this.measurement,
      required this.productImage1,
      required this.shopid,
      required this.shopName,
      required this.shoplogo,
      required this.shopfrontImage,
      required this.shoplocation,
      required this.shopaddress,
      required this.shopcontactNo,
      required this.shopwebsite,
      required this.shopemail,
      required this.shopinstapage,
      required this.shopyoutube,
      required this.shopmarble,
      required this.shopgranite,
      required this.shoptile,
      super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: nonselectedColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Product Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: '$PRODUCTIMG$productImage1',
              width: double.infinity,
              height: 250,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  SizedBox(), // No circular progress indicator
              errorWidget: (context, url, error) => Image.asset(
                'assets/icons/noimage.png',
                width: double.infinity,
                height: 250,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productName,
                      style: productdetailedstyle.productnamestyle),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'product details',
                    style: productdetailedstyle.productsubtiles,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Icon(
                                Icons.error_outline,
                                color: productdetailedstyle.iconcolor,
                                size: productdetailedstyle.iconsize,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Quality',
                                    style: productdetailedstyle.detailesstyle),
                                Text(quality,
                                    style: productdetailedstyle
                                        .detailesproductstyle),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.22,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Transform.rotate(
                                angle:
                                    -0.785, // Rotates by 45 degrees (pi/4 radians)
                                child: Icon(
                                  Icons.sync_alt,
                                  color: productdetailedstyle.iconcolor,
                                  size: productdetailedstyle.iconsize,
                                ),
                              ),
                            ),
                            // Icon(Icons. , color: productdetailedstyle.iconcolor,size: productdetailedstyle.iconsize,),
                            SizedBox(
                              width: 10,
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Size',
                                    style: productdetailedstyle.detailesstyle),
                                Text(size,
                                    style: productdetailedstyle
                                        .detailesproductstyle),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Icon(
                                Icons.layers_outlined,
                                color: productdetailedstyle.iconcolor,
                                size: productdetailedstyle.iconsize,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Measurement',
                                    style: productdetailedstyle.detailesstyle),
                                Text(measurement,
                                    style: productdetailedstyle
                                        .detailesproductstyle),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Description',
                    style: productdetailedstyle.productsubtiles,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(description,
                      style: productdetailedstyle.detailesproductstyle)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
