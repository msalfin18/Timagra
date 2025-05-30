import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timagra_new/constants/urls.dart';
import 'package:timagra_new/model/models.dart';
import 'package:timagra_new/view/wishlist/wishlist.dart';

// class ShopController {
//   bool isLoading = true;
//   List<DataModel> shopList = [];

//   Future<void> fetchShops() async {
//     try {
//       final response = await http.get(Uri.parse('http://192.168.29.142/thinkay4_marbleshop/API/get_shop_list.php'));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         ShopListModel shopListModel = ShopListModel.fromJson(data);

//         if (shopListModel.status?.status == "success") {
//           shopList = shopListModel.data ?? [];

//           print(response.body);
//         }
//       }
//     } catch (e) {
//       print("Error fetching shops: $e");
//     } finally {
//       isLoading = false;
//     }
//   }
// }

class TileController {
  bool isLoading = true;
  List<TileCagoryDataModel> tileList = [];

  String IP = '';
  Future<void> fetchShops() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? IP = prefObj.getString('ip')?.trim();

    String url = TILE_HOME;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        TileCategoryModel tileCategoryModel = TileCategoryModel.fromJson(data);

        // Create the additional entry as a TileCagoryDataModel instance
        TileCagoryDataModel additionalEntry =
            TileCagoryDataModel(id: 3, productType: "All");

        // Assign the fetched data to tileList and prepend the additional entry
        tileList = [additionalEntry, ...?tileCategoryModel.data];

        // print(response.body);
      }
    } catch (e) {
      print("Error fetching shops: $e");
    } finally {
      isLoading = false;
    }
  }
}

class ProductDetailedController {
  bool isLoading = true;
  List<ProductDetailedDataModel> productDetaileddataList = [];

  Future<void> fetchShops() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? IP = prefObj.getString('ip')?.trim();

    String url = SHOPS_DETAILED;

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is Map<String, dynamic> &&
            data.containsKey("status") &&
            data.containsKey("data")) {
          DetailedStatus status = DetailedStatus.fromJson(data["status"]);

          if (status.status == "success") {
            List<dynamic> jsonData = data["data"];
            productDetaileddataList = jsonData
                .map((item) => ProductDetailedDataModel.fromJson(item))
                .toList();
          }
        }
      } else {
        print("Error: Status Code ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred: $e");
    } finally {
      isLoading = false;
    }
  }
}

class HomeFilterController {
  List<HomefilterDataModel> homefilterdataList = [];

  Future<void> fetchDatabase() async {
    try {
      SharedPreferences prefObj = await SharedPreferences.getInstance();
      String? IP = prefObj.getString('ip')?.trim();
      String? item = prefObj.getString('item')?.trim();

      String apiurl = "";

// item='all';

      if (item == "all") {
        apiurl = SHOPS_HOME;

        //  print('1111111111111111111111111111');

        // apiurl = '${MAIN_API}get_shop_list.php';
      } else {
        apiurl = SHOPS_HOME;

        // print('000000000000000000000000000000000000000');
      }

      final url = Uri.parse(apiurl);
      final response = await http.get(url);
      //  print(url);
      var result = jsonDecode(response.body);
      final statusCode = result['status']['status_code'];

      //   print(statusCode);
      if (statusCode == "200") {
        final Map<String, dynamic> data = result;
        //    print(result);

        final List<dynamic> homefilteredData = data['data'];
        //     print('list is $homefilteredData');
        homefilterdataList = homefilteredData
            .map((i) => HomefilterDataModel.fromJson(i))
            .toList();
      } else if (statusCode == "500") {
        homefilterdataList = [];
        //    print(homefilterdataList);
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}

//  state

class StateController {
  List<StateModel> stateList = [];

  Future<void> fetchDatabase() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();

    if (ip == null || ip.isEmpty) {
      print("IP address not found in SharedPreferences");
      return;
    }
    final url = Uri.parse(STATES);

    try {
      //   print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        final decodedData = jsonDecode(response.body);
        print(response.body);

        if (decodedData is List) {
          stateList = decodedData
              .map<StateModel>((i) => StateModel.fromJson(i))
              .toList();
        } else {
          stateList = [StateModel.fromJson(decodedData)];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}

class DistrictController {
  List<DistrictModel> districtList = [];

  Future<void> fetchDatabase() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? state = prefObj.getString('state')?.trim();

    if (ip == null || ip.isEmpty) {
      print("IP address not found in SharedPreferences");
      return;
    }
    final url = Uri.parse('$DISTRICT$state');

    try {
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        final decodedData = jsonDecode(response.body);
        print(response.body);

        if (decodedData is List) {
          districtList = decodedData
              .map<DistrictModel>((i) => DistrictModel.fromJson(i))
              .toList();
        } else {
          districtList = [DistrictModel.fromJson(decodedData)];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}




class LocationController {
  List<LocationModel> locationList = [];

  Future<void> fetchDatabase() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? location = prefObj.getString('location')?.trim();

    if (ip == null || ip.isEmpty) {
      print("IP address not found in SharedPreferences");
      return;
    }
    final url = Uri.parse('$LOCATION$location');

    print(url);

    try {
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        final decodedData = jsonDecode(response.body);
        print(response.body);

        if (decodedData is List) {
          locationList = decodedData
              .map<LocationModel>((i) => LocationModel.fromJson(i))
              .toList();
        } else {
          locationList = [LocationModel.fromJson(decodedData)];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}

// carusel controller

class CarouselhomeController {
  bool isLoading = true;
  List<CarouselModel> carouselList = [];

  Future<void> fetchShops() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? IP = prefObj.getString('ip')?.trim();

    String url = CAROUSELSLIDER;

    print(CAROUSELSLIDER);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<dynamic> jsonData = data["data"];
        carouselList =
            jsonData.map((item) => CarouselModel.fromJson(item)).toList();

        //print(response.body);
      } else {
        print("Error: Status Code ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred: $e");
    } finally {
      isLoading = false;
    }
  }
}

// product detailed model

class DetailedProductController {
  List<DetailedProductModel> detailedproductList = [];

  Future<void> fetchProducts(String id) async {
    final response = await http.post(
      Uri.parse(DETAILEDPRODUCT),
      body: {'id': id},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> detailedproductData = data['data'];

      print(response.body);

      detailedproductList = detailedproductData
          .map((json) => DetailedProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class StateDropDownController {
  List<String> locationList = [];

  Future<void> fetchDatabase() async {
    final url = Uri.parse(LOCATION);

    try {
      print('Fetching from: $url');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('Response: ${response.body}');

        // Decode JSON
        Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Extract top-level keys from "data"
        if (jsonData.containsKey("data")) {
          locationList = jsonData["data"].keys.toList().cast<String>();
        } else {
          print("Error: 'data' key not found in response");
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}




//WISHLIST


class WishlistController {
  List<WishlistModel> wishList = [];

SharedPreferences? _readobj;
  late String userid;

  Future<void> fetchwishlist() async {
    
        _readobj = await SharedPreferences.getInstance();
      userid = _readobj?.getString('Userid') ?? "000000";


// String url = 'http://192.168.29.50/thinkay4_marbleshop/API/user_get_wishlist.php' ;

print(WISHLIST);
print(userid);
    final response = await http.post( Uri.parse(WISHLIST),
      body: {'userid': userid},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> wishListData = data['data'];

      print(response.body);

      wishList = wishListData
          .map((json) => WishlistModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}