import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro/screen/home/home_screen.dart';
import 'package:pro/widget/login_button_widget.dart';
import 'package:pro/widget/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  String? phoneNumber;
  bool? isSignUp=true;
  Column _signUpWidget(BuildContext context){
    return  Column(
      children: [
      SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFieldWidget(
          title: "Email",
          hintText: "Enter email id",
          onPressed: (value){
            email=value.trim();
          },
        ),
      ),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFieldWidget(
          title: "Password",
          hintText: "Enter password",
          onPressed: (value){
            password=value.trim();
          },
        ),
      ),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFieldWidget(
          title: "Phone Number",
          hintText: "+919696674752",
          onPressed: (value){
            phoneNumber=value.trim();
          },
        ),
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('If you have already account, please'),
          TextButton(onPressed: (){
            setState(() {
              isSignUp=false;
            });
          }, child: Text('SignIn'))
        ],
      )
    ],);
  }

  Column _signInWidget(BuildContext context){
    return  Column(children: [
      SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFieldWidget(
          title: "Email",
          hintText: "Enter email id",
          onPressed: (value){
            email=value.trim();
          },
        ),
      ),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFieldWidget(
          title: "Password",
          hintText: "Enter password",
          onPressed: (value){
            password=value.trim();
          },
        ),
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('If you do not have account, please'),
          TextButton(onPressed: (){
            setState(() {
              isSignUp=true;
            });
          }, child: Text('SignUp'))
        ],
      )
    ],);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Image.asset( 'assets/images/pro.jpeg',width: 150,height: 150,),
             Expanded(
                child: isSignUp??false?_signUpWidget(context):_signInWidget(context),
              ),

            Column(
              children: [
              Divider(),
              Text('By continuing, you agree to our T&C and Privacy policy'),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LoginButtonWidget(buttonText: "Continue",onPressed: (isClick) async{
                  if((email?.isNotEmpty??false) && (password?.isNotEmpty??false) && (phoneNumber?.isNotEmpty??false) && isSignUp==true ){
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: email ?? "", password: password ?? "").then((
                          value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("SignUp Successfully")));
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      });
                    } catch (err) {
                      print(err);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("wrong email and password")));
                    }
                  }
                  else if((email?.isNotEmpty??false) && (password?.isNotEmpty??false) && isSignUp==false){
                     try{
                       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email??"", password: password??"").then((value){
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("SignIn Successfully")));
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                       });
                     }catch(err) {
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                           content: Text("wrong email and password")));
                     }
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("please fill all the field")));
                  }
                },),
              ),
              SizedBox(height: 40),],),
          ],
        ),
      ),
    );
  }
}
