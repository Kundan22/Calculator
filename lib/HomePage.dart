import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';


//Global variables
//For Appbar Colors
Color clrAppBar;
Color clrAppBarText;

String strInput="";
bool clearAfterResult=false;
final textControllerInput = TextEditingController();


class HomePage extends StatefulWidget{
  final VoidCallback brightnessCallBack;
  HomePage(this.brightnessCallBack);
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  //Text Controllers for taking inputs and showing results

  @override
  void initState() {
    super.initState();

    // Start listening to changes
    textControllerInput.addListener((){});
    
  }
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    textControllerInput.dispose();
    
    super.dispose();
  }

  onButtonPressed(String buttonText){
    print(buttonText);
    String numPad = "1,2,3,4,5,6,7,8,9,0,.,/,*,+,-";
    buttonText = buttonText.replaceFirst("x", "*");
    if(numPad.contains(buttonText)){
      if(clearAfterResult==true){
        textControllerInput.text="";clearAfterResult=false;
      }  
      textControllerInput.text = textControllerInput.text + buttonText;
    }

    if(buttonText.contains("=")){
      Parser p = new Parser();
      ContextModel cm = new ContextModel();
      print(textControllerInput.text);
      Expression exp = p.parse(textControllerInput.text);
                
      double _result = exp.evaluate(EvaluationType.REAL, cm);
      print(_result);
      if(_result.toString().endsWith(".0"))
        textControllerInput.text= _result.round().toString(); 
      else
        textControllerInput.text= _result.toStringAsFixed(12); 

      clearAfterResult = true;
    }

    if(buttonText.contains("U+0E14A")){
      if(clearAfterResult == true)
        textControllerInput.text = "";
      else
        textControllerInput.text=(textControllerInput.text.length>0)?(textControllerInput.text.substring(0, textControllerInput.text.length-1)):"";
    }

    if(buttonText.contains("U+0E3CA")){
      textControllerInput.text = "-" + textControllerInput.text;
    }
  

    if(buttonText.contains("sqrt")){
       num  _result = sqrt(num.parse(textControllerInput.text));
       print(_result);

       if(_result.toString().endsWith(".0"))
          textControllerInput.text= _result.round().toString(); 
       else
          textControllerInput.text= _result.toStringAsFixed(12); 

       clearAfterResult = true;
    }

     if(buttonText.contains("square")){
                      num _result = pow(num.parse(textControllerInput.text),2);
                      
                      print(_result);

                      textControllerInput.text= _result.toString();

                      clearAfterResult = true;       
     }

  }

 Widget createImageButton(String _imageName) {
      return new Expanded(
        child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey[100])),
            child: new FlatButton(
                        onPressed: ()=> onButtonPressed(_imageName),
                        padding: EdgeInsets.all(14),
                        child: Image.asset('assets/images/'+ _imageName +'.png')))
        );
 }

  Widget createIconButton(IconData buttonIcon) {
      return new Expanded(
        child: new OutlineButton(
          //new OutlineButton(child: Icon(Icons.backspace, size: 35, color: Colors.blueGrey), padding: EdgeInsets.all(22), onPressed: (){textControllerInput.text=(textControllerInput.text.length>0)?(textControllerInput.text.substring(0, textControllerInput.text.length-1)):"";},),
          child: Icon(buttonIcon, size: 24, color: Colors.blueGrey) , 
          padding: EdgeInsets.all(28) , 
          onPressed:()=> onButtonPressed(buttonIcon.toString()),
      ));
  }

  Widget createButton(String buttonText) {
    return new Expanded(
      child: new OutlineButton(
        child: Text(buttonText, style: TextStyle(fontSize: 25, color: Colors.blueGrey)) , 
        padding: EdgeInsets.all(25) , 
   
        onPressed:()=> onButtonPressed(buttonText),
    ));
  }

  //This is the first Row of keys
  Row buttonsRow0Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     
      children: <Widget>[
      //  new OutlineButton(child: Text("√", style: TextStyle(fontSize: 25, color: Colors.blueGrey)) , padding: EdgeInsets.all(25) ,
      //  onPressed:()=>setState((){
      //                 num  _result = sqrt(num.parse(textControllerInput.text));
                      
      //                 print(_result);

      //                 if(_result.toString().endsWith(".0"))
      //                 textControllerInput.text= _result.round().toString(); 
      //                 else
      //                 textControllerInput.text= _result.toString(); 

      //                 clearAfterResult = true;
      //             }),
      //             ),
      //createButton("√"),
      createImageButton("sqrt"),
      //createButton("x2"),
      createImageButton("square"),
      //  new OutlineButton(child: Text("x2", style: TextStyle(fontSize: 25, color: Colors.blueGrey)) , padding: EdgeInsets.all(25) ,
      //  onPressed:()=>setState((){
      //                 num _result = pow(num.parse(textControllerInput.text),2);
                      
      //                 print(_result);

      //                 if(_result.toString().endsWith(".0"))
      //                 textControllerInput.text= _result.round().toString(); 
      //                 else
      //                 textControllerInput.text= _result.toString(); 

      //                 clearAfterResult = true;
      //             }),
      //             ),
        
        //new OutlineButton(child: Icon(Icons.backspace, size: 35, color: Colors.blueGrey), padding: EdgeInsets.all(22), onPressed: (){textControllerInput.text=(textControllerInput.text.length>0)?(textControllerInput.text.substring(0, textControllerInput.text.length-1)):"";},),
        createIconButton(Icons.backspace),
        //new OutlineButton(child: Text("/", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(20), color: Colors.deepOrange[200],onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "/";}),),
        createButton("/")
      ],
    );
  }

  //This is the first Row of keys
  Row buttonsRow1Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
     
      children: <Widget>[
        createButton("7"),
        createButton("8"),
        createButton("9"),
        createButton("x")
        // new OutlineButton(
        //   child: Text("7", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),
        //   padding: EdgeInsets.all(20) ,
        
        //   onPressed:()=>setState(() { if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  
        //   textControllerInput.text = textControllerInput.text + "7";}),),
        // new OutlineButton(child: Text("8", style: TextStyle(fontSize: 35, color: Colors.blueGrey)) , padding: EdgeInsets.all(20) ,onPressed:()=>setState(() { if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "8";}),),
        // new OutlineButton(child: Text("9", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(20), onPressed:()=>setState(() { if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "9";}),),
        // new OutlineButton(child: Text("x", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(20), color: Colors.deepOrange[200],onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "*";}),),
      ],
    );
  }
  //This is the second Row of keys
  Row buttonsRow2Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        createButton("4"),
        createButton("5"),
        createButton("6"),
        createButton("-")
        // new OutlineButton(child: Text("4", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(20), onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "4";}),),
        // new OutlineButton(child: Text("5", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(20), onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "5";}),),
        // new OutlineButton(child: Text("6", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(20), onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "6";}),),
        // new OutlineButton(child: Text("-", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(20), color: Colors.deepOrange[200],onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "-";}),),
      ],
    );
  }
  //This is the third Row of keys
  Row buttonsRow3Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        createButton("1"),
        createButton("2"),
        createButton("3"),
        createButton("+")
        // new OutlineButton(child: Text("1", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(20), onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "1";}),),
        // new OutlineButton(child: Text("2", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(20), onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "2";}),),
        // new OutlineButton(child: Text("3", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(20), onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "3";}),),
        // new OutlineButton(child: Text("+", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),color: Colors.deepOrange[200], padding: EdgeInsets.all(20), onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "+";}),)
      ],
    );
  }
  //This is the second Row of keys
  Row buttonsRow4Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        
        // new OutlineButton(child: Icon(Icons.exposure, size: 35, color: Colors.blueGrey), padding: EdgeInsets.all(20), 
        
        // onPressed:()=>setState((){
        //               //textControllerInput.text = "-" + textControllerInput.text;
        //           }),
        
        // ),
        
        createIconButton(Icons.exposure),
        createButton("0"),
        createButton("."),
        createButton("="),
        //new OutlineButton(child: Text("0", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(18), onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "0";}),),
        //new OutlineButton(child: Text(".", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(18), onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + ".";}),),
        
        //new OutlineButton(child: Text("=", style: TextStyle(fontSize: 35, color: Colors.blueGrey)), padding: EdgeInsets.all(18), onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "0";}),),
        // new Align(alignment: Alignment.centerRight,
        //     child: 
        //       Padding(padding: EdgeInsets.all(0),
        //       child: new OutlineButton(
        //         child: Text("=", style: TextStyle(fontSize: 35, color: Colors.red)),
        //         color: Colors.deepOrange,
            
        //         padding: EdgeInsets.all(18),
              
        //         onPressed:(){
        //           //Calculate everything here
        //           // Parse expression:
        //           Parser p = new Parser();
        //           // Bind variables:
        //           ContextModel cm = new ContextModel();
        //           print(textControllerInput.text);
        //           Expression exp = p.parse(textControllerInput.text);
        //           setState(() 
        //           {
        //             double _result = exp.evaluate(EvaluationType.REAL, cm);
        //             print(_result);
        //             if(_result.toString().endsWith(".0"))
        //               textControllerInput.text= _result.round().toString(); 
        //               else
        //               textControllerInput.text= _result.toString(); 

        //             clearAfterResult = true;
        //           });
        //         }
        //       )
        //     ),
        //   ),

      ],
    );
  }


  //This returns a Column for the keypad
  Column keypadContainer() {
    return Column(
        children: <Widget>[
          buttonsRow0Container(),
          buttonsRow1Container(),
          buttonsRow2Container(),
          buttonsRow3Container(),
          buttonsRow4Container(),
          
    ],
    );
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      //APPBAR
      appBar: new AppBar( backgroundColor: clrAppBar,title: new Text("Yet another Calculator..", style: new TextStyle(color: clrAppBarText)),elevation: 1,),
      
      //BODY
        body: Container(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: new TextField(

                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.lime[200],
                          border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(5.0),
                          
                          ),
                          suffix: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: (){textControllerInput.text = "";},
                          ),
                        ),
                        style: TextStyle(fontSize: 35,
                            fontWeight: FontWeight.w400,
                        
                            color: Colors.black87,
                        ),
                        textAlign: TextAlign.right,
                        controller: textControllerInput,
                        onTap: ()=>FocusScope.of(context).requestFocus(new FocusNode()),
                      ),
                    
                  ),

                // new Align(alignment: Alignment.centerRight,
                //   child: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                //   child: new IconButton(icon: Icon(Icons.cancel),
                //           color: Colors.deepPurpleAccent,
                //           onPressed: (){
                //             setState(() {
                //               textControllerInput.text = "";
                              
                //             });
                //           }
                //         )
                //   )
                // ),

                Padding(padding: EdgeInsets.all(50)),

                keypadContainer(),

            ],
          )
      )

    );
  }
}


