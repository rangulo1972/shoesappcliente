import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesappclient/models/brand_model.dart';
import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/models/user_model.dart';

class FirestoreService {
  Future<List<ProductModel>> getProducts() async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("products");

    QuerySnapshot collection = await reference.get();

    List<QueryDocumentSnapshot> docs = collection.docs;

    List<ProductModel> products = [];

    List<BrandModel> brands = await getBrand();

    products = docs.map((e) {
      ProductModel model =
          ProductModel.fromJson(e.data() as Map<String, dynamic>);
      String newBrand =
          brands.where((element) => element.id == model.brand).first.name;
      model.brand = newBrand;
      return model;
    }).toList();

    // for (QueryDocumentSnapshot item in docs) {
    //   ProductModel product =
    //       ProductModel.fromJson(item.data() as Map<String, dynamic>);

    //   products.add(product);
    //   print(product.toJson());
    // }

    return products;
  }

//**--------------------------------------------------------------- */
  Future<List<BrandModel>> getBrand() async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("brands");
    QuerySnapshot collection = await reference.get();
    List<QueryDocumentSnapshot> docs = collection.docs;
    List<BrandModel> brands = [];
    for (QueryDocumentSnapshot item in docs) {
      BrandModel model =
          BrandModel.fromJson(item.data() as Map<String, dynamic>);
      model.id = item.id;
      brands.add(model);
    }
    return brands;
  }

//**-------------------------------------------------------------- */
  Future<List<ProductModel>> getProductsByBrand(String id) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("products");

    QuerySnapshot collection =
        await reference.where("brand", isEqualTo: id).get();
    List<QueryDocumentSnapshot> docs = collection.docs;
    List<BrandModel> brands = await getBrand();
    List<ProductModel> products = [];
    for (QueryDocumentSnapshot item in docs) {
      ProductModel product =
          ProductModel.fromJson(item.data() as Map<String, dynamic>);
      String newBrand =
          brands.where((element) => element.id == product.brand).first.name;
      product.brand = newBrand;
      products.add(product);
    }
    return products;
  }

//**--------------------------------------------------------------- */
  Future<String> registerUser(UserModel model) async {
    CollectionReference userReference =
        FirebaseFirestore.instance.collection("users");
    DocumentReference doc = await userReference.add(model.toJson());

    return doc.id;
  }

  Future<UserModel?> getUser(String email) async {
    CollectionReference userReference =
        FirebaseFirestore.instance.collection("users");
    QuerySnapshot collection =
        await userReference.where("email", isEqualTo: email).get();
    if (collection.size > 0) {
      QueryDocumentSnapshot doc = collection.docs.first;
      UserModel model = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      return model;
    }
    return null;
  }
}
