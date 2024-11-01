// ignore: unused_import
//import 'dart:ffi';
import 'dart:io';

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class ProductList {
  List<Product> products;

  ProductList(this.products);

  void showProducts() {
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }
}

void main() {
  List<Product> products = [
    Product('셔츠', 35000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];
  Map<String, int> cart = {};
  ProductList productList = ProductList(products);

  while (true) {
    print(
        "[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 닫기");
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        productList.showProducts();
        print(List<Product>); // 상품 목록 출력
        break;

      case '2':
        print('상품 이름을 입력해 주세요.');
        String? productName = stdin.readLineSync();

        if (productName == null ||
            !products.any((product) => product.name == productName)) { 
          print("입력 값이 올바르지 않아요."); // 상품의 이름이  null값이거나 상품 목록 이름과 같지 않을 경우 출력
        } else {
          print('상품 개수를 입력해 주세요.'); // 그 예외의 경우 출력

          try {
            String? quantityInput = stdin.readLineSync();
            int quantity = int.parse(quantityInput!); //입력한 상품의 개수를 int 로 변환

            if (quantity <= 0) {
              print("0개보다 많은 개수의 상품만 담을 수 있어요."); //상품의 개수가 0보다 작은 경우 출력
            } else {
              if (cart.containsKey(productName)) {
                cart[productName] = cart[productName]! + quantity;
              } else {
                cart[productName] = quantity;
              }
            }
          } catch (e) {
            print("입력값이 올바르지 않아요"); //그 외의 입력의 경우 출력
          }
        }
        break;
      case '3':
        int totalPrice = 0; //총 가격 초기화
        cart.forEach((productName, quantity) {
          for (var product in products) {
            if (product.name == productName) {
              totalPrice += product.price * quantity; //총 가격 구하는 공식
            }
          }
        });

        if (totalPrice > 0) {
          print("장바구니에 총 $totalPrice 원 어치 담으셨네요"); //총 가격이 0보다 크다면 총 가격과 함께 출력
        }
        else {
          print("장바구니에 물건이 담기지 않았어요."); // 그 외의 경우 출력
        break;

      case '4':
        print("프로그램을 종료합니다.");
        return;

      default:
        print("지원하지 않는 기능입니다. 다시 시도해 주세요.");
        break;
    }
  }
}
