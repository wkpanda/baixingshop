import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = "欢迎您来到美好人间";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('美好人间'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                    //装饰输入文本框
                    contentPadding: EdgeInsets.all(10),
                    labelText: '美女类型',
                    helperText: '请输入你喜欢的类型'),
                autofocus: false,
              ),
              RaisedButton(
                onPressed: _choiceAction,
                child: Text("选择完毕"),
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    )
    );
  }

  void _choiceAction() {
    print('开始选择你喜欢的类型............');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('美女类型不能为空'),
              ));
    } else {
      getHttp(typeController.text.toString()).then((val) {
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String TypeText) async {
    try {
      Response response;
      var data = {'name': TypeText};
      response = await Dio().post(
          "https://easy-mock.com/mock/5e241b8631e8b414fccb3255/example/dabaojian_post",
          queryParameters: data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
