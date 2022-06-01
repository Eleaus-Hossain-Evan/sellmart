import 'dart:convert';

import '../model/cart_item.dart';
import '../model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DBHelper {

  Database database;

  final String dbName = "Ecomm.db";
  final int version1 = 1;

  final String cartTable = "Cart";
  final columnList = {"ID", "Name"};
  final String column1 = "ID";
  final String column2 = "Product";

  Future<Database> get db async {

    if(database != null) {
      return database;
    }
    else {
      database = await initDB();
      return database;
    }
  }

  Future<String> getDbPath() async {

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath + dbName);
    return path;
  }

  initDB() async {

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    var db = await openDatabase(path, version: version1, onCreate: _onCreate, onConfigure: _onConfigure);
    return db;
  }

  _onCreate(Database db, int version) async {

    String sql = "CREATE TABLE $cartTable ($column1 INTEGER PRIMARY KEY AUTOINCREMENT, $column2 TEXT)";
    await db.execute(sql);
  }

  _onConfigure(Database db) async {

    await db.rawQuery("PRAGMA journal_mode = PERSIST");
  }

  Future<int> addProduct(Product product) async {

    List<CartItem> cartList = await getCartItems();

    bool matchFound = false;
    int index = 0;
    int id = 0;

    for(int i=0; i<cartList.length; i++) {

      if(product.variationType == 0 || product.variationType == 1) {

        if(product.selectedVariation != null && cartList[i].product.selectedVariation != null
            && product.selectedVariation.id == cartList[i].product.selectedVariation.id
            && product.currentPrice == cartList[i].product.currentPrice && product.isCampaignOffer == cartList[i].product.isCampaignOffer) {

          index = i;
          matchFound = true;
          cartList[i].product.quantity = cartList[i].product.quantity + product.quantity;
          break;
        }
      }
      else if(product.variationType == 2) {

        if(product.selectedSizeItem != null && cartList[i].product.selectedSizeItem != null
            && product.selectedSizeItem == cartList[i].product.selectedSizeItem
            && product.currentPrice == cartList[i].product.currentPrice && product.isCampaignOffer == cartList[i].product.isCampaignOffer) {

          index = i;
          matchFound = true;
          cartList[i].product.quantity = cartList[i].product.quantity + product.quantity;
          break;
        }
      }
    }

    if(matchFound) {

      id = await updateProduct(cartList[index].position, cartList[index].product);
    }
    else {

      var dbClient = await db;

      id = await dbClient.insert(cartTable, {
        column2: json.encode(product).toString(),
      });
    }

    return id;
  }

  Future<int> getProductCount() async {

    await getCartItems();

    var dbClient = await db;

    List<Map> records = await dbClient.query(cartTable);
    return records.length;
  }

  Future<List<CartItem>> getCartItems() async {

    var dbClient = await db;
    List<CartItem> cartItems = [];

    List<Map> maps = await dbClient.query(cartTable, columns: [column1, column2]);

    maps.forEach((map) {

      var data = json.decode(map[column2]);

      Product product = Product.fromJson(data);

      if(product.isCampaignOffer) {

        if(product.campaignEndDate != null && product.campaignEndDate.isNotEmpty && DateTime.parse(product.campaignEndDate).isAfter(DateTime.now())) {

          cartItems.add(CartItem(map[column1], product, true));
        }
        else {

          deleteProduct(map[column1]);
        }
      }
      else {

        cartItems.add(CartItem(map[column1], product, true));
      }
    });

    return cartItems;
  }

  Future<int> deleteProduct(int position) async {

    var dbClient = await db;
    return await dbClient.delete(cartTable, where: "$column1 = ?", whereArgs: [position]);
  }

  Future<int> deleteAllProduct() async {

    var dbClient = await db;
    return await dbClient.delete(cartTable, where: "1");
  }

  Future<int> updateProduct(int position, Product product) async {

    var dbClient = await db;

    return await dbClient.update(cartTable, {
      column2: json.encode(product).toString(),
    }, where: "$column1 = ?", whereArgs: [position]);
  }

  Future close() async {

    var dbClient = await db;
    dbClient.close();
  }
}