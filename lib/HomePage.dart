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



  //This is the first Row of keys
  Row buttonsRow1Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton(child: Text("7", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),onPressed:()=>setState(() { if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "7";}),),
        new FlatButton(child: Text("8", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),onPressed:()=>setState(() { if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "8";}),),
        new FlatButton(child: Text("9", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),onPressed:()=>setState(() { if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "9";}),),
        new FlatButton(child: Text("/", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),color: Color.fromARGB(50, 119, 96, 204),onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "/";}),),
      ],
    );
  }
  //This is the second Row of keys
  Row buttonsRow2Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton(child: Text("4", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "4";}),),
        new FlatButton(child: Text("5", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "5";}),),
        new FlatButton(child: Text("6", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "6";}),),
        new FlatButton(child: Text("x", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),color: Color.fromARGB(50, 119, 96, 204),onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "*";}),),
      ],
    );
  }
  //This is the third Row of keys
  Row buttonsRow3Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton(child: Text("1", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "1";}),),
        new FlatButton(child: Text("2", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "2";}),),
        new FlatButton(child: Text("3", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "3";}),),
        new FlatButton(child: Text("-", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),color: Color.fromARGB(50, 119, 96, 204),onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "-";}),),
      ],
    );
  }
  //This is the second Row of keys
  Row buttonsRow4Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton(child: Text(".", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + ".";}),),
        new FlatButton(child: Text("0", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),onPressed:()=>setState(() {if(clearAfterResult==true){textControllerInput.text="";clearAfterResult=false;}  textControllerInput.text = textControllerInput.text + "0";}),),
        new FlatButton(child: Icon(Icons.backspace, size: 35, color: Colors.blueGrey), onPressed: (){textControllerInput.text=(textControllerInput.text.length>0)?(textControllerInput.text.substring(0, textControllerInput.text.length-1)):"";},),
        new FlatButton(child: Text("+", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),color: Color.fromARGB(50, 119, 96, 204),onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "+";}),)
      ],
    );
  }


  //This returns a Column for the keypad
  Column keypadContainer() {
    return Column(
        children: <Widget>[
          buttonsRow1Container(),
          buttonsRow2Container(),
          buttonsRow3Container(),
          buttonsRow4Container(),
          new Align(alignment: Alignment.centerRight,
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: new FlatButton(
                child: Text("=", style: TextStyle(fontSize: 35, color: Colors.white)),
                color: Colors.deepPurple,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                onPressed:(){
                  //Calculate everything here
                  // Parse expression:
                  Parser p = new Parser();
                  // Bind variables:
                  ContextModel cm = new ContextModel();
                  Expression exp = p.parse(textControllerInput.text);
                  setState(() {
                    textControllerInput.text=exp.evaluate(EvaluationType.REAL, cm).toString();
                    clearAfterResult = true;
                  });
                }
              )
            ),
          ),
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
      
      //APPBAR
      appBar: new AppBar( backgroundColor: clrAppBar,
        title: new Text("Calulator", style: new TextStyle(color: clrAppBarText)),
        elevation: 0,
       
    ),
      //BODY
        body: Container(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: new TextField(
                        decoration: new InputDecoration(
                          fillColor: Colors.yellow[50],
                          border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10.0)
                          ),
                          suffix: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: (){textControllerInput.text = "";},
                          ),
                        ),
                        style: TextStyle(fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87
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

