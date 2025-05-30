import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timagra_new/constants/constants.dart';
import 'package:timagra_new/constants/detailed.dart';
import 'package:timagra_new/constants/progressindicator.dart';
import 'package:timagra_new/constants/urls.dart' as urls;
import 'package:timagra_new/controllers/controllers.dart';
import 'package:timagra_new/model/models.dart';
import 'package:timagra_new/view/homepage.dart';
import 'package:timagra_new/view/productsdetailed.dart';
import 'package:timagra_new/view/wishlist/wishlist_detailed.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

TextStyle shopnamestyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);
Color buttoncolor = Color.fromARGB(255, 44, 62, 80);

class Wishlist extends StatefulWidget {
  Wishlist({super.key});

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  WishlistController _wishlistController = WishlistController();

  // Set of selected indices
  Set<int> selectedIndices = {};

  // List to store favorite product IDs
  List<int> fav = [];

  @override
  void initState() {
    super.initState();
    _wishlistController.fetchwishlist().then((_) {
      setState(() {
        setlist();
        updateFilteredProducts();
      });
    });
  }

  SharedPreferences? _readobj;
  late String userid;
  late String Useremail;

  List<String> categories_list = [];

  void setlist() {
    categories_list.add('All');

    for (var item in _wishlistController.wishList) {
      if (item.tile == 'Yes' && !categories_list.contains('Tile')) {
        categories_list.add('Tile');
      }
      if (item.marble == 'Yes' && !categories_list.contains('Marble')) {
        categories_list.add('Marble');
      }
      if (item.granite == 'Yes' && !categories_list.contains('Granite')) {
        categories_list.add('Granite');
      }
    }

    print(categories_list);
  }

  // filter
  List filter_categories = [];

  List filtered_products = [];

  void updateFilteredProducts() {
    setState(() {
      filtered_products = _wishlistController.wishList
          .where((product) =>
              filter_categories.isEmpty ||
              filter_categories.contains(product.productType))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: nonselectedColor,
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'WishList',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories_list.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        String selectedCategory =
                                            categories_list[index];

                                        if (selectedCategory == 'All') {
                                          filter_categories
                                              .clear(); // Show all items
                                        } else {
                                          filter_categories = [
                                            selectedCategory,
                                          ]; // Select only one category
                                        }
                                        updateFilteredProducts();
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: (filter_categories.isEmpty &&
                                                    categories_list[index] ==
                                                        'All') ||
                                                filter_categories.contains(
                                                  categories_list[index],
                                                )
                                            ? buttoncolor
                                            : nonselectedColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          categories_list[index],
                                          style: TextStyle(
                                            color: (filter_categories.isEmpty &&
                                                        categories_list[index] ==
                                                            'All') ||
                                                    filter_categories.contains(
                                                      categories_list[index],
                                                    )
                                                ? Colors.white
                                                : buttoncolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(height: 10, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Filtered Products GridView
        GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      // crossAxisCount: (screenWidth ~/ 180).clamp(2, 4), // Adjust count based on width
    childAspectRatio: (screenWidth / (screenHeight / 1.4)), // Adaptive aspect ratio
    // childAspectRatio: 0.90,
    crossAxisSpacing: 5,
    mainAxisSpacing: 5,
    crossAxisCount: 2,
    
  ),
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: filtered_products.length,
  itemBuilder: (context, index) {
    WishlistModel wishlistModel = filtered_products[index];

    return GestureDetector(
      onTap: () {
        // Navigate to product details page
        Navigator.push(context, MaterialPageRoute(builder: (context)=> WishlistDetailed(
          
          id:wishlistModel. id.toString(), 
          productType:wishlistModel. productType, 
          productName: wishlistModel.productName, 
          productCode:wishlistModel. productCode, 
          description: wishlistModel.description, 
          priceRange: wishlistModel.priceRange, 
          quality: wishlistModel.quality, 
          size: wishlistModel.size, 
          measurement: wishlistModel.measurement, 
          productImage1: wishlistModel.productImage1, 
          productImage2:wishlistModel. productImage2, 
          productImage3:wishlistModel. productImage3, 
          sid: wishlistModel.sid.toString(), 
          shopName: wishlistModel.shopName, 
          logo:wishlistModel. logo, 
          frontImage:wishlistModel. frontImage, 
          location: wishlistModel.location, 
          address:wishlistModel. address, 
          contactNo: wishlistModel.contactNo, 
          website:wishlistModel. website, 
          email:wishlistModel. email, 
          instapage:wishlistModel. instapage, 
          youtube:wishlistModel. youtube, 
          marble: wishlistModel.marble, 
          granite:wishlistModel. granite, 
          tile:wishlistModel. tile
          ) ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '${urls.PRODUCTIMG}${wishlistModel.productImage1}',
                      height: 120, // Use a fixed height to prevent layout shifts
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/icons/noimage.png',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: fav.contains(wishlistModel.id)
                          ? Icon(Icons.favorite_border, color: Colors.white, size: 24)
                          : Icon(Icons.favorite, color: Colors.red, size: 24),
                      onPressed: () {
                        // setState(() {
                        //   if (fav.contains(wishlistModel.id)) {
                        //     fav.remove(wishlistModel.id);
                        //   } else {
                        //     fav.add(int.parse(wishlistModel.id));
                        //   }
                        // });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        wishlistModel.productName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: productnamestyle,
                      ),
                    ),
                    Row(
                      children: [
                        Text('Code : ', style: productdetailsstyle),
                        Flexible(
                          child: Text(
                            wishlistModel.productCode,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: productdetailsstyle,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      wishlistModel.productType,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: productdetailsstyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
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