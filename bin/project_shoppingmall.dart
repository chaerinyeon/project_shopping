// ignore: unused_import
// import 'dart:ffi';
import 'dart:io';

class Product {
  String name; //상품 이름
  int price; // 상품 가격

  Product(this.name, this.price); //생성자 (상품 이름, 상품 가격)
}

class ProductList { //상품 리스트 클래스
  List<Product> products; // 상품 리스트

  ProductList(this.products); // 생성자(상품리스트)

  void showProducts() { // 상품 목록을 보여주는 클래스
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
  Map<String, int> cart = {}; //장바구니(상품이름,수량)
  ProductList productList = ProductList(products); //상품 목록 객체 설정

  while (true) {
    print(
        "[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 닫기"); //프로그램 시작 시 메뉴 출력
    String? input = stdin.readLineSync();

    switch (input) {
      case '1': //1번 입력 시
        print(productList); //상품 목록 출력
        break;

      case '2': //2번 입력 시
        print('상품 이름을 입력해 주세요.'); 
        String? productName = stdin.readLineSync();  //상품 이름 입력

        if (productName == null ||
            !products.any((product) => product.name == productName)) {
          print("입력 값이 올바르지 않아요."); // 상품의 이름이 목록에 없거나 맞지 않다면 출력
        } else {
          print('상품 개수를 입력해 주세요.'); // 예외의 경우 출력

          try {
            String? quantityInput = stdin.readLineSync(); //상품 개수 입력
            int quantity = int.parse(quantityInput!); //상품의 개수를 int로 변환

            if (quantity <= 0) {
              print("0개보다 많은 개수의 상품만 담을 수 있어요.");. //상품의 개수가 0보다 적은 경우 출력
            } else {
              if (cart.containsKey(productName)) {
                cart[productName] = cart[productName]! + quantity; //장바구니에 상품, 개수 추기
              } else {
                cart[productName] = quantity;
              }
              print("$productName 상품을 $quantity개 담았습니다."); //장바구니에 담긴 상품과 개수 출력
            }
          } catch (e) {
            print("입력값이 올바르지 않아요");
          }
        }
        break;

      case '3': //3번 입력 시
        int totalPrice = 0; //총 가격 초기화
        cart.forEach((productName, quantity) { //장바구니에 담긴 이름,개수 
          for (var product in products) {
            if (product.name == productName) {    //정보 찾기
              totalPrice += product.price * quantity; //장바구니에 담긴 상품의 총 가격 계산
            }
          }
        });

        if (totalPrice > 0) {
          print("장바구니에 총 $totalPrice 원 어치 담으셨네요");
        } else {
          print("장바구니가 비어 있습니다.");
        }
        break;

      case '4': //4번 입력 시
        while (true) {
          print("정말로 프로그램을 종료하시겠습니까? 종료하시려면 '5'를, 되돌아 가시려면 '6'을 눌러주세요.");
          String? exitInput = stdin.readLineSync(); // 입력
          switch (exitInput) {
            case '5': //5번 입력 시
              print("프로그램을 종료합니다.");
              return; // 프로그램 종료

            case '6': //6번 입력 시
              print("메인 메뉴로 돌아갑니다.");
              break; 

            default: // 그 외의 경우
              print("잘못된 입력입니다. 다시 입력해 주세요.");
          }

          if (exitInput == '5' || exitInput == '6') {
            break; 
          }
        }
        break;

      default:
        print("지원하지 않는 기능입니다. 다시 시도해 주세요."); //그 외의 경우 출력
        break;
    }
  }
}
