import 'package:asbeza_app/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderSharedPreference {
  setOrderInfo(IOrderForm orderForm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phoneNumber", orderForm.phoneNumber.toString());
    prefs.setString("firstName", orderForm.firstName);
    prefs.setString("lastName", orderForm.lastName);
    prefs.setString("add1", orderForm.add1);
    prefs.setString("add2", orderForm.add2);
    prefs.setString("city", orderForm.city);
    prefs.setString("country", orderForm.country);
    prefs.setString("direction", orderForm.direction);
  }

  Future<IOrderForm> getOrderInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phoneNumber = prefs.getString("email") ?? "";
    String firstName = prefs.getString("firstName") ?? "";
    String lastName = prefs.getString("lastName") ?? "";
    String add1 = prefs.getString("add1") ?? "";
    String add2 = prefs.getString("add2") ?? "";
    String city = prefs.getString("city") ?? "";
    String country = prefs.getString("country") ?? "";
    String direction = prefs.getString("direction") ?? "";
    return IOrderForm(
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      add1: add1,
      add2: add2,
      city: city,
      country: country,
      direction: direction,
    );
  }
}
