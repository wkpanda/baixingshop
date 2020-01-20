import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/config/httpHeaders.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '还没有请求数据';   //声明要显示的数据并且设置默认值
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('请求远程数据'),
        ),
        body: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: _geek,
              child: Text('请求数据'),
            ),
            Text(showText)
          ],
          ),
        ),
      )
    );
  }

  void _geek(){
    print("开始向极客时间请求数据.....");
    getHttp()..then((val){
      setState(() {
        showText=val['data'].toString();
      });
    }) ;
 }

  Future getHttp() async{
    try{
      Response response;
      Dio dio = new Dio();
      dio.options.headers = HttpHeaders;
      response=await dio.get('https://time.geekbang.org/serv/v1/column/labels');
      print(response);
      return response.data;
    }catch(e){
      return print(e);
    }
  }
}