import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:permission_handler/permission_handler.dart'; // Add this import
import 'package:timagra_new/constants/constants.dart';
import 'package:timagra_new/constants/progressindicator.dart';
import 'package:timagra_new/constants/urls.dart';
import 'package:timagra_new/controllers/controllers.dart';
import 'package:timagra_new/model/models.dart';
import 'package:timagra_new/view/detailedpage.dart';
import 'package:timagra_new/view/profile/profile.dart';
import 'package:timagra_new/view/statefilterpage.dart';
import 'package:timagra_new/view/wishlist/wishlist.dart';

// Define your styles and constants here
TextStyle shopnamestyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

const String SHOPIMG = '$MAIN_API../file_uploads/shop/';

class Homepage extends StatefulWidget {
  String? filter_district;
  String? filter_state;
  String? filter_location;

  Homepage({
    super.key,
    this.filter_district,
    this.filter_location,
    this.filter_state,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _scrollController =
      ScrollController(); // Add ScrollController
  final TextEditingController _searchController =
      TextEditingController(); // Add this

  final TileController _tileController = TileController();
  final HomeFilterController _homeFilterController = HomeFilterController();
  final CarouselhomeController _carouselhomeController =
      CarouselhomeController();

  String _selectedFilter = 'All'; // Track the selected filter
  String _location = ''; // To store the location text
  String _district = ''; // To store the district
  bool _isLoading = true;
  bool isshoploading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchLocation();
    // Wait until the first frame renders, then scroll down
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500), // Smooth scroll
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the ScrollController
    super.dispose();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
      isshoploading = true;
    });

    try {
      await _homeFilterController.fetchDatabase();
      await _tileController.fetchShops();
      await _carouselhomeController.fetchShops();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch data.")),
      );
    } finally {
      setState(() {
        _isLoading = false;
        isshoploading = false;
      });
    }
  }

  Future<void> fetchLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _location = 'Turn on Location';
      });
      return;
    }

    // Check and request location permissions
    // PermissionStatus permissionStatus = await Permission.location.request();
    PermissionStatus permissionStatus = await Permission.location.status;

    if (permissionStatus.isGranted) {
      print('Location Permission Already Granted');
      _getLocation();
    } else if (permissionStatus.isDenied) {
      // Request permission
      PermissionStatus status = await Permission.location.request();
      if (status.isGranted) {
        // Permission granted, you can use the location now
        print('Location Permission Granted');
        _getLocation();
      } else {
        print('Location Permission Denied');
      }

      // setState(() {
      //   _location = 'Location permissions are denied.';
      // });
    } else if (permissionStatus.isPermanentlyDenied) {
      // setState(() {
      //   _location =
      //       'Location permissions are permanently denied. Please enable them in the app settings.';
      // });
      openAppSettings(); // Open app settings to allow manual permission enabling
    }
  }

  Future<void> _getLocation() async {
    // Permission granted, fetch the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Fetch the address from the coordinates
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      setState(() {
        _location = '${place.locality}';
        _district = '${place.locality}';
      });
    } else {
      setState(() {
        _location = 'Could not fetch address.';
      });
    }
  }

  List<HomefilterDataModel> get filteredList {
    return _homeFilterController.homefilterdataList.where((item) {
      // Filter by selected category
      bool matchesCategory;
      switch (_selectedFilter.toLowerCase()) {
        case 'tile':
          matchesCategory = item.tile?.toLowerCase() == 'yes';
          break;
        case 'marble':
          matchesCategory = item.marble?.toLowerCase() == 'yes';
          break;
        case 'granite':
          matchesCategory = item.granite?.toLowerCase() == 'yes';
          break;
        case 'paving stone':
          matchesCategory =
              false; // No paving stone data in API, modify if needed
          break;
        case 'all':
        default:
          matchesCategory = true; // Show all items when "all" is selected
      }

      // Filter by search query
      bool matchesSearch = (item.shopName
                  ?.toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ??
              false) ||
          (item.address?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (item.contactNo?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (item.location?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (item.tile?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (item.marble?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (item.granite?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (item.email?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (item.instapage?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: nonselectedColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        titleSpacing: 10,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 65,
        leading:   Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
              },
              child:   Image.asset('assets/image/user.png', height: 40,),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Image(
            height: 55,
            fit: BoxFit.fill,
            image: AssetImage('assets/icons/App_Home.png'),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.location_on_rounded, color: Colors.blue),
                GestureDetector(
                  onTap: () {
                     Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StatefilterPage(location: _location),
          ),
        );
                  },
                  child: Text(
                    _location.isEmpty
                        ? 'Fetching location...'
                        : widget.filter_location ??
                            widget.filter_district ??
                            widget.filter_state ??
                            _location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicatorconst())
          : RefreshIndicator(
              color: greycolor,
              onRefresh: () async {
                fetchData();
                fetchLocation();
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Container(
                      height: 5,
                      color: Colors.white,
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: .0, horizontal: 16.0),
                        child: Column(
                          children: [
                           Row(
  children: [
    Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        height: 48,
        child: Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: TextFormField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              hintText: 'Search for shops',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    ),

    SizedBox(width: 10), // Adds spacing between search bar and filter button

    GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Wishlist()));
      },
      child: Card(
          color: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.favorite_border, color: Colors.black),
        ),
      ),
    ),
  ],
)
,
                            SizedBox(height: 15),
                            SizedBox(
                              height: 75,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _tileController.tileList.length,
                                itemBuilder: (context, index) {
                                  TileCagoryDataModel tileCagoryDataModel =
                                      _tileController.tileList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedFilter = tileCagoryDataModel
                                              .productType
                                              .toString();
                                          print(_selectedFilter);
                                        });
                                      },
                                      child: Container(
                                        width: 75,
                                        decoration: BoxDecoration(
                                          color: _selectedFilter ==
                                                  tileCagoryDataModel
                                                      .productType
                                              ? selectedColor
                                              : nonselectedColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image(
                                                image: _selectedFilter ==
                                                        tileCagoryDataModel
                                                            .productType
                                                    ? slectedimg
                                                    : unslectedimage,
                                                fit: BoxFit.scaleDown,
                                                height: 24,
                                                width: 24,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                '${tileCagoryDataModel.productType}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: _selectedFilter ==
                                                          tileCagoryDataModel
                                                              .productType
                                                      ? slectedtextblue
                                                      : greytext,
                                                  // wordSpacing: 0.1,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            CarouselSlider.builder(
                              itemCount:
                                  _carouselhomeController.carouselList.length,
                              itemBuilder: (context, index, realIndex) {
                                CarouselModel homeScreenImageModel =
                                    _carouselhomeController.carouselList[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '$CAROUSELIMGS${homeScreenImageModel.banner}',
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      fadeInDuration: Duration(
                                          milliseconds:
                                              0), // Removes fade-in effect
                                      fadeOutDuration: Duration(
                                          milliseconds:
                                              0), // Removes fade-out effect
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                aspectRatio: 16 / 8,
                                viewportFraction: 1.0,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 2),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              height: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20),
                      child: Row(
                        children: [
                          Text('All shops', style: shopnamestyle),
                        ],
                      ),
                    ),
                    filteredList.isEmpty
                        ? Center(child: Text(''))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.filter_location != null
                                ? filteredList.where((homefilterDataModel) {
                                    var locationData = jsonDecode(
                                        homefilterDataModel.location!);
                                    return locationData['location'] ==
                                        widget.filter_location;
                                  }).length
                                : widget.filter_district != null
                                    ? filteredList.where((homefilterDataModel) {
                                        var locationData = jsonDecode(
                                            homefilterDataModel.location!);
                                        return locationData['district'] ==
                                            widget.filter_district;
                                      }).length
                                    : widget.filter_state != null
                                        ? filteredList
                                            .where((homefilterDataModel) {
                                            var locationData = jsonDecode(
                                                homefilterDataModel.location!);
                                            return locationData['state'] ==
                                                widget.filter_state;
                                          }).length
                                        : filteredList.length,
                            itemBuilder: (context, index) {
                              HomefilterDataModel homefilterDataModel;

                              List filterappliedlist = [];

                              if (widget.filter_location != null) {
                                filterappliedlist =
                                    filteredList.where((homefilterDataModel) {
                                  var locationData =
                                      jsonDecode(homefilterDataModel.location!);
                                  return locationData['location'] ==
                                      widget.filter_location;
                                }).toList();

                                homefilterDataModel = filterappliedlist[index];
                              } else if (widget.filter_district != null) {
                                filterappliedlist =
                                    filteredList.where((homefilterDataModel) {
                                  var locationData =
                                      jsonDecode(homefilterDataModel.location!);
                                  return locationData['district'] ==
                                      widget.filter_district;
                                }).toList();

                                homefilterDataModel = filterappliedlist[index];
                              } else if (widget.filter_state != null) {
                                filterappliedlist =
                                    filteredList.where((homefilterDataModel) {
                                  var locationData =
                                      jsonDecode(homefilterDataModel.location!);
                                  return locationData['state'] ==
                                      widget.filter_state;
                                }).toList();

                                homefilterDataModel = filterappliedlist[index];
                              } else {
                                homefilterDataModel = filteredList[index];
                              }

                              var locationData =
                                  jsonDecode(homefilterDataModel.location!);

                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16, bottom: 0, top: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailedPage(
                                          place: locationData['location'],
                                          district: locationData['district'],
                                          id: homefilterDataModel.id.toString(),
                                          shopName: homefilterDataModel.shopName
                                              .toString(),
                                          logo: homefilterDataModel.logo
                                              .toString(),
                                          frontImage: homefilterDataModel
                                              .frontImage
                                              .toString(),
                                          location: homefilterDataModel.location
                                              .toString(),
                                          address: homefilterDataModel.address
                                              .toString(),
                                          contactNo: homefilterDataModel
                                              .contactNo
                                              .toString(),
                                          website: homefilterDataModel.website
                                              .toString(),
                                          googlemap: homefilterDataModel
                                              .googlemaps
                                              .toString(),
                                          email: homefilterDataModel.email
                                              .toString(),
                                          instapage: homefilterDataModel
                                              .instapage
                                              .toString(),
                                          youtube: homefilterDataModel.youtube
                                              .toString(),
                                          marble: homefilterDataModel.marble
                                              .toString(),
                                          granite: homefilterDataModel.granite
                                              .toString(),
                                          tile: homefilterDataModel.tile
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 5),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image(
                                                      height:
                                                          screenWidth * 0.15,
                                                      width: screenWidth * 0.24,
                                                      fit: BoxFit.fill,
                                                      image: homefilterDataModel
                                                                  .frontImage
                                                                  ?.isNotEmpty ==
                                                              true
                                                          ? CachedNetworkImageProvider(
                                                              '$SHOPIMG${homefilterDataModel.frontImage}')
                                                          : const AssetImage(
                                                                  'assets/icons/oneone.jpg')
                                                              as ImageProvider,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      homefilterDataModel
                                                          .shopName
                                                          .toString(),
                                                      style: shopnamestyle,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      maxLines: 2,
                                                    ),
                                                    Text(
                                                      "${locationData['location']} , ${locationData['district']}",
                                                      style: subtitleTextStyle,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      maxLines: 3,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 3.0),
                                                          child: const Icon(
                                                              Icons
                                                                  .location_on_sharp,
                                                              color:
                                                                  Colors.black,
                                                              size: 16),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            homefilterDataModel
                                                                .address
                                                                .toString(),
                                                            style:
                                                                subtitleTextStyle,
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 3),
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.phone,
                                                            color: Colors.black,
                                                            size: 16),
                                                        const SizedBox(
                                                            width: 8),
                                                        Text(
                                                          homefilterDataModel
                                                              .contactNo
                                                              .toString(),
                                                          style:
                                                              subtitleTextStyle,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Wrap(
                                                      spacing: 8.0,
                                                      runSpacing: 8.0,
                                                      children: [
                                                        if (homefilterDataModel
                                                                .tile ==
                                                            'Yes')
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  nonselectedColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        16),
                                                            child: Text('Tile',
                                                                style:
                                                                    tilemarblesTextStyle),
                                                          ),
                                                        if (homefilterDataModel
                                                                .marble ==
                                                            'Yes')
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  nonselectedColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        16),
                                                            child: Text(
                                                                'Marble',
                                                                style:
                                                                    tilemarblesTextStyle),
                                                          ),
                                                        if (homefilterDataModel
                                                                .granite ==
                                                            'Yes')
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  nonselectedColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        16),
                                                            child: Text(
                                                                'Granite',
                                                                style:
                                                                    tilemarblesTextStyle),
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
