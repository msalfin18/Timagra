import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:timagra_new/constants/constants.dart';
import 'package:timagra_new/constants/search.dart';
import 'package:timagra_new/view/homepage.dart';

class StatefilterPage extends StatefulWidget {
  String location ;
  StatefilterPage({super.key , required this.location});

  @override
  State<StatefilterPage> createState() => _StatefilterPageState();
}

class _StatefilterPageState extends State<StatefilterPage> {
  String? selectedState;
  String? selectedDistrict;
  String? selectedLocation;
  String ? _location ;
  Map<String, dynamic> locationData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse("https://thinkersstemhub.com/MARBLESHOP/API/get_location.php"));
    if (response.statusCode == 200) {
      setState(() {
        locationData = json.decode(response.body)['data'];
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
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
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
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Homepage(
                 filter_location: _location,
    
                    )));
          // _district = '${place.locality}';
        });
      } else {
        setState(() {
          _location = 'Could not fetch address.';
        });
      }
    } else if (permissionStatus.isDenied) {
      setState(() {
        _location = 'Location permissions are denied.';
      });
    } else if (permissionStatus.isPermanentlyDenied) {
      setState(() {
        _location =
            'Location permissions are permanently denied. Please enable them in the app settings.';
      });
      openAppSettings(); // Open app settings to allow manual permission enabling
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: nonselectedColor,
      appBar: AppBar(
        title: Text('Filters', style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
    backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:  3.0),
            child: Column(
              
              children: [
                GestureDetector(
                  onTap: (){

   fetchLocation();

               
                  },
                  child: Container(
                      color: Colors.white,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 28.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.my_location_outlined , color: const Color.fromARGB(255, 0, 140, 255), size: 30,),
                                    SizedBox(width: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('use current location', style: TextStyle(color:  const Color.fromARGB(255, 0, 140, 255), fontWeight: FontWeight.bold , fontSize: 16),),
                                        Text(widget.location)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:  16.0 , right: 16 , top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Location',
                          style: TextStyle(
                            color: const Color.fromARGB(221, 41, 41, 41),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                
                      // State selection dropdown
                      buildDropdown(
                        'Select State',
                        selectedState,
                        locationData.keys.toList(),
                        (newState) {
                          setState(() {
                            selectedState = newState;
                            selectedDistrict = null;
                            selectedLocation = null;
                          });
                        },
                      ),
                
                      SizedBox(height: 10),
                
                      // District selection dropdown
                      buildDropdown(
                        'Select District',
                        selectedDistrict,
                        selectedState != null ? locationData[selectedState!]!.keys.toList() : [],
                        (newDistrict) {
                          setState(() {
                            selectedDistrict = newDistrict;
                            selectedLocation = null;
                          });
                        },
                      ),
                
                      SizedBox(height: 10),
                
                      // Location selection dropdown
                      buildDropdown(
                        'Select Location',
                        selectedLocation,
                        selectedState != null && selectedDistrict != null
                            ? List<String>.from(locationData[selectedState!]![selectedDistrict!])
                            : [],
                        (newLocation) {
                          setState(() {
                            selectedLocation = newLocation;
                          });
                        },
                      ),
                
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
    
                            if( selectedLocation != null || selectedState != null || selectedLocation != null){
    
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Homepage(
                              filter_district: selectedDistrict,
                              filter_location: selectedLocation,
                              filter_state: selectedState,
                            )));
                
                            }else{
    
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Select location')));
                            }
    
                          
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttoncolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Apply Filters',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String hint, String? value, List<String> items, void Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: greycolor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
          alignment: Alignment.centerLeft,
          autofocus: true,
          borderRadius: BorderRadius.circular(5),
          elevation: 2,
          decoration: InputDecoration(
            border: dropdownborder,
            errorBorder: dropdownborder,
            enabledBorder: dropdownborder,
            focusedBorder: dropdownborder,
            disabledBorder: dropdownborder,
            focusedErrorBorder: dropdownborder,
            enabled: true,
          ),
          value: value,
          hint: Text(hint, style: TextStyle(color: Colors.black)),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
