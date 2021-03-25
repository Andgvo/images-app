import 'package:images_app/src/providers/products_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:images_app/src/models/product_model.dart';

class ProductsBloc {
  
  final _productsController = new BehaviorSubject<List<ProductModel>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _productsProvider = new ProductsProvider();
  
  Stream<List<ProductModel>> get productsStream => _productsController.stream;
  Stream<bool> get loading => _loadingController.stream;

  void getProducts() async{
    final products = await _productsProvider.getProducts();
    _productsController.sink.add(products);
  }

  void createProduct(ProductModel product) async{
    _loadingController.add(true);
    await _productsProvider.createProduct(product);
    _loadingController.add(false);
  }
 
  void editProduct(ProductModel product) async{
    _loadingController.add(true);
    await _productsProvider.editProduct(product);
    _loadingController.add(false);
  }

  void deleteProduct(String id) async{
    
    await _productsProvider.deleteProduct(id);
    
  }

  dispose(){
    _productsController?.close();
    _loadingController?.close();
  }
}