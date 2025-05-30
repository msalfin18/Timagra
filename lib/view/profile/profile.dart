import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timagra_new/constants/constants.dart';
import 'package:timagra_new/services/auth_service.dart';
import 'package:timagra_new/view/profile/contactus.dart';
import 'package:timagra_new/view/registration/login.dart';
import 'package:timagra_new/view/wishlist/wishlist.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences? _readobj;
  late String userid;
  late String Useremail;
  //  late String userid ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadpref();
  }

  Future<void> _loadpref() async {
    _readobj = await SharedPreferences.getInstance();
    setState(() {
      userid = _readobj?.getString('Userid') ?? "#000000000";
      Useremail = _readobj?.getString('Useremail') ?? "Guest";

      print("$userid          $Useremail");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            height: 130,
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  'assets/image/user.png',
                  height: 64,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userid.length >= 4
                          ? userid.substring(userid.length - 6)
                          : userid,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '$Useremail',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.lock, color: greytext),
            title: Text('Change Password'),
            trailing: Icon(Icons.chevron_right, color: greytext),
            onTap: () {},
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.favorite, color: greytext),
            title: Text('Wishlist'),
            trailing: Icon(Icons.chevron_right, color: greytext),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Wishlist()));
            },
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.mail, color: greytext),
            title: Text('Contact Us'),
            trailing: Icon(Icons.chevron_right, color: greytext),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Contactus()));
            },
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.info, color: greytext),
            title: Text('App Version'),
            trailing: Text('v1.0.0', style: TextStyle(color: greytext)),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: greytext),
            title: Text('Logout', style: TextStyle(color: Colors.black)),
            onTap: () async {
//                final SharedPreferences prefs = await SharedPreferences.getInstance();
//                  await prefs.setBool('isLoggedIn', false);
//  Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => SignInPage()),
//       (route) => false,
//     );
              await AuthService().signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
