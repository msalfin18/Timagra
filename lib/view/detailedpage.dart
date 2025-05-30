import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timagra_new/constants/constants.dart';
import 'package:timagra_new/constants/detailed.dart';
import 'package:timagra_new/constants/progressindicator.dart';
import 'package:timagra_new/constants/urls.dart' as urls;
import 'package:timagra_new/controllers/controllers.dart';
import 'package:timagra_new/model/models.dart';
import 'package:timagra_new/view/homepage.dart';
import 'package:timagra_new/view/productsdetailed.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http ;

TextStyle shopnamestyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);
Color buttoncolor = Color.fromARGB(255, 44, 62, 80);

class DetailedPage extends StatefulWidget {
  String id;
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
  String district;
  String place;
  String googlemap;

  DetailedPage({
    super.key,
    required this.id,
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
    required this.place,
    required this.district,
    required this.googlemap,
  });

  @override
  _DetailedPageState createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  // ProductDetailedController _productDetailedController = ProductDetailedController();
  DetailedProductController _detailedProductController =
      DetailedProductController();

  // Set of selected indices
  Set<int> selectedIndices = {};

  // List to store favorite product IDs
  List<int> fav = []; 

  Future<void> _makeCall() async {
    final Uri phoneUri = Uri.parse("tel:${widget.contactNo}");

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $phoneUri");
    }
  }

  void launchWhatsApp() async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/${widget.contactNo}');
    if (await canLaunch(whatsappUrl.toString())) {
      await launch(whatsappUrl.toString());
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadpref();
    _fetchProducts();
    print('map link :${widget.googlemap}');
    setlist();
  }


 SharedPreferences? _readobj;
  late String userid;
  late String Useremail;

  Future<void> _loadpref() async {
    _readobj = await SharedPreferences.getInstance();
    setState(() {
      userid = _readobj?.getString('Userid') ?? "#000000000";
      Useremail = _readobj?.getString('Useremail') ?? "Guest";

      print("$userid          $Useremail");
    });
  }



  List categories_list = [];

  void setlist() {
    categories_list.add('All');

    if (widget.tile == 'Yes') {
      categories_list.add('Tile');
    }

    if (widget.marble == 'Yes') {
      categories_list.add('Marble');
    }

    if (widget.granite == 'Yes') {
      categories_list.add('Granite');
    }

    print(categories_list);
  }

  // filter
  List filter_categories = [];

  List filtered_products = [];

  void _fetchProducts() async {
    await _detailedProductController.fetchProducts(widget.id);
    setState(() {}); // Update the UI after fetching data
  }

  // map
  Future<void> openMap() async {
    final googleMapsUrl = widget.googlemap;
    print('loooo' + googleMapsUrl);

    final Uri url = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Google Maps')),
      );
    }
  }


  // add to fav



void add_to_wishlist(int productid) async{

  print('1');

   late String url = "http://192.168.29.50/thinkay4_marbleshop/API/user_add_wishlist.php";


    print(url);

    var response = await http.post(Uri.parse(url),
    body: {
          "userid": userid.toString(),
          "pid": productid.toString() 

    }
    
    );
    var jsonData = jsonDecode(response.body);
    // var jsonString = jsonData['message'];
    print(response);

    if (response.statusCode == 200){
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("added to wishlist")));
        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Homepage()));
       
        Fluttertoast.showToast(msg:  'added to wishlist'  );
            setState(() {
                                          if (fav.contains(productid)) {
                                            fav.remove(productid);      // Remove if already in list
                                       
                                          
                                            
                                          }
                                           else {
                                            fav.add(productid); 
                                              
                                          }
                                        });


    }else {
      // ScaffoldMessenger.of(cntx).showSnackBar(SnackBar(content: Text("Registartion Failed")));
    }
  

}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<DetailedProductModel> filteredProducts =
        _detailedProductController.detailedproductList
            .where(
              (product) =>
                  filter_categories.isEmpty ||
                  filter_categories.contains(product.productType),
            )
            .toList();

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
          'Shop Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              height: 250,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  // Cover Image
                  CachedNetworkImage(
                    imageUrl: '${urls.SHOPIMG}${widget.frontImage}',
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/icons/noimage.png', // Replace with your local fallback image
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Profile Image (Positioned)
                  Positioned(
                    bottom: 0,
                    left: 20,
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
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/icons/noimage.png', // Replace with your local fallback image
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  // Shop Name and Map Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.shopName,
                          style: shopnamestyledetailed,
                          maxLines: 2, // Allows it to break into two lines
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: openMap,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: buttoncolor,
                          ),
                          child: const Icon(
                            Icons.map,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5.0,
                      bottom: 5,
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.place,
                          style: detaledsubtitles,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.district,
                          style: detaledsubtitles,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                        size: 22,
                      ),
                      SizedBox(width: 5),
                      Text(widget.address, style: detaledsubtitles),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _makeCall();
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: buttoncolor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Call',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            launchWhatsApp();
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: buttoncolor, width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mail_outline_rounded,
                                  color: buttoncolor,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Message',
                                  style: TextStyle(color: buttoncolor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                                    filter_categories.clear(); // Show all items
                                  } else {
                                    filter_categories = [
                                      selectedCategory,
                                    ]; // Select only one category
                                  }
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.70,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  DetailedProductModel detailedProductModel =
                      filteredProducts[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsdetailedPage(
                            id: detailedProductModel.id,
                            productType: detailedProductModel.productType,
                            productName: detailedProductModel.productName,
                            productCode: detailedProductModel.productCode,
                            description: detailedProductModel.description,
                            priceRange: detailedProductModel.priceRange,
                            quality: detailedProductModel.quality,
                            size: detailedProductModel.size,
                            measurement: detailedProductModel.measurement,
                            productImage1: detailedProductModel.productImage1,
                            shopid: widget.id,
                            shopName: widget.shopName,
                            shoplogo: widget.logo,
                            shopfrontImage: widget.frontImage,
                            shoplocation: widget.location,
                            shopaddress: widget.address,
                            shopcontactNo: widget.contactNo,
                            shopwebsite: widget.website,
                            shopemail: widget.email,
                            shopinstapage: widget.instapage,
                            shopyoutube: widget.youtube,
                            shopmarble: widget.marble,
                            shopgranite: widget.granite,
                            shoptile: widget.tile,
                          ),
                        ),
                      );
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
                                    imageUrl:
                                        '${urls.PRODUCTIMG}${detailedProductModel.productImage1}',
                                    height: screenHeight * 0.18,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/icons/noimage.png',
                                      height: screenHeight * 0.19,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: fav.contains(detailedProductModel.id)
                                          ? Icon(Icons.favorite, color: buttoncolor, size: 28)
                                          : Icon(Icons.favorite_border, color: Colors.white, size: 28),
                                      onPressed: () {

                                        add_to_wishlist(detailedProductModel.id);

                                    
                                        print(fav);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detailedProductModel.productName ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: productnamestyle,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Code : ',
                                        style: productdetailsstyle,
                                      ),
                                      Text(
                                        detailedProductModel.productCode,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: productdetailsstyle,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    detailedProductModel.productType,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
