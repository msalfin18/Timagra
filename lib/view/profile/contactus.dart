import 'package:flutter/material.dart';
import 'package:timagra_new/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart'; 




class Contactus extends StatelessWidget {
  const Contactus({super.key});

     Future<void> _makeCall(String phoneNumber , context) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch phone call')),
      );
    }
  }

  Future<void> _sendEmail(String email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  if (!await launchUrl(emailUri)) {
    throw Exception('Could not launch $emailUri');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact us', style: TextStyle(fontWeight: FontWeight.w500),), 
      
      shadowColor: Colors.transparent,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
             children: [
        Container(
          decoration: BoxDecoration(
          color: greycolor,
          borderRadius: BorderRadius.circular(10)
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Text('Phone' , style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer(),
                Column(
                  children: [
                    Text(phonenumber, style: TextStyle(fontWeight: FontWeight.w600, color: buttoncolor),),
                  ],
                ),
                   SizedBox(width: 10,),
                 GestureDetector(
                  onTap: (){
                    _makeCall(phonenumber, context);
                  },
                  child: Icon(Icons.phone , color: buttoncolor,)),
             
                              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
               Container(
          decoration: BoxDecoration(
          color: greycolor,
          borderRadius: BorderRadius.circular(10)
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Text('Email' , style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer(),
                Text('admin@gmail.com' , style: TextStyle(fontWeight: FontWeight.w600, color: buttoncolor),),
                   SizedBox(width: 10,),
                 GestureDetector(
                  onTap: (){
                    _sendEmail(adminemail);
                  },
                  child: Icon(Icons.email , color: buttoncolor,)),
             
                              ],
            ),
          ),
        )
             ],
        ),
      ),
    );
  }
}