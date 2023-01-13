

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RenderHTML extends StatefulWidget {
  const RenderHTML({Key? key}) : super(key: key);

  @override
  State<RenderHTML> createState() => _RenderHTMLState();
}

class _RenderHTMLState extends State<RenderHTML> {



 final renderHTML= """
 <div>

  <h1>Href Attribute Example</h1>
  <p>
  <a href="https://www.freecodecamp.org/contribute/">The freeCodeCamp Contribution Page</a> shows you how and where you can contribute to freeCodeCamp's community and growth.
  </p>
  
    <img src="https://im.indiatimes.in/content/2021/Jun/Article-Body---2021-06-04T142130781_60b9eb4e82ba8.jpg?w=1200&h=900&cc=1" />
    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWApY7vpCoiyrYKL1FUsfNDwYUSNPTG5TZlQ&usqp=CAU" />

 </div>
  """;

 @override
 Widget build(BuildContext context) => Scaffold(
   body: SingleChildScrollView(
     scrollDirection: Axis.vertical,
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         SizedBox(height: 50,),
           Html(data: renderHTML,
             style: {
                'h1':Style(fontSize: FontSize.percent(300), color: Colors.red),
              })
       ],
     ),
   ),
 );


}
