// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../utils/api_routes.dart';
import 'brand.dart';
import 'campaign_offer.dart';
import 'category.dart';
import 'discount.dart';
import 'rating_analytic.dart';
import 'review.dart';
import 'size.dart';
import 'size_info.dart';
import 'sub_category.dart';
import 'sub_sub_category.dart';
import 'variation.dart';
import 'variation_value_1.dart';
import 'variation_value_2.dart';

class Product {
  String id;
  String name;
  String thumbnail;
  String slug;
  String sku;
  double price;
  double buyingPrice;
  double vat;
  double advancePayment;
  bool freeDelivery;
  bool status;
  bool forOnline;
  bool featured;
  bool newArrival;
  bool topSelling;
  bool active;
  String description;
  String vendorId;
  String vendorName;
  String vendorImage;
  String vendorSlug;
  String barCode;
  List<Size> sizes;
  List<Variation> variations;
  String expireDate;
  int currentStock;
  List<String> images;
  Discount discount;
  Category category;
  SubCategory subCategory;
  SubSubCategory subSubCategory;
  Brand brand;
  int quantity;
  Size selectedSize;
  List<VariationValue1> variation1Values;
  List<VariationValue2> variation2Values;
  Variation selectedVariation;
  double currentPrice;
  List<CampaignOffer> campaignOffers;
  bool isCampaignOffer;
  String variationOne;
  String variationTwo;
  double salePrice;
  double campaignOfferPrice;
  int campaignDiscountType;
  double campaignOfferDiscount;
  String campaignEndDate;
  bool isWishListed;
  double rating;
  int totalRating;
  int totalReview;
  RatingAnalytic ratingAnalytic;
  List<Review> latestReviews;
  int variationType;
  List<SizeInfo> sizeInfos;
  String selectedSizeItem;
  int selectedInfoSizeStock;

  Product(
      {this.id,
      this.name,
      this.thumbnail,
      this.slug,
      this.sku,
      this.price,
      this.vat,
      this.freeDelivery,
      this.status,
      this.forOnline,
      this.featured,
      this.newArrival,
      this.topSelling,
      this.active,
      this.description,
      this.vendorId,
      this.vendorName,
      this.barCode,
      this.sizes,
      this.expireDate,
      this.currentStock,
      this.images,
      this.discount,
      this.category,
      this.subCategory,
      this.brand,
      this.quantity,
      this.selectedSize,
      this.currentPrice,
      this.subSubCategory,
      this.variations,
      this.selectedVariation,
      this.variation1Values,
      this.variation2Values,
      this.campaignOffers,
      this.buyingPrice,
      this.isCampaignOffer,
      this.variationOne,
      this.variationTwo,
      this.salePrice,
      this.vendorImage,
      this.vendorSlug,
      this.advancePayment,
      this.campaignOfferPrice,
      this.campaignDiscountType,
      this.campaignOfferDiscount,
      this.campaignEndDate,
      this.rating,
      this.totalRating,
      this.totalReview,
      this.ratingAnalytic,
      this.latestReviews,
      this.sizeInfos,
      this.variationType,
      this.selectedSizeItem,
      this.selectedInfoSizeStock});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];

    try {
      name = json['name'];
    } catch (error) {}

    try {
      thumbnail = APIRoute.BASE_URL + json['thumbnail'];
    } catch (error) {
      try {
        thumbnail = APIRoute.BASE_URL + json['image'];
      } catch (error) {}
    }

    try {
      slug = json['slug'];
    } catch (error) {}

    try {
      sku = json['sku'];
    } catch (error) {}

    try {
      price = double.parse(json['price'].toString());
    } catch (error) {}

    try {
      buyingPrice = double.parse(json['buyingPrice'].toString());
    } catch (error) {}

    try {
      vat = double.parse(json['vat'].toString());
    } catch (error) {}

    try {
      advancePayment = double.parse(json['advancePayment'].toString());
    } catch (error) {
      advancePayment = 0;
    }

    try {
      freeDelivery = json['freeDelivery'];
    } catch (error) {
      try {
        freeDelivery = (json['freeDelivery'] == "1");
      } catch (error) {}
    }

    try {
      status = json['status'] ?? false;
    } catch (error) {
      try {
        status = (json['status'] == "1");
      } catch (error) {}
    }

    try {
      forOnline = json['forOnline'] ?? false;
    } catch (error) {
      try {
        forOnline = (json['forOnline'] == "1");
      } catch (error) {}
    }

    try {
      featured = json['featured'] ?? false;
    } catch (error) {
      try {
        featured = (json['featured'] == "1");
      } catch (error) {}
    }

    try {
      newArrival = json['newArrival'] ?? false;
    } catch (error) {
      try {
        newArrival = (json['newArrival'] == "1");
      } catch (error) {}
    }

    try {
      topSelling = json['topSelling'] ?? false;
    } catch (error) {
      try {
        topSelling = (json['topSelling'] == "1");
      } catch (error) {}
    }

    try {
      active = json['active'] ?? false;
    } catch (error) {
      try {
        active = (json['active'] == "1");
      } catch (error) {}
    }

    try {
      description = json['description'];
    } catch (error) {}

    try {
      vendorId = json['vendorId'];
    } catch (error) {
      try {
        vendorId = json['vendor']['_id'];
      } catch (error) {}
    }

    try {
      vendorName = json['vendorName'];
    } catch (error) {
      try {
        vendorName = json['vendor']['name'];
      } catch (error) {}
    }

    try {
      vendorSlug = json['vendorSlug'];
    } catch (error) {
      try {
        vendorSlug = json['vendor']['slug'];
      } catch (error) {}
    }

    try {
      vendorImage = APIRoute.BASE_URL + json['vendorImg'];
    } catch (error) {
      try {
        vendorImage = APIRoute.BASE_URL + json['vendor']['image'];
      } catch (error) {}
    }

    try {
      barCode = json['barcode'];
    } catch (error) {}

    try {
      sizes = List();

      json['sizes'].forEach((size) {
        sizes.add(Size.fromJson(size));
      });
    } catch (error) {
      sizes = List();
    }

    try {
      variationType = json['variationType'];
    } catch (error) {
      try {
        variationType = int.parse(json['variationType']);
      } catch (error) {}
    }

    try {
      variations = List();

      var data = json['variations'];

      while (data.toString().contains("\"")) {
        data = jsonDecode(data);
      }

      data.forEach((variation) {
        variations.add(Variation.fromJson(variation));
      });
    } catch (error) {
      variations = List();
    }

    try {
      expireDate = json['expireDate'];
    } catch (error) {}

    try {
      currentStock = json['currentStock'];
    } catch (error) {
      try {
        currentStock = int.parse(json['currentStock']);
      } catch (error) {}
    }

    try {
      images = List();

      json['images'].forEach((image) {
        images.add(APIRoute.BASE_URL + image.toString());
      });
    } catch (error) {
      images = List();
    }

    try {
      discount = Discount.fromJson(json['discount']);
    } catch (error) {}

    try {
      category = Category.fromJson(json['category']);
    } catch (error) {}

    try {
      subCategory = SubCategory.fromJson(json['subcategory']);
    } catch (error) {}

    try {
      subSubCategory = SubSubCategory.fromJson(json['subsubcategory']);
    } catch (error) {}

    try {
      brand = Brand.fromJson(json['brand']);
    } catch (error) {}

    try {
      quantity = int.parse(json['quantity'].toString());
    } catch (error) {}

    try {
      selectedSize = Size.fromJson(json['selectedSize']);
    } catch (error) {}

    try {
      selectedVariation = Variation.fromJson(json['selectedVariation']);
    } catch (error) {}

    try {
      currentPrice = double.parse(json['currentPrice']);
    } catch (error) {}

    try {
      rating = double.parse(json['averageRating'].toString());
    } catch (error) {}

    try {
      totalRating = int.parse(json['totalRatingCount'].toString());
    } catch (error) {}

    try {
      ratingAnalytic = RatingAnalytic.fromJson(json['reviewInfo']);
    } catch (error) {}

    try {
      latestReviews = List();

      json['latestTwoReview'].forEach((review) {
        latestReviews.add(Review.fromJson(review));
      });
    } catch (error) {
      latestReviews = List();
    }

    try {
      campaignOffers = List();

      json['campaignOffer'].forEach((offer) {
        campaignOffers.add(CampaignOffer.fromJson(offer));
      });
    } catch (error) {
      campaignOffers = List();
    }

    variation1Values = [];
    variation2Values = [];

    try {
      isCampaignOffer = json['campaignOffer'];
    } catch (error) {
      try {
        isCampaignOffer = (json['campaignOffer'] == "1");
      } catch (error) {}
    }

    try {
      variationOne = json['variationOne'];
    } catch (error) {}

    try {
      variationTwo = json['variationTwo'];
    } catch (error) {}

    try {
      salePrice = double.parse(json['salePrice'].toString());
    } catch (error) {}

    try {
      campaignOfferPrice = double.parse(json['camPaignPrice'].toString());
    } catch (error) {}

    try {
      campaignDiscountType = int.parse(json['camPaignDiscountType'].toString());
    } catch (error) {}

    try {
      campaignOfferDiscount =
          double.parse(json['camPaignDiscountAmount'].toString());
    } catch (error) {}

    try {
      campaignEndDate = json['campaignEndDate'];
    } catch (error) {}

    try {
      sizeInfos = List();

      json['info2'].forEach((data) {
        sizeInfos.add(SizeInfo.fromJson(data));
      });
    } catch (error) {
      sizeInfos = List();
    }

    try {
      selectedSizeItem = json['selectedSizeItem'] ?? "";
    } catch (error) {}

    try {
      selectedInfoSizeStock = json['selectedInfoSizeStock'] == null
          ? 0
          : int.parse(json['selectedInfoSizeStock'].toString());
    } catch (error) {}
  }

  toJson() {
    return {
      "_id": id ?? "",
      "name": name ?? "",
      "thumbnail":
          thumbnail == null ? "" : thumbnail.split(APIRoute.BASE_URL)[1],
      "slug": slug ?? "",
      "sku": sku ?? "",
      "price": price == null ? "" : price.toString(),
      "vat": vat == null ? "" : vat.toString(),
      "freeDelivery": freeDelivery == null || freeDelivery == false ? "0" : "1",
      "status": status == null || status == false ? "0" : "1",
      "forOnline": forOnline == null || forOnline == false ? "0" : "1",
      "featured": featured == null || featured == false ? "0" : "1",
      "newArrival": newArrival == null || newArrival == false ? "0" : "1",
      "topSelling": topSelling == null || topSelling == false ? "0" : "1",
      "active": active == null || active == false ? "0" : "1",
      "description": description ?? "",
      "vendorId": vendorId ?? "",
      "vendorName": vendorName ?? "",
      "barcode": barCode ?? "",
      "sizes":
          jsonEncode(sizes.map((size) => size.toJson()).toList()).toString(),
      "variations":
          jsonEncode(variations.map((variation) => variation.toJson()).toList())
              .toString(),
      "expireDate": expireDate ?? "",
      "currentStock": currentStock == null ? "0" : currentStock.toString(),
      "images": images == null ? jsonEncode(List()) : jsonEncode(images),
      "discount": discount == null ? Discount().toJson() : discount.toJson(),
      "category": category == null
          ? Category(subCategories: List()).toJson()
          : category.toJson(),
      "subcategory":
          subCategory == null ? SubCategory().toJson() : subCategory.toJson(),
      "brand": brand == null ? Brand().toJson() : brand.toJson(),
      "quantity": quantity == null ? "" : quantity.toString(),
      "selectedSize":
          selectedSize == null ? Size().toJson() : selectedSize.toJson(),
      "selectedVariation": selectedVariation == null
          ? Variation().toJson()
          : selectedVariation.toJson(),
      "currentPrice": currentPrice == null ? "" : currentPrice.toString(),
      "advancePayment": advancePayment == null ? "" : advancePayment.toString(),
      "campaignOffer":
          isCampaignOffer == null || isCampaignOffer == false ? "0" : "1",
      "campaignEndDate": campaignEndDate == null ? "" : campaignEndDate,
      "variationType": variationType == null ? "1" : variationType.toString(),
      "selectedSizeItem": selectedSizeItem == null ? "" : selectedSizeItem,
      "selectedInfoSizeStock": selectedInfoSizeStock == null
          ? "0"
          : selectedInfoSizeStock.toString(),
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, thumbnail: $thumbnail, slug: $slug, sku: $sku, price: $price, buyingPrice: $buyingPrice, vat: $vat, advancePayment: $advancePayment, freeDelivery: $freeDelivery, status: $status, forOnline: $forOnline, featured: $featured, newArrival: $newArrival, topSelling: $topSelling, active: $active, description: $description, vendorId: $vendorId, vendorName: $vendorName, vendorImage: $vendorImage, vendorSlug: $vendorSlug, barCode: $barCode, sizes: $sizes, variations: $variations, expireDate: $expireDate, currentStock: $currentStock, images: $images, discount: $discount, category: $category, subCategory: $subCategory, subSubCategory: $subSubCategory, brand: $brand, quantity: $quantity, selectedSize: $selectedSize, variation1Values: $variation1Values, variation2Values: $variation2Values, selectedVariation: $selectedVariation, currentPrice: $currentPrice, campaignOffers: $campaignOffers, isCampaignOffer: $isCampaignOffer, variationOne: $variationOne, variationTwo: $variationTwo, salePrice: $salePrice, campaignOfferPrice: $campaignOfferPrice, campaignDiscountType: $campaignDiscountType, campaignOfferDiscount: $campaignOfferDiscount, campaignEndDate: $campaignEndDate, isWishListed: $isWishListed, rating: $rating, totalRating: $totalRating, totalReview: $totalReview, ratingAnalytic: $ratingAnalytic, latestReviews: $latestReviews, variationType: $variationType, sizeInfos: $sizeInfos, selectedSizeItem: $selectedSizeItem, selectedInfoSizeStock: $selectedInfoSizeStock)';
  }
}

class ProductItems {
  String title;
  List<Product> products;
  String slug;

  ProductItems({this.title, this.products, this.slug});

  ProductItems.fromJson(Map<String, dynamic> json) {
    try {
      title = json['title'];
    } catch (error) {}

    try {
      products = List();

      json['items'].forEach((product) {
        products.add(Product.fromJson(product));
      });
    } catch (error) {
      products = List();
    }

    try {
      slug = json['slug'] ?? "";
    } catch (error) {}
  }
}

class Products {
  List<Product> list;

  Products({this.list});

  Products.fromJson(dynamic data) {
    list = List();

    if (data != null) {
      data.forEach((product) {
        list.add(Product.fromJson(product));
      });
    }
  }

  @override
  String toString() => 'Products(list: $list)';
}

class DiscountedProducts {
  int totalProduct;
  int perPageProduct;
  List<Product> products;

  DiscountedProducts({this.totalProduct, this.perPageProduct, this.products});

  DiscountedProducts.fromJson(Map<String, dynamic> json) {
    try {
      totalProduct = int.parse(json['productLength'].toString());
    } catch (error) {}

    try {
      perPageProduct = int.parse(json['perPageProduct'].toString());
    } catch (error) {}

    try {
      products = List();

      json['product'].forEach((product) {
        products.add(Product.fromJson(product));
      });
    } catch (error) {
      products = List();
    }
  }
}
