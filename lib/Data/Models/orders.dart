import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum OrderType{
   buy,
   sell,
   marketOrder,
   limitOrder
}

class Order{
  final String? cryptoName;
  final String? price;
  final String? amount;
  final double? total;
  final OrderType? type;
  static List<Map<String, String?>> ordersList = [];
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Order({this.cryptoName, this.price, this.amount, this.type, this.total});

  addOrder(Order order){
    ordersList.add({
      "crypto": order.cryptoName,
      "price": order.price,
      "amount": order.amount,
      "type": order.type.toString(),
      "total": order.total.toString()
    });

    addOrdersToFireStore(userId);
  }

  addOrdersToFireStore(String? userId){
    final document = FirebaseFirestore.instance.collection('Users').doc(userId);

    document.update({
      "orders": ordersList
    });
  }
}



