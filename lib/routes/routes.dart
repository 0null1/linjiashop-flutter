import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/details/order_details.dart';
import 'package:flutter_app/page/details/product_details.dart';
import 'package:flutter_app/page/index_page.dart';
import 'package:flutter_app/page/orderform_page.dart';
import 'package:flutter_app/page/pay/pay_page.dart';
import 'package:flutter_app/page/reg_and_login.dart';
class Routes {
  static final Router router = new Router();
  static const ROOT = '/';
  // details
  static const ORDER_DETAILS = '/order_details';
  static const PRODUCT_DETAILS = '/product_details';

  static const login_page = '/login_page';
  static const order_page = '/order_page';
  static const pay_page = '/pay_page';
  void _config() {
    router.define(
        ROOT, handler: Handler(handlerFunc: (context, params) => IndexPage()));

    router.define(
        PRODUCT_DETAILS, handler:
    Handler(handlerFunc: (context, params) => ProductDetails(id:params['id'].first)));
    router.define(
        ORDER_DETAILS, handler:
    Handler(handlerFunc: (context, params) => OrderDetails(orderSn:params['orderSn'].first)));
    router.define(
        pay_page, handler:
    Handler(handlerFunc: (context, params) =>
        PayPage(orderSn:params['orderSn'].first,totalPrice:params['totalPrice'].first)));
    router.define(
        login_page, handler: Handler(handlerFunc: (context, params) => RegPageAndLoginPage()));
    router.define(
        order_page, handler: Handler(handlerFunc: (context, params) => OrderFormPage()));
  }

  /**
   * 传递多参数
   */
  Future navigateToParams(BuildContext context, String path, {Map<String, dynamic> params}) {
    String query =  "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
//    print('我是navigateTo传递的参数：$query');
    path = path + query;
    return router.navigateTo(context, path, transition: TransitionType.inFromRight);
  }


  Future navigateTo(BuildContext context, String path){

    return router.navigateTo(context,path,transition: TransitionType.inFromRight);
  }
  Future navigateToReplace(BuildContext context, String path,{Map<String, dynamic> params}){
    String query =  "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
//    print('我是navigateTo传递的参数：$query');
    path = path + query;
    return router.navigateTo(context,path,replace: true,transition: TransitionType.inFromRight);
  }

  Future navigateFromBottom(BuildContext context, String path,[String param='']){
    var p = param.isNotEmpty?'$path/$param':path;
    return router.navigateTo(context,p,transition: TransitionType.inFromBottom);
  }

  factory Routes() =>_getInstance();
  static Routes get instance => _getInstance();
  static Routes _instance;

  Routes._internal() {
    _config();
  }
  static Routes _getInstance() {
    if (_instance == null) {
      _instance = new Routes._internal();
    }
    return _instance;
  }
}
