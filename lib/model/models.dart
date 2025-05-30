class ShopListModel {
  List<DataModel>? data;
  Status? status;

  ShopListModel({
    this.data,
    this.status,
  });

  factory ShopListModel.fromJson(Map<String, dynamic> json) => ShopListModel(
        data: json["data"] == null
            ? []
            : List<DataModel>.from(
                json["data"]!.map((x) => DataModel.fromJson(x))),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status?.toJson(),
      };
}

class DataModel {
  int? id;
  String? shopName;
  String? logo;
  String? frontImage;
  Map<String, dynamic>? location;
  String? address;
  String? contactNo;
  String? website;
  String? googlemaps;
  String? email;
  String? instapage;
  String? youtube;
  String? marble;
  String? granite;
  String? tile;

  DataModel({
    this.id,
    this.shopName,
    this.logo,
    this.frontImage,
    this.location,
    this.address,
    this.contactNo,
    this.website,
    this.googlemaps,
    this.email,
    this.instapage,
    this.youtube,
    this.marble,
    this.granite,
    this.tile,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json["id"] ?? "",
        shopName: json["shop_name"] ?? "",
        logo: json["logo"] ?? "",
        frontImage: json["front_image"] ?? "",
        location: json["location"] ?? "",
        address: json["address"] ?? "",
        contactNo: json["contact_no"] ?? "",
        website: json["website"] ?? "",
        googlemaps: json["google_map"] ?? "",
        email: json["email"] ?? "",
        instapage: json["instapage"] ?? "",
        youtube: json["youtube"] ?? "",
        marble: json["marble"] ?? "",
        granite: json["granite"] ?? "",
        tile: json["tile"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_name": shopName,
        "logo": logo,
        "front_image": frontImage,
        "location": location,
        "address": address,
        "contact_no": contactNo,
        "website": website,
        "googlemaps": googlemaps,
        "email": email,
        "instapage": instapage,
        "youtube": youtube,
        "marble": marble,
        "granite": granite,
        "tile": tile,
      };
}

class Status {
  String? statusCode;
  String? status;

  Status({
    this.statusCode,
    this.status,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        statusCode: json["status_code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
      };
}

class TileCategoryModel {
  List<TileCagoryDataModel>? data;
  Status? status;

  TileCategoryModel({
    this.data,
    this.status,
  });

  factory TileCategoryModel.fromJson(Map<String, dynamic> json) =>
      TileCategoryModel(
        data: json["data"] == null
            ? []
            : List<TileCagoryDataModel>.from(
                json["data"]!.map((x) => TileCagoryDataModel.fromJson(x))),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status?.toJson(),
      };
}

class TileCagoryDataModel {
  int? id;
  String? productType;

  TileCagoryDataModel({
    this.id,
    this.productType,
  });

  factory TileCagoryDataModel.fromJson(Map<String, dynamic> json) =>
      TileCagoryDataModel(
        id: json["id"],
        productType: json["product_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_type": productType,
      };
}

class TileStatus {
  String? statusCode;
  String? status;

  TileStatus({
    this.statusCode,
    this.status,
  });

  factory TileStatus.fromJson(Map<String, dynamic> json) => TileStatus(
        statusCode: json["status_code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
      };
}

// carousel slider

class CarouselModel {
  int id;
  String banner;

  CarouselModel({
    required this.id,
    required this.banner,
  });

  factory CarouselModel.fromJson(Map<String, dynamic> json) => CarouselModel(
        id: json["id"],
        banner: json["banner"],
      );
}

class ProductDetailedModel {
  List<ProductDetailedDataModel>? data;
  Status? status;

  ProductDetailedModel({
    this.data,
    this.status,
  });

  factory ProductDetailedModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailedModel(
        data: json["data"] == null
            ? []
            : List<ProductDetailedDataModel>.from(
                json["data"]!.map((x) => ProductDetailedDataModel.fromJson(x))),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status?.toJson(),
      };
}

class ProductDetailedDataModel {
  int? id;
  String? productType;
  String? productName;
  String? productCode;
  String? description;
  String? priceRange;
  String? productImage1;
  String? productImage2;
  String? productImage3;

  ProductDetailedDataModel({
    this.id,
    this.productType,
    this.productName,
    this.productCode,
    this.description,
    this.priceRange,
    this.productImage1,
    this.productImage2,
    this.productImage3,
  });

  factory ProductDetailedDataModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailedDataModel(
        id: json["id"] ?? "",
        productType: json["product_type"] ?? "",
        productName: json["product_name"] ?? "",
        productCode: json["product_code"] ?? "",
        description: json["description"] ?? "",
        priceRange: json["price_range"] ?? "",
        productImage1: json["product_image_1"] ?? "",
        productImage2: json["product_image_2"] ?? "",
        productImage3: json["product_image_3"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_type": productType,
        "product_name": productName,
        "product_code": productCode,
        "description": description,
        "price_range": priceRange,
        "product_image_1": productImage1,
        "product_image_2": productImage2,
        "product_image_3": productImage3,
      };
}

class DetailedStatus {
  String? statusCode;
  String? status;

  DetailedStatus({
    this.statusCode,
    this.status,
  });

  factory DetailedStatus.fromJson(Map<String, dynamic> json) => DetailedStatus(
        statusCode: json["status_code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
      };
}

//   filter

class HomefilterDataModel {
  int? id;
  String? shopName;
  String? logo;
  String? frontImage;
  String? location;
  String? address;
  String? contactNo;
  String? website;
  String? googlemaps;
  String? email;
  String? instapage;
  String? youtube;
  String? marble;
  String? granite;
  String? tile;

  HomefilterDataModel({
    this.id,
    this.shopName,
    this.logo,
    this.frontImage,
    this.location,
    this.address,
    this.contactNo,
    this.website,
    this.googlemaps,
    this.email,
    this.instapage,
    this.youtube,
    this.marble,
    this.granite,
    this.tile,
  });

  factory HomefilterDataModel.fromJson(Map<String, dynamic> json) =>
      HomefilterDataModel(
        id: json["id"] ?? '',
        shopName: json["shop_name"] ?? '',
        logo: json["logo"] ?? '',
        frontImage: json["front_image"] ?? '',
        location: json["location"] ?? '',
        address: json["address"] ?? '',
        contactNo: json["contact_no"] ?? '',
        website: json["website"] ?? '',
        googlemaps: json["google_map"] ?? "",
        email: json["email"] ?? '',
        instapage: json["instapage"] ?? '',
        youtube: json["youtube"] ?? '',
        marble: json["marble"] ?? '',
        granite: json["granite"] ?? '',
        tile: json["tile"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_name": shopName,
        "logo": logo,
        "front_image": frontImage,
        "location": location,
        "address": address,
        "contact_no": contactNo,
        "website": website,
        "googlemaps": googlemaps,
        "email": email,
        "instapage": instapage,
        "youtube": youtube,
        "marble": marble,
        "granite": granite,
        "tile": tile,
      };
}

//  state

class StateModel {
  int? id;
  String? state;
  String? deleteStatus;

  StateModel({
    this.id,
    this.state,
    this.deleteStatus,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        id: json["id"] ?? "",
        state: json["state"] ?? "",
        deleteStatus: json["delete_status"] ?? "",
      );
}

class DistrictModel {
  int? id;
  String? state;
  String? district;
  String? deleteStatus;

  DistrictModel({
    this.id,
    this.state,
    this.district,
    this.deleteStatus,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        id: json["id"] ?? "",
        state: json["state"] ?? "",
        district: json["district"] ?? "",
        deleteStatus: json["delete_status"] ?? "",
      );
}

class LocationModel {
  int? id;
  String? state;
  String? district;
  String? location;
  String? deleteStatus;

  LocationModel({
    this.id,
    this.state,
    this.district,
    this.location,
    this.deleteStatus,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json["id"] ?? "",
        state: json["state"] ?? "",
        district: json["district"] ?? "",
        location: json["location"] ?? "",
        deleteStatus: json["delete_status"] ?? "",
      );
}

//detailed product

class DetailedProductModel {
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

  DetailedProductModel({
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
  });

  factory DetailedProductModel.fromJson(Map<String, dynamic> json) {
    return DetailedProductModel(
      id: json['id'],
      productType: json['product_type'],
      productName: json['product_name'],
      productCode: json['product_code'],
      description: json['description'],
      priceRange: json['price_range'],
      quality: json['quality'],
      size: json['size'],
      measurement: json['measurement'],
      productImage1: json['product_image_1'],
    );
  }
}




// wishlist


class WishlistModel {
    int id;
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
    int sid;
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

    WishlistModel({
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
    });

    factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        id: json["id"],
        productType: json["product_type"],
        productName: json["product_name"],
        productCode: json["product_code"],
        description: json["description"],
        priceRange: json["price_range"],
        quality: json["quality"],
        size: json["size"],
        measurement: json["measurement"],
        productImage1: json["product_image_1"],
        productImage2: json["product_image_2"],
        productImage3: json["product_image_3"],
        sid: json["sid"],
        shopName: json["shop_name"],
        logo: json["logo"],
        frontImage: json["front_image"],
        location: json["location"],
        address: json["address"],
        contactNo: json["contact_no"],
        website: json["website"],
        email: json["email"],
        instapage: json["instapage"],
        youtube: json["youtube"],
        marble: json["marble"],
        granite: json["granite"],
        tile: json["tile"],
    );
}