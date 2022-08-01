import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAboutPage extends StatefulWidget {
  @override
  _MyAboutPageState createState() => _MyAboutPageState();
}

class _MyAboutPageState extends State<MyAboutPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About SSUET Sports"),
        backgroundColor: Color(0xff67388c),
      ),
            body: SingleChildScrollView(  
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 10.0, left: 24.0, right: 24.0),
              child: Container(
                //height: 50.0,
              //margin: EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xFF67388c),
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                child: Padding(
              padding: EdgeInsets.all(10.0),child:Column(children:[
             //   Image.asset("assets/images/logo.png"),
                       SvgPicture.asset(
              "assets/icons/signup.svg"),
                Text(
            'Background',
            textAlign: TextAlign.start,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF67388c),
                ),
          ),
          SizedBox(height: 7,),

          Text(
                  'SSUET Sports is a cross-platform mobile application for managing sports events of Sir Syed University. Our application will help the university management as well as sports participants. This application will let students to register themselves on various sports and get up to date with all the announcements, news alerts etc. by sports department through notifications. We will develop this mobile application using Flutter. ',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
            'Created By',
            textAlign: TextAlign.start,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF67388c),
                ),
          ),
          SizedBox(height: 7.0,),
          namesInBullet('Muhammad Usman Khan'),
          namesInBullet('Gopal Chand'),
          namesInBullet('Ahmed Ali'),
          namesInBullet('Fatima Rehan'),
          SizedBox(height: 7.0,),
          Text(
            'Supervised By',
            textAlign: TextAlign.start,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
               color: Color(0xFF67388c),
                ),
          ),
          SizedBox(height: 7.0,),
          namesInBullet('Mr. Sallar Khan'),
          ],),),
              ),),
          Text(
            'https://ssuet.edu.pk/',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF67388c),
                ),
          ),
          
        ]),
      ),
      // body:  Padding(
      //   padding: EdgeInsets.all(15),
      //   child: Text(
      //     'National rankings, environmentally friendly and state-of-the-art facilities, growing reputation for excellence in teaching and affordable cost of engineering education are some of the main attractions of SSUET.',
      //     style: TextStyle(fontSize: 18),
          
      //   ),
        
      // )
    );
  }
}
Widget namesInBullet(text) {
  return Row(
    children: [
      Icon(
      Icons.adjust,
    color: Color(0xFF67388c),
    ),
     Text(text),
    ],
  );
}



// import 'package:flutter/material.dart';
// class MyAboutPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//           appBar: AppBar(
//             iconTheme: IconThemeData(
//               color: Colors.red,
//             ),
//             title: Text(
//               'About Us',
//               style: TextStyle(color: Colors.red),
//             ),
//             backgroundColor: Colors.grey[100],
//             elevation: 0.0,),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           Padding(
//               padding: EdgeInsets.only(top: 10.0, left: 24.0, right: 24.0),
//               child: Container(//height: 50.0,
//               //margin: EdgeInsets.all(5.0),
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(
//                           color: Colors.red,
//                           width: 5,
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                 child: Padding(
//               padding: EdgeInsets.all(10.0),child:Column(children:[
//                 Image.asset("assets/images/logo.png"),
//                 Text(
//             'Background',
//             textAlign: TextAlign.start,
//             style: TextStyle(
//                 decoration: TextDecoration.underline,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16.0,
//                 color: Colors.red),
//           ),
//           SizedBox(height: 7,),
//           Text(
//                   'We have observed that people at distant areas having cardiovascular or blood pressure disease need for general checkup or a trivial diagnosis and they have to travel just for an appointment. At the beginning, general physician sees the patient, notes down the vitals and performs diagnosis possibly with the help of tests. Later the patient may need to see a cardiologist. Looking at this scenario closely, I decided to develop an application that will solve this problem and help patients know their heart condition and when they need to visit a doctor.',
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//                 Text(
//             'Created By',
//             textAlign: TextAlign.start,
//             style: TextStyle(
//                 decoration: TextDecoration.underline,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16.0,
//                 color: Colors.red),
//           ),
//           SizedBox(height: 7.0,),
//           namesInBullet('Itrat Zehra Jassani'),
//           namesInBullet('Iqrash Ahmed'),
//           namesInBullet('Musaib Khan'),
//           namesInBullet('Maryam Rafi'),
//           SizedBox(height: 7.0,),
//           Text(
//             'Supervised By',
//             textAlign: TextAlign.start,
//             style: TextStyle(
//                 decoration: TextDecoration.underline,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16.0,
//                 color: Colors.red),
//           ),
//           SizedBox(height: 7.0,),
//           namesInBullet('Dr. Usman Amjad'),
//           namesInBullet('Dr. Noman Hasni'),
//           ],),),
//               ),),
//           Text(
//             'hdps.prediction@gmail.com',
//             style: TextStyle(
//                 decoration: TextDecoration.underline,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16.0,
//                 color: Colors.red),
//           ),
          
//         ]),
//       ),
//       );
  
// }
// }

// Widget namesInBullet(text) {
//   return Row(
//     children: [
//       Icon(
//       Icons.adjust,
      
//       color: Colors.red,
//     ),
//      Text(text),
//     ],
//   );
// }





// import 'package:flutter/material.dart';
// class MyAboutPage extends StatefulWidget {
//   @override
//   _MyAboutPageState createState() => _MyAboutPageState();
// }

// class _MyAboutPageState extends State<MyAboutPage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("About SSUET Sports"),
//         backgroundColor: Color(0xff67388c),
//       ),
//       body:  SingleChildScrollView(
//         child: Container(
//           height: 800,
//         //padding: EdgeInsets.all(15),
//           margin: const EdgeInsets.all(15.0),
//   padding: const EdgeInsets.all(3.0),
//   decoration: BoxDecoration(
//     border: Border.all(
//       width: 5.0,
//       color: Colors.purple[800]
//       )
//   ),
//         child: Text(
//           'National rankings, environmentally friendly and state-of-the-art facilities, growing reputation for excellence in teaching and affordable cost of engineering education are some of the main attractions of SSUET.',
//           style: TextStyle(fontSize: 18),
//         ),
        
//       )
//    ),
//     );
//   }
// }





