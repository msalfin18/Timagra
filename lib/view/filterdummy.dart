// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timagra_new/constants/constants.dart';
// import 'package:timagra_new/constants/search.dart';
// import 'package:timagra_new/controllers/controllers.dart';
// import 'package:timagra_new/model/models.dart';


// class StatefilterPage extends StatefulWidget {
//   List categoriesList = [];

//   StatefilterPage({super.key, required this.categoriesList});

//   @override
//   State<StatefilterPage> createState() => _StatefilterPageState();
// }

// class _StatefilterPageState extends State<StatefilterPage> {



//   String? selectedValue;
//   String? selectedDistrict;
//   String? selectedLocation;

//   List<String> selectedItemsList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     fetchCategories();
//     print(widget.categoriesList);
//   }

//   Future<void> fetchData() async {
//     try {
    

//       setState(() {});
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to fetch state data.")),
//       );
//     }
//   }

//   Future<void> fetchCategories() async {
//     try {
//       await _stateDropDownController.fetchDatabase();

//       setState(() {
  
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to fetch state data.")),
//       );
//     }
//   }

//   // Future<void> saveUserData(String state) async {
//   //   SharedPreferences prefobj = await SharedPreferences.getInstance();
//   //   await prefobj.setString('state', state);
//   //   print(state);
//   //   setState(() {
//   //     selectedDistrict = null;
//   //     _districtController.districtList.clear();
//   //   });
//   //   fetchDistrict();
//   // }

//   // Future<void> fetchDistrict() async {
//   //   try {
//   //     await _districtController.fetchDatabase(); // Fetch the new district data
//   //     setState(() {
//   //       // If no districts are found, reset the district list or set it to an empty list
//   //       if (_districtController.districtList.isEmpty) {
//   //         selectedDistrict = null; // Ensure no district is selected
//   //       }
//   //     });
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text("Failed to fetch district data.")),
//   //     );
//   //   }
//   // }

//   // Future<void> saveUserlocation(String location) async {
//   //   SharedPreferences prefobj = await SharedPreferences.getInstance();
//   //   await prefobj.setString('location', location);
//   //   print(location);
//   //   setState(() {
//   //     selectedLocation = null;
//   //     _locationController.locationList.clear();
//   //   });
//   //   fetchlocation();
//   // }

//   // Future<void> fetchlocation() async {
//   //   try {
//   //     await _locationController.fetchDatabase(); // Fetch the new district data
//   //     setState(() {
//   //       // If no districts are found, reset the district list or set it to an empty list
//   //       if (_locationController.locationList.isEmpty) {
//   //         selectedLocation = null; // Ensure no district is selected
//   //       }
//   //     });
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text("Failed to fetch district data.")),
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: nonselectedColor,
//       appBar: AppBar(
//         surfaceTintColor: Colors.white,
//         backgroundColor: Colors.white,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
              
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Location',
//                     style: TextStyle(
//                       color: const Color.fromARGB(221, 41, 41, 41),
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),

//                 // drop down 1 (State selection)
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(
//                       color: greycolor,
//                       width: 1.5,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   alignment: Alignment.centerLeft,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: DropdownButtonFormField<String>(
//                       dropdownColor: Colors.white,
//                       alignment: Alignment.centerLeft,
//                       autofocus: true,
//                       borderRadius: BorderRadius.circular(5),
//                       elevation: 2,
//                       decoration: InputDecoration(
//                         border: dropdownborder,
//                         errorBorder: dropdownborder,
//                         enabledBorder: dropdownborder,
//                         focusedBorder: dropdownborder,
//                         disabledBorder: dropdownborder,
//                         focusedErrorBorder: dropdownborder,
//                         enabled: true,
//                       ),
//                       value: selectedValue, // Default value null
//                       hint: Text(
//                         'Select State',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       items: [
//                         DropdownMenuItem<String>(
//                           value: null, // Default value
//                           child: Text('Select State',),
//                         ),
//                         // Ensure no duplicate values are here
//                         // ..._stateController.stateList.map((StateModel state) {
//                         //   return DropdownMenuItem<String>(
//                         //     value:
//                         //         state.id.toString(), // Unique value for selection
//                         //     child: Text(state.state ?? "Unknown"),
//                         //   );
//                         // }).toList(),
//                       ],
//                       onChanged: (newState) {
//                         if (newState != selectedValue) {
//                           setState(() {
//                             selectedValue = newState;
//                             selectedDistrict = null;
//                             // _districtController.districtList.clear();
//                           });
                    
//                           // saveUserData(newState.toString());
//                           print('State selected: $newState');
                    
//                           // After saving user data, fetch districts again
//                           // fetchDistrict();
//                         }
//                       },
//                     ),
//                   ),
//                 ),

//                 // drop down 2 (District selection)
//                 SizedBox(height: 10),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
                    
//                     border: Border.all(
//                       color: greycolor,
//                       width: 1.5,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   alignment: Alignment.centerLeft,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: DropdownButtonFormField<String>(
//                       dropdownColor: Colors.white,
//                       alignment: Alignment.centerLeft,
//                       autofocus: true,
//                       borderRadius: BorderRadius.circular(5),
//                       elevation: 2,
//                       // icon:Icon(Icons.abc)
//                       decoration: InputDecoration(
                   
//                         border: dropdownborder,
//                         errorBorder: dropdownborder,
//                         enabledBorder: dropdownborder,
//                         focusedBorder: dropdownborder,
//                         disabledBorder: dropdownborder,
//                         focusedErrorBorder: dropdownborder,
//                         enabled: true,
//                       ),
//                       value: selectedDistrict, // Default value null
//                       hint: Text(
//                         'Select District',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       items: [
//                         DropdownMenuItem<String>(
//                           value: null, // Default value
//                           child: Text('Select District'),
//                         ),
//                         // ..._districtController.districtList
//                         //     .map((DistrictModel districtModel) {
//                         //   return DropdownMenuItem<String>(
//                         //     value: districtModel.id
//                         //         .toString(), // Unique value for selection
//                         //     child: Text(districtModel.district ?? "Unknown"),
//                         //   );
//                         // }).toList(),
//                       ],
//                       onChanged: (newDistrict) {
//                         if (newDistrict != selectedDistrict) {
//                           setState(() {
//                             selectedDistrict =
//                                 newDistrict; // Update the selected district
                    
//                             selectedLocation = null;
//                             // _locationController.locationList.clear();
//                           });
                    
//                           // saveUserlocation(newDistrict.toString());
//                           print('District selected: $newDistrict');
//                         }
//                       },
//                     ),
//                   ),
//                 ),

// // drop down 3

//                 SizedBox(height: 10),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
                    
//                     border: Border.all(
                      
//                       color: greycolor,
//                       width: 1.5,
//                     ),
//                    borderRadius: BorderRadius.circular(10),
//                   ),
//                   alignment: Alignment.centerLeft,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: DropdownButtonFormField<String>(
//                       dropdownColor: Colors.white,
//                       alignment: Alignment.centerLeft,
//                       autofocus: true,
//                       borderRadius: BorderRadius.circular(5),
//                       elevation: 2,
//                       decoration: InputDecoration(
//                         border: dropdownborder,
//                         errorBorder: dropdownborder,
//                         enabledBorder: dropdownborder,
//                         focusedBorder: dropdownborder,
//                         disabledBorder: dropdownborder,
//                         focusedErrorBorder: dropdownborder,
//                         enabled: true,
//                       ),
//                       value: selectedLocation, // Default value null
//                       hint: Text(
//                         'Select Location',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       items: [
//                         DropdownMenuItem<String>(
//                           value: null, // Default value
//                           child: Text('Select Location'),
//                         ),
//                         // ..._locationController.locationList
//                         //     .map((LocationModel locationModel) {
//                         //   return DropdownMenuItem<String>(
//                         //     value: locationModel.id
//                         //         .toString(), // Unique value for selection
//                         //     child: Text(locationModel.location ?? "Unknown"),
//                         //   );
//                         // }).toList(),
//                       ],
//                       onChanged: (newLocation) {
//                         if (newLocation != selectedLocation) {
//                           setState(() {
//                             selectedLocation =
//                                 newLocation; // Update the selected district
//                           });
                    
//                           // Optionally save district data if needed
//                           // saveUserlocation(newLocation.toString());
//                           print('location selected: $newLocation');
//                         }
//                       },
//                     ),
//                   ),
//                 ),

//                 // const SizedBox(height: 10),
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Text(
//                 //     'Categories',
//                 //     style: TextStyle(
//                 //       color: const Color.fromARGB(221, 41, 41, 41),
//                 //       fontSize: 18,
//                 //       fontWeight: FontWeight.w600,
//                 //     ),
//                 //   ),
//                 // ),

//                 // GridView.builder(
//                 //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 //         childAspectRatio: 1.5,
//                 //         // mainAxisExtent: double.infinity,
//                 //         crossAxisSpacing: 10,
//                 //         mainAxisSpacing: 10,
//                 //         crossAxisCount: 2),
//                 //     shrinkWrap:
//                 //         true, // Allow GridView to take up only the necessary space
//                 //     physics:
//                 //         NeverScrollableScrollPhysics(), // Disable scrolling for GridView
//                 //     itemCount: widget.categoriesList.length,
//                 //     itemBuilder: (context, index) {
//                 //       print(widget.categoriesList.length);
//                 //       TileCagoryDataModel tileCategoryModel =
//                 //           widget.categoriesList[index];

//                 //       return GestureDetector(
//                 //         onTap: () {
//                 //           setState(() {
//                 //             // Toggle item in the list: add if not present, remove if present
//                 //             if (selectedItemsList.contains(
//                 //                 tileCategoryModel.productType.toString())) {
//                 //               selectedItemsList.remove(
//                 //                   tileCategoryModel.productType.toString());
//                 //             } else {
//                 //               selectedItemsList.add(
//                 //                   tileCategoryModel.productType.toString());
//                 //             }
//                 //           });

//                 //           print(selectedItemsList.toString());
//                 //         },
//                 //         child: Container(
//                 //           width: double.infinity,
//                 //           // width: 160,
//                 //           height: 120,
//                 //           decoration: BoxDecoration(
//                 //             color: Colors.white,
//                 //             border: Border.all(
//                 //               color: greycolor,
//                 //               width: 1.5,
//                 //             ),
//                 //             borderRadius: BorderRadius.circular(10),
//                 //           ),

//                 //           child: Column(
//                 //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //             children: [
//                 //               Image(
//                 //                 image: slectedimg,
//                 //                 height: 30,
//                 //               ),
//                 //               Text(
//                 //                 tileCategoryModel.productType.toString(),
//                 //                 style: TextStyle(
//                 //                     color: Colors.black,
//                 //                     fontSize: 16,
//                 //                     fontWeight: FontWeight.w500),
//                 //               )
//                 //             ],
//                 //           ),
//                 //         ),
//                 //       );

//                 //       // Text(tileCategoryModel.productType.toString());
//                 //     })

//                 // // Row(
//                 // //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 // //   // mainAxisSize: MainAxisSize.max/,
//                 // //   crossAxisAlignment: CrossAxisAlignment.start,
//                 // //   children: [
//                 // //     Spacer(),
//                 // //     Container(
//                 // //       //  width: double.infinity,
//                 // //       width: 160,
//                 // //       height: 120,
//                 // //       decoration: BoxDecoration(
//                 // //         color: Colors.white,
//                 // //         border: Border.all(
//                 // //           color: greycolor,
//                 // //           width: 1.5,
//                 // //         ),
//                 // //         borderRadius: BorderRadius.circular(10),
//                 // //       ),

//                 // //       child: Column(
//                 // //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 // //         children: [
//                 // //           Image(
//                 // //             image: slectedimg,
//                 // //             height: 30,
//                 // //           ),
//                 // //           Text(
//                 // //             'All',
//                 // //             style:
//                 // //                 TextStyle(color: slectedtextblue, fontSize: 16),
//                 // //           )
//                 // //         ],
//                 // //       ),
//                 // //     ),
//                 // //     Spacer(),
//                 // //     SizedBox(
//                 // //       width: 16,
//                 // //     ),
//                 // //     Container(
//                 // //       //  width: double.infinity,
//                 // //       width: 160,
//                 // //       height: 120,
//                 // //       decoration: BoxDecoration(
//                 // //         color: Colors.white,
//                 // //         border: Border.all(
//                 // //           color: greycolor,
//                 // //           width: 1.5,
//                 // //         ),
//                 // //         borderRadius: BorderRadius.circular(10),
//                 // //       ),

//                 // //       child: Column(
//                 // //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 // //         children: [
//                 // //           Image(
//                 // //             image: slectedimg,
//                 // //             height: 30,
//                 // //           ),
//                 // //           Text(
//                 // //             'Tiles',
//                 // //             style:
//                 // //                 TextStyle(color: slectedtextblue, fontSize: 16),
//                 // //           )
//                 // //         ],
//                 // //       ),
//                 // //     ),
//                 // //     Spacer(),
//                 // //   ],
//                 // // ),

//                 // ,
//                 SizedBox(height: 10,),
//              SizedBox(
//                          // width: 200,
//                          width: double.infinity,
//                          height: 60,
//                          child: ElevatedButton(onPressed: (){},
//                          style: ElevatedButton.styleFrom(
//                            backgroundColor: buttoncolor,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(16),
                    
//                            )
//                          ),
//                           child: Text('Apply Filters' ,style: TextStyle(
//                            color: Colors.white, fontSize: 18 , fontWeight: FontWeight.w600
//                           ),)))
//               ],
//             ),
//           ),
//         ),

        
//       ),
// // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //       floatingActionButton: 
//     );
//   }
// }
