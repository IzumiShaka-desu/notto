import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notto/service/network_service.dart';
import 'package:notto/service/sharepref_service.dart';
import 'package:notto/utils.dart';

import 'home.dart';

class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  Map<String, TextEditingController> controller = {
    'emailLogin': TextEditingController(),
    'emailRegister': TextEditingController(),
    'fullname': TextEditingController(),
    'passwordLogin': TextEditingController(),
    'confirmPassword': TextEditingController(),
    'password': TextEditingController(),
  };
  setControllerEmpty() {
    for (String i in controller.keys) {
      controller[i].text = '';
    }
  }

  bool isSuccessfull = false;
  PageController _pageController = PageController();
  double currentPageValue = 0;
  bool isLoading = false;
  GlobalKey<ScaffoldState> sk = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
      });
    });
    return SafeArea(
      child: Stack(children: [
        Positioned.fill(child: Container()),
        Container(
          child: Scaffold(
              key: sk,
              body: Container(
                child: Stack(children: [
                  Positioned.fill(
                      child: Container(
                          child: Column(
                    children: [
                      Container(
                        height: 100,
                        color: Colors.white,
                      ),
                      Container(
                        height: 15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                                height: 13,
                                width: 13,
                                curve: Curves.fastOutSlowIn,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (currentPageValue == 1)
                                        ? Colors.white
                                        : Colors.blue[700],
                                    border: Border.all(color: Colors.grey)),
                                duration: Duration(milliseconds: 250)),
                            SizedBox(width: 5),
                            AnimatedContainer(
                                height: 13,
                                width: 13,
                                curve: Curves.fastOutSlowIn,
                                decoration: BoxDecoration(
                                    color: (currentPageValue == 0)
                                        ? Colors.white
                                        : Colors.blue[700],
                                    border: Border.all(color: Colors.grey),
                                    shape: BoxShape.circle),
                                duration: Duration(milliseconds: 250))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.blue[800],
                          child: PageView.builder(
                              controller: _pageController,
                              physics: (isLoading)
                                  ? NeverScrollableScrollPhysics()
                                  : AlwaysScrollableScrollPhysics(),
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return SingleChildScrollView(
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(15),
                                      child: (index == 0)
                                          ? Column(children: [
                                              SizedBox(height: 20),
                                              Container(
                                                  width: size.width * 0.7,
                                                  child: createTextField(
                                                      controller['emailLogin'],
                                                      "email",
                                                      Icons.alternate_email)),
                                              SizedBox(height: 15),
                                              Container(
                                                  width: size.width * 0.7,
                                                  child: createTextField(
                                                      controller[
                                                          'passwordLogin'],
                                                      "password",
                                                      Icons.lock_outline,
                                                      isObscure: true)),
                                              SizedBox(height: 20),
                                              Material(
                                                type: MaterialType.transparency,
                                                child: InkWell(
                                                    onTap: () => exectLogin(
                                                        controller['emailLogin']
                                                            .text,
                                                        controller[
                                                                'passwordLogin']
                                                            .text),
                                                    child: AnimatedContainer(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        height: 50,
                                                        width: size.width * 0.6,
                                                        child: Center(
                                                          child: Text('Masuk',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .blue[
                                                                      800],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                        curve: Curves.bounceOut,
                                                        transform: Matrix4
                                                            .identity()
                                                          ..scale((currentPageValue ==
                                                                  index.toInt())
                                                              ? 1.0
                                                              : 0.00000001),
                                                        duration: Duration(
                                                            milliseconds:
                                                                250))),
                                              )
                                            ])
                                          : Column(children: [
                                              Container(
                                                  width: size.width * 0.7,
                                                  child: createTextField(
                                                      controller['fullname'],
                                                      "nama",
                                                      Icons.account_circle)),
                                              Container(
                                                  width: size.width * 0.7,
                                                  child: createTextField(
                                                      controller[
                                                          'emailRegister'],
                                                      "email",
                                                      Icons.alternate_email)),
                                              Container(
                                                  width: size.width * 0.7,
                                                  child: createTextField(
                                                      controller['password'],
                                                      "password",
                                                      Icons.lock_outline,
                                                      isObscure: true)),
                                              Container(
                                                  width: size.width * 0.7,
                                                  child: createTextField(
                                                      controller[
                                                          'confirmPassword'],
                                                      "konfirmasi password",
                                                      Icons.lock_outline,
                                                      isObscure: true)),
                                              SizedBox(height: 20),
                                              Center(
                                                child: Material(
                                                  type:
                                                      MaterialType.transparency,
                                                  child: InkWell(
                                                      onTap: () => (!isLoading)
                                                          ? exectRegister(
                                                              controller['fullname']
                                                                  .text,
                                                              controller['password']
                                                                  .text,
                                                              controller['confirmPassword']
                                                                  .text,
                                                              controller['emailRegister']
                                                                  .text)
                                                          : () {},
                                                      child: AnimatedContainer(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          height: 50,
                                                          width:
                                                              size.width * 0.6,
                                                          child: Center(
                                                            child: Text(
                                                                'Daftar',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .blue[
                                                                        800],
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                          curve:
                                                              Curves.bounceOut,
                                                          transform: Matrix4.identity()
                                                            ..scale((currentPageValue ==
                                                                    index
                                                                        .toInt())
                                                                ? 1.0
                                                                : 0.00000001),
                                                          duration: Duration(
                                                              milliseconds: 250))),
                                                ),
                                              )
                                            ])),
                                );
                              }),
                        ),
                      ),
                    ],
                  ))),
                ]),
              )),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          bottom: (isSuccessfull) ? -size.height : -2,
          right: (isSuccessfull) ? -size.width : -2,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            height: (isSuccessfull) ? size.height * 3 : 0,
            width: (isSuccessfull) ? size.width * 3 : 0,
            onEnd: () => goToDashboard(),
          ),
        ),
        Positioned(
          child: Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.topCenter,
              height: 100,
              color: Colors.white,
              child: Padding(
                child: createTitle(),
                padding: EdgeInsets.all(8),
              )),
        ),
        (!isLoading)
            ? SizedBox()
            : Container(
                color: Colors.white70,
                child: Center(
                  child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator()),
                )),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          bottom: (isSuccessfull)?-size.height:-2,
          right: (isSuccessfull)?-size.width:-2,
                  child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            
            decoration: BoxDecoration(color:Colors.white,shape: BoxShape.circle),
            height: (isSuccessfull)?size.height*3:0,
            width: (isSuccessfull)?size.width*3:0,
            onEnd: ()=>goToDashboard(),
          ),)
      ]),
    );
  }

  animate() {
    setState(() {
      isSuccessfull = true;
    });
  }

  exectLogin(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    var result;
    String msg = '', timeout = '';
    var service = NetworkService();
    if (email == '' || password == '') {
      showSnackbar('form tidak boleh kosong');
    } else if (!emailValidator(email)) {
      showSnackbar('email tidak valid');
    } else {
      try {
        result = await service.loginUser(email, password);
        msg = result['message'];
      } on SocketException catch (e) {
        if (isTimeOut(e)) timeout = " koneksi terputus";
      } catch (e) {
        debugPrint(e.toString());
      }
      showSnackbar(msg + timeout);
    }
    setState(() {
      isLoading = false;
    });
    if(result['result']){
      SFService().saveLoginDetails(email, result['fnameData']);
      animate();
    }
  }

  exectRegister(String fullname, String password, String confirmpassword,
      String email) async {
    setState(() {
      isLoading = true;
    });
    var service = NetworkService();
    if (fullname.isEmpty ||
        password.isEmpty ||
        confirmpassword.isEmpty ||
        email.isEmpty) {
      showSnackbar('form tidak boleh kosong');
    } else if (!emailValidator(email)) {
      showSnackbar('email tidak valid');
    } else if (password != confirmpassword) {
      showSnackbar('password dan konfirmasi password tidak sesuai');
    } else {
      var result;
      String msg = '', timeout = '';
      try {
        result = await service.registerUser(fullname, email, password);
        msg = result['message'];
      } on SocketException catch (e) {
        if (isTimeOut(e)) timeout = " koneksi terputus";
      } catch (e) {
        debugPrint(e.toString());
      }
      if (result['result'] == 1) {
        msg += ' silahkan login';
        setControllerEmpty();
      }
      showSnackbar(msg + timeout);
    }
    setState(() {
      isLoading = false;
    });
  }

  goToDashboard() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }

  showSnackbar(String _msg) => sk.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white,
      content: Material(
        type: MaterialType.transparency,
        child: Container(
          height: 50,
          child: Center(
              child: Row(
            children: [
              Expanded(
                child: Text(
                  _msg,
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ),
            ],
          )),
        ),
      )));
}
