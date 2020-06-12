import 'package:flutter/material.dart';
import 'package:movie_app/blocs/LoginPageBloc.dart';
import 'package:movie_app/utils/Sizes.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  //dùng đối tượng bloc để phân chia code giao diện và logic ra 2 file riêng biệt
  LoginPageBloc _bloc = new LoginPageBloc();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DeviceSize.init(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        //tạo màu nền cho ứng dụng
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF2d3440),
                  Color(0xFF2d3450),
                  Color(0xFF2d3460)
                ]
            )
        ),
        //Dùng SingleChildScrollView cho ứng dụng có thể scroll được nếu kích thước màn hình nhỏ
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: DeviceSize.getHeight(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 40),
                    //Wiget hiển thị tiêu đề Login
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),),
                      ],
                    ),
                  ),
                ),
                //Wiget chứa các wiget phục vụ cho việc đăng nhập
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                    ),
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: Container(
                            child: SizedBox.expand(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                //Wiget chứa 2 TextField nhập username, password.
                                child: Wrap(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30,right: 30, bottom: 30),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [BoxShadow(
                                                color: Color(0xFF2d3447),
                                                blurRadius: 25,
                                                offset: Offset(0, 10)
                                            )]
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                                              decoration: BoxDecoration(
                                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                              ),
                                              child: TextField(
                                                controller: _bloc.userController,
                                                decoration: InputDecoration(
                                                    hintText: "User name",
                                                    hintStyle: TextStyle(color: Colors.grey),
                                                    border: InputBorder.none
                                                ),
                                                style: TextStyle(fontSize: 16, color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                                              child: TextField(
                                                controller: _bloc.passController,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                    hintText: "Password",
                                                    hintStyle: TextStyle(color: Colors.grey),
                                                    border: InputBorder.none
                                                ),
                                                style: TextStyle(fontSize: 16, color: Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          )
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Center(
                                  child: Text("Forgot Password?", style: TextStyle(color: Colors.blue, fontSize: 15),),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: SizedBox.expand(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 50),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      onPressed: (){
                                        _bloc.btnLoginPress(context);
                                      },
                                      color: Color(0xFF2d3457),
                                      child: Text("SIGN IN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Center(
                                  child: Text("Create Account", style: TextStyle(color: Colors.blue, fontSize: 15),),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}