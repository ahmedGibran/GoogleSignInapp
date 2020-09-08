import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void>SignIn()async{
   GoogleSignInAccount account = await googleSignIn.signIn();
   GoogleSignInAuthentication authentication = await account.authentication;
   AuthCredential credential =
   GoogleAuthProvider.getCredential(idToken: authentication.idToken,accessToken: authentication.accessToken);
   final user =(await _auth.signInWithCredential(credential)).user;
   if(user!=null){
     print("${user.email}");
   }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.red,
                child: FlatButton(onPressed: (){
                 SignIn();
                },
                  child: Text("SignIn with Google",style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                color: Colors.black,
                child: FlatButton(onPressed: ()async{
                await googleSignIn.signOut();
                print("success");
                },
                  child: Text("Sign Out",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
