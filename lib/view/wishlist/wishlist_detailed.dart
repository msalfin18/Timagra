import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timagra_new/constants/constants.dart';
import 'package:timagra_new/constants/detailed.dart';
import 'package:timagra_new/constants/productdetail.dart'
    as productdetailedstyle;
import 'package:timagra_new/constants/urls.dart';
import 'package:timagra_new/view/detailedpage.dart';

class WishlistDetailed extends StatefulWidget {
      String id;
    String productType;
    String productName;
    String productCode;
    String description;
    String priceRange;
    String quality;
    String size;
    String measurement;
    String productImage1;
    String productImage2;
    String productImage3;
    String sid;
    String shopName;
    String logo;
    String frontImage;
    String location;
    String address;
    String contactNo;
    String website;
    String email;
    String instapage;
    String youtube;
    String marble;
    String granite;
    String tile;

  WishlistDetailed(
      {
        required this.id,
        required this.productType,
        required this.productName,
        required this.productCode,
        required this.description,
        required this.priceRange,
        required this.quality,
        required this.size,
        required this.measurement,
        required this.productImage1,
        required this.productImage2,
        required this.productImage3,
        required this.sid,
        required this.shopName,
        required this.logo,
        required this.frontImage,
        required this.location,
        required this.address,
        required this.contactNo,
        required this.website,
        required this.email,
        required this.instapage,
        required this.youtube,
        required this.marble,
        required this.granite,
        required this.tile,

      super.key});

  @override
  State<WishlistDetailed> createState() => _WishlistDetailedState();
}

class _WishlistDetailedState extends State<WishlistDetailed> {
     
  Map<String, dynamic>? locationData;


      @override
  void initState() {
    // TODO: implement initState
    try {
      locationData = jsonDecode(widget.location);
    } catch (e) {
      locationData = {}; // Default empty map if decoding fails
    }
    super.initState();
  }

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
              imageUrl: '$PRODUCTIMG${widget.productImage1}',
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
                  Text(widget.productName,
                      style: productdetailedstyle.productnamestyle),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Product details',
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
                                Text(widget.quality,
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
                                Text(widget.size,
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
                                Text(widget.measurement,
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
                  Text(widget.description,
                      style: productdetailedstyle.detailesproductstyle),

                      SizedBox(height: 16,),
                      
            Text('Seller Details' , style: productdetailedstyle.productsubtiles,),
SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> 
                    
                    
                    DetailedPage(
                      id: widget.sid, 
                      shopName: widget.shopName, 
                      logo: widget.logo, 
                      frontImage:widget. frontImage, 
                      location:widget. location, 
                      address:widget. address, 
                      contactNo: widget.contactNo, 
                      website:widget. website, 
                      email:widget. email, 
                      instapage:widget. instapage, 
                      youtube:widget. youtube, 
                      marble:widget. marble, 
                      granite:widget. granite, 
                      tile:widget. tile, 
                      place: locationData?['location']  , 
                      district:locationData?['district'],
                      googlemap:widget.location
                      
                      )));
                  },
                  child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 4, color: Colors.white),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: '${SHOPIMG}${widget.logo}',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Image.asset(
                                  'assets/icons/noimage.png', // Replace with your local fallback image
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      ),
                ),

SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      children: [
                        Text(widget.shopName, style:productdetailedstyle
                                        .detailesproductstyle),
                        Text(
                                  '${locationData?['location'] ?? 'N/A'}, ${locationData?['district'] ?? 'N/A'}',
                                  style:productdetailedstyle.detailesstyle
                                )
                        
                      ],
                    )

              ],
            )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
