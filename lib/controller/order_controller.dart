import 'dart:convert';

import 'package:get/get.dart';

import '../api/model/section_model.dart';
import 'package:http/http.dart'as http;

class OrderController extends GetxController
{
  // List<Model1>abc=[];
  // Future<List<Model1>> getApi() async {
  //   final response=await http.get(Uri.parse("http://localhost:5000/api/section/"));
  //   var data=jsonDecode(response.body.toString());
  //   if(response.statusCode==200)
  //   {
  //     for(var index in data)
  //     {
  //       abc.add(Model1.fromJson(index));
  //     }
  //     return abc;
  //   }
  //   else{
  //     return abc;
  //   }

  var data;

  Future<void> getApi()async{
    final response=await http.get(Uri.parse("http://localhost:5000/api/section/"));
    print('111');
    if(response.statusCode==200)
    {
      data=jsonDecode(response.body.toString());
      print('222');
      print("#############$data");
      return;
    }
    else{

    }
  }

}