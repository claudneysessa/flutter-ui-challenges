/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';

class ConfirmOrderPage extends StatelessWidget {
  static final String path = "lib/src/pages/ecommerce/confirm_order1.dart";
  final String address = "Chabahil, Kathmandu";
  final String phone = "9818522122";
  final double total = 500;
  final double delivery = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Order"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Subtotal"),
              Text("Rs. $total"),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Delivery fee"),
              Text("Rs. $delivery"),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Total"),
              Text("Rs. ${total + delivery}"),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text("Delivery Address".toUpperCase())),
          Column(
            children: <Widget>[
              RadioGroup<String>(
                groupValue: address,
                onChanged: (String? value) {},
                child: Column(
                  children: <Widget>[
                    RadioListTile<String>(
                      selected: true,
                      value: address,
                      title: Text(address),
                    ),
                    RadioListTile<String>(
                      selected: false,
                      value: "New Address",
                      title: Text("Choose new delivery address"),
                    ),
                  ],
                ),
              ),
              Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text("Contact Number".toUpperCase())),
              RadioGroup<String>(
                groupValue: phone,
                onChanged: (String? value) {},
                child: Column(
                  children: <Widget>[
                    RadioListTile<String>(
                      selected: true,
                      value: phone,
                      title: Text(phone),
                    ),
                    RadioListTile<String>(
                      selected: false,
                      value: "New Phone",
                      title: Text("Choose new contact number"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text("Payment Option".toUpperCase())),
          RadioGroup<bool>(
            groupValue: true,
            onChanged: (bool? value) {},
            child: RadioListTile<bool>(
              value: true,
              title: Text("Cash on Delivery"),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: () => {},
              child: Text(
                "Confirm Order",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
