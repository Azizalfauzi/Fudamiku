part of 'services.dart';

class OrderServices {
  static final _orderURL = 'https://infinite-sea-18742.herokuapp.com/api/orders';

  static Future<List<Order>> getOrders(int userID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var userID = preferences.getInt('id');

    final response = await http.get(_orderURL + '/' + userID.toString(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List orders = json['data'];

      return orders.map((e) => Order.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> saveOrder(Order order, Transaction transaction) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var userID = preferences.getInt('id');

    await http.post(_orderURL, 
      body: jsonEncode({
        'user_id': userID,
        'food_id': order.foodID,
        'quantity': order.quantity,
        'status': order.status,
        'delivery_service': transaction.deliveryService,
        'tax': transaction.tax,
        'total_price': transaction.totalPrice,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}