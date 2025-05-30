// import 'dart:convert';
// import 'package:timagra_new/constants/detailed.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http ;
// import 'package:timagra_new/constants/constants.dart';
// import 'package:timagra_new/constants/detailed.dart';
// import 'package:timagra_new/constants/urls.dart';
// import 'package:timagra_new/controllers/controllers.dart';
// import 'package:timagra_new/model/models.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:timagra_new/view/detailedpage.dart';
// import 'package:timagra_new/view/statefilterpage.dart';


//  TextStyle shopnamestyle = TextStyle(
//   color: Colors.black,
//   fontSize: 18,
//   fontWeight: FontWeight.w600,
// );


// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
  
//   TileController _tileController = TileController();
//    HomeFilterController _homeFilterController = HomeFilterController();
//   CarouselhomeController _carouselhomeController = CarouselhomeController();
      


//   Future  <void> saveUserData( String item) async{
//   print('its changes');

//         SharedPreferences prefobj = await SharedPreferences.getInstance();
//                await prefobj.setString('item', item.toString());
//                print(' Sp  $prefobj');

               
// print(item);



//           // _homeFilterController.fetchDatabase();

    
//             // _homeFilterController.fetchDatabase();
//     // fetchData();      
//   }
//   String _selectedFilter = 'all'; 




// String items = '';

// String _location = ''; 

// String _district = ''; 
//  // To store the location text


//   bool _isLoading = true;

//     bool isshoploading = true;

// @override
//   void initState() {
//     // TODO: implement initState

// fetchData();
// fetchLocation();
  
//     super.initState();
//   }

//  Future<void> fetchData() async {
//     setState(() {
//     _isLoading = true; // Show loading indicator
//     isshoploading = true ;
//   });


//     try {
//       await   _homeFilterController.fetchDatabase();
//     await  _tileController.fetchShops();
//     await _carouselhomeController.fetchShops();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to fetch books data.")),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//         isshoploading = false ;

//     //      List filteredmarble = _homeFilterController.homefilterdataList
//     // .where((filter) =>  filter.marble == 'Yes')
//     // .toList();
         

//     //       List filteredtile = _homeFilterController.homefilterdataList
//     // .where((filter) =>  filter.tile == 'Yes')
//     // .toList();

//     //  List filteredgranite = _homeFilterController.homefilterdataList
//     // .where((filter) =>  filter.granite == 'Yes')
//     // .toList();
         

     
//       });
//     }
//   }

//   // Function to fetch the current location using geolocator
//   Future<void> fetchLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       setState(() {
//         _location = 'Location services are disabled.';
//       });
//       return;
//     }

//     // Check for location permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() {
//           _location = 'Location permissions are denied.';
//         });
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       setState(() {
//         _location = 'Location permissions are permanently denied.';
//       });
//       return;
//     }

//     // Fetch the current position
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

//     // Fetch the address from the coordinates
//     List<Placemark> placemarks = await GeocodingPlatform.instance!.placemarkFromCoordinates(position.latitude, position.longitude);

//     if (placemarks.isNotEmpty) {
      
//       Placemark place = placemarks.first;
//       // print(place);
//       setState(() {
//         // print(place);
//         _location = '${place.subLocality}';
//         _district = '${place.locality}';
//         // print(place);
//         print('locaiton $_location');
//       });
//     } else {
//       setState(() {
//         _location = 'Could not fetch address.';
//       });
//     }
//   }

//   int _current = 0;

//   // String _selectedFilter = ''; // Track the selected filter






//   @override
//   Widget build(BuildContext context) {
//         final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
  
//     return SafeArea(
//       child: Scaffold(
//          appBar: AppBar(
//           toolbarHeight: 80,
//           titleSpacing: 10,
//           backgroundColor: Colors.white,
//           elevation: 0,
//           surfaceTintColor: Colors.white,
//           shadowColor: Colors.white,
//           title: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image(
//               height: 55,
//               fit: BoxFit.fill,
//               image: AssetImage('assets/icons/App_Home.png'),
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Icon(Icons.location_on_rounded , color: Colors.blue,),
//                   Text(
//                     _location.isEmpty ? '' : _location,  
//                     style: locationstyle,
//                   ),
//                   // Text(
//                   //   _district.isEmpty ? 'Location' : _district,  
//                   //   style: locationstyle,
//                   // ),
//                 ],
//               ),
//             ),
//           ],
//         ),

//          body:   _isLoading
//     ? Center(child: CircularProgressIndicator()) // Show loading spinner
//     : Column(
//         children: [
//           Container(
//             color: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Search TextField
//                   GestureDetector(
//                     onTap: () {
//                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> StatefilterPage(categoriesList: _tileController.tileList)));
//                       print(_homeFilterController.homefilterdataList);
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: nonselectedColor,
//                       ),
//                       height: 48,
                    
//                       child: 

//                       Padding(
//                         padding: const EdgeInsets.only(top: 3.0),
//                         child: TextFormField(
                            
//                          decoration: InputDecoration(
                        
//                           border: InputBorder.none,
//                           prefixIcon:    Icon(Icons.search , color: searchiconcolor,),
//                           hintText:    'Search for shops',
                          
//                           hintStyle: searchhitstyle,
//                           suffixIcon: IconButton(
//                                        onPressed: (){
//                                         Navigator.push(context, MaterialPageRoute(builder: (context)=> StatefilterPage(categoriesList: _tileController.tileList)));
//                                        }, 
//                                        icon: SizedBox(
//                                         height: 50,width: 30,
//                                          child: Card(
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(6)
//                                           ),
//                                           color: Colors.white,
//                                           child: Icon(Icons.align_horizontal_right_rounded, color: greytext, size: 16,),
//                                          ),
//                                        ))
//                          ),
                        
//                         ),
//                       )
                      
//                       // Padding(
//                       //   padding: const EdgeInsets.only(left: 16.0),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.start,
//                       //     crossAxisAlignment: CrossAxisAlignment.center,
//                       //     children: [
//                       //       Icon(Icons.search , color: searchiconcolor,),
//                       //       SizedBox(width: 10,),
//                       //       Text('Search for shops' , style: searchhitstyle,)
//                       //     ],
//                       //   ),
//                       // ),
                                    
//                     ),
//                   ),
//                   const SizedBox(height: 30, child: Divider(
//                     color: nonselectedColor,thickness: 1,
//                   )),
//                   // Filter Tiles
//                   Container(
//                     height: 75,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _tileController.tileList.length,
//                       itemBuilder: (context, index) {
//                         TileCagoryDataModel tileCagoryDataModel = _tileController.tileList[index];
//                         return  Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0 ),
//       child: GestureDetector(
//         onTap: () {
      



        
//           setState(() {
//             _selectedFilter = tileCagoryDataModel.productType.toString();
//             // saveUserData(tileCagoryDataModel.productType.toString());
      
//              items = tileCagoryDataModel.id.toString().toLowerCase();
      
//             print('  selected tile  $items');

//             print(_selectedFilter);
      
      
//               //  saveUserData(items);   
//           });
      
      
      
      
      
//         },
//         child: Container(
//           height: screenWidth * 0.18,
//           width: screenWidth * 0.18,
//           decoration: BoxDecoration(
//             color: _selectedFilter == tileCagoryDataModel.productType
//                 ? selectedColor
//                 : nonselectedColor,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Image(
//                   image: _selectedFilter == tileCagoryDataModel.productType
//                       ? slectedimg
//                       : unslectedimage,
//                   fit: BoxFit.scaleDown,
//                   height: 24,
//                   width: 24,
//                 ),
//                 Text(
                  
//                   '${tileCagoryDataModel.productType}',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: _selectedFilter == tileCagoryDataModel.productType
//                         ? slectedtextblue
//                         : greytext,
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//                       },
//                     ),
//                   ),

//                   SizedBox(height: 15,),

//                    CarouselSlider.builder(
//         itemCount: _carouselhomeController.carouselList.length,
              
//         itemBuilder: (context, index, realIndex) {
//           print('length ${_carouselhomeController.carouselList.length}');
//               CarouselModel homeScreenImageModel = _carouselhomeController.carouselList[index];
//               return Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Image(
                  
                          
//                           image: NetworkImage('${CAROUSELIMGS}${homeScreenImageModel.banner}'),
//                           fit: BoxFit.fill,
//                           width: double.infinity,
//                   ),
//                 ),
//               );
//               // print(IMAGE_SLIDER_URL+ '/'+homeScreenImageModel.imageName);
//         },
//         options: CarouselOptions(
//               //  height: screenHeight * 0.25,
//               aspectRatio: 16/8,
//          viewportFraction: 1.0,
//               autoPlay: true,
//               autoPlayInterval: Duration(seconds: 2), 
//               autoPlayAnimationDuration: Duration(milliseconds: 800), 
//               autoPlayCurve: Curves.linearToEaseOut, 
//               enlargeCenterPage: false, 
//         ),
//               ),

//               Container(
//                  color: Colors.white, 
//                   height: 8,)
//                   ////
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10.0, left: 24),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   'All shops',
//                   style:  TextStyle(
//   color: const Color.fromARGB(221, 41, 41, 41),
//   fontSize: 16,
//   fontWeight: FontWeight.w600,
// )
// ,
//                 ),
//               ],
//             ),
//           ),
          
//     isshoploading
//     ? Center(child: CircularProgressIndicator()) // Show loading spinner
//     :  
// Expanded(
//   child: filteredList.isEmpty
//       ? Center(child: Text('No data available'))
//       : ListView.builder(
//           itemCount: filteredList.length,
//           itemBuilder: (context, index) {
//             HomefilterDataModel homefilterDataModel = filteredList[index];



//           //-----------------------------

          

//             return Padding(
//               padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 5),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedPage(
//                     id: homefilterDataModel.id.toString(),
//                     shopName: homefilterDataModel.shopName.toString(),
//                     logo: homefilterDataModel.logo.toString(),
//                     frontImage: homefilterDataModel.frontImage.toString(),
//                     location: homefilterDataModel.location.toString(),
//                     address: homefilterDataModel.address.toString(),
//                     contactNo: homefilterDataModel.contactNo.toString(),
//                     website: homefilterDataModel.website.toString(),
//                     email: homefilterDataModel.email.toString(),
//                     instapage: homefilterDataModel.instapage.toString(),
//                     youtube: homefilterDataModel.youtube.toString(),
//                     marble: homefilterDataModel.marble.toString(),
//                     granite: homefilterDataModel.granite.toString(),
//                     tile: homefilterDataModel.tile.toString(),
//                   )));
//                 },

//                 child: Card(
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Column(
//                               children: [
//                                 SizedBox(height: 5),
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image(
//                                     height: screenHeight * 0.118,
//                                     width: screenWidth * 0.24,
//                                     fit: BoxFit.fill,
//                                     image: homefilterDataModel.frontImage?.isNotEmpty == true
//                                         ? NetworkImage('${SHOPIMG}${homefilterDataModel.frontImage}')
//                                         : AssetImage('assets/icons/oneone.jpg') as ImageProvider,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 0.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   homefilterDataModel.shopName.toString(),
//                                   style: shopnamestyle,
//                                   softWrap: true,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.location_on_sharp, color: Colors.black, size: 16),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       '${homefilterDataModel.address.toString()}',
//                                       style: subtitleTextStyle,
//                                       maxLines: 3,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 3),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.phone, color: Colors.black, size: 16),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       homefilterDataModel.contactNo.toString(),
//                                       style: subtitleTextStyle,
//                                       softWrap: true,
//                                       overflow: TextOverflow.visible,
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 5),
//                                 Row(
//                                   children: [
//                                     if (homefilterDataModel.tile == 'Yes')
//                                       Card(
//                                         elevation: 2,
//                                         color: Colors.white,
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//                                           child: Text('Tile', style: tilemarblesTextStyle),
//                                         ),
//                                       ),
//                                     if (homefilterDataModel.marble == 'Yes')
//                                       Card(
//                                         elevation: 2,
//                                         color: Colors.white,
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//                                           child: Text('Marble', style: tilemarblesTextStyle),
//                                         ),
//                                       ),
//                                     if (homefilterDataModel.granite == 'Yes')
//                                       Card(
//                                         elevation: 2,
//                                         color: Colors.white,
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//                                           child: Text('Granite', style: tilemarblesTextStyle),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
// ),

//         ],
//       ),
 
//         ),
        
      
//     );
 
//   }
  
// }v