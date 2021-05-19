

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:model_viewer/model_viewer.dart';
import 'package:the_great_hunt/ressource/bdd.dart';
import 'package:the_great_hunt/ressource/constante.dart';

class MyHomePage extends StatefulWidget {





  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int  _selectedIndex = 0;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var Menu;
  var icon;
  QRViewController controller;
  Barcode result;
  bool scaned=true;


  @override
  Widget build(BuildContext context) {
      this.Menu=[mapMenu(),messageMenu(),QrCodeMenu(),null];
      this.icon=[SvgPicture.asset("assets/images/wind_rose.svg",width: MediaQuery.of(context).size.width*0.36,),SvgPicture.asset("assets/images/XMLID_1491_.svg",width: MediaQuery.of(context).size.width*0.25),SvgPicture.asset("assets/images/telescope.svg",width: MediaQuery.of(context).size.width*0.25),SvgPicture.asset("assets/images/treasure-chest.svg",width: MediaQuery.of(context).size.width*0.22)];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            backgroundColor: Color(0xffB48346),
           centerTitle: true,
           title: Text("The Great Hunt"),
           // hides leading widget

          )
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.2,
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.1,
                    decoration: BoxDecoration(
                      border: Border.all(color:Color(0xffB48346),width: 5),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: Row(
                      children: [
                        Container(width: MediaQuery.of(context).size.width*0.2,height:MediaQuery.of(context).size.height*0.1 ,child: FlatButton(onPressed: (){setState(() {
                          this._selectedIndex=0;
                        });},child: SvgPicture.asset("assets/images/compass msg.svg",width:MediaQuery.of(context).size.width*0.15,height: MediaQuery.of(context).size.height*0.1,)),),
                        Container(width: MediaQuery.of(context).size.width*0.2,height:MediaQuery.of(context).size.height*0.1 ,child: FlatButton(onPressed: (){setState(() {
                          this._selectedIndex=1;
                        });},child: SvgPicture.asset("assets/images/comment msg.svg",width:MediaQuery.of(context).size.width*0.15,height: MediaQuery.of(context).size.height*0.1,)),),
                        Spacer(),
                        Container(width: MediaQuery.of(context).size.width*0.2,height:MediaQuery.of(context).size.height*0.1 ,child: FlatButton(onPressed: (){setState(() {
                          this._selectedIndex=2;
                        });},child: SvgPicture.asset("assets/images/qr-code-scan msg.svg",width:MediaQuery.of(context).size.width*0.15,height: MediaQuery.of(context).size.height*0.1,)),),
                        Container(width: MediaQuery.of(context).size.width*0.2,height:MediaQuery.of(context).size.height*0.1 ,child: FlatButton(onPressed: (){
                          setState(() {
                            this._selectedIndex=3;
                          });
                        },child: SvgPicture.asset("assets/images/lb msg.svg",width:MediaQuery.of(context).size.width*0.15,height: MediaQuery.of(context).size.height*0.1,)),),
                      ],
                    ),
                )
            ),
            Center(
              child: this.icon[this._selectedIndex],
            )          ],
        ),
        decoration: BoxDecoration(
          color: Colors.transparent
        ),
      ),
      drawer: Drawer(
        child:Container(
          color: Color(0xffC7A375) ,
          child: Column(
            children: [
              SvgPicture.asset("assets/images/pirateblue.svg")
            ],
          ),
        ),
      ),
      body: Menu[_selectedIndex],

    );
  }
  mapMenu(){
    return Center(

      child: Stack(
        children: [
          InteractiveViewer(
            minScale: 2.5,
            maxScale: 25,
            panEnabled: true,
            constrained: true,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color:Color(0xffF5EECB),
              child: Stack(
                children: [
                  Positioned(child: Image.asset("assets/images/map.png",height: 200,width: 200,),bottom: 0,top: 0,left: 0,right: 0,),

                ],
              ),        ),
          ),

        ],
      )
    );
  }
  QrCodeMenu(){
    return Center(

          // To ensure the Scanner view is properly sizes after rotation
          // we need to listen for Flutter SizeChanged notification and update controller

            child: Stack(
              children: [
                 SizeChangedLayoutNotifier(
                  key: const Key('qr-size-notifier'),
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
            Container(
             height: MediaQuery.of(context).size.height*0.7,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.1),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  height:  MediaQuery.of(context).size.width*0.6,

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red,width: 5),
                    borderRadius: BorderRadius.circular(10),
                        
                  ),
                ),
              ),
               ),

              ],
            )

        );

  }
  messageMenu(){
    message=[];
    var taille=list_hint.length;
    int i=0;
    while(i<taille){
      message.add(SizedBox(height: 20));
      message.add(
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red
              ),
              width: MediaQuery.of(context).size.width*0.45,
              child: Text(
                list_hint[i]["hint"]

              ),
            )
          ],
        )
          );

      i=i+1;
    }
    return SingleChildScrollView(
      child: Column(
        children: message,
      ),
    );
  }
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {

        result = scanData;
        var qr=result.code;
        if(!bdd.isOpen){
          await ouvrirbdd();
          var sqlresultat=await bdd.query("QR",where: "id='${qr}'");
          if(sqlresultat.isNotEmpty){
            if(sqlresultat[0]["isnot"]==0){
              var update={"id":sqlresultat[0]["id"],"isnot":1,"iditem":sqlresultat[0]["iditem"]};
              print(update);
              await bdd.update("QR", update);

              var itemtuple=await bdd.query("ITEM",where: "id=${update["iditem"]}");
              print(itemtuple);
              bdd.close();
              showCupertinoDialog(context: context,
                  builder: (BuildContext context) {

                    return CupertinoDialog(

                        child: Container(
                          color: Colors.yellow,
                          height: MediaQuery.of(context).size.height*0.7,
                          width: 100,
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.7*0.1,
                                  child: Text (itemtuple[0]["name"],style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black
                                  ),),
                                ),
                              ),
                             Container(
                               color: Colors.transparent,
                               height: MediaQuery.of(context).size.height*0.7*0.3,
                               child:  ModelViewer(
                                 backgroundColor: Colors.transparent,
                                 src: itemtuple[0]["modelpath"],

                                 cameraControls: true,
                                 autoPlay: true,
                               ),
                             )
                            ],
                          ),


                        ));
                  });

            }
            else{
              await bdd.close();
            }
          }else{
           await  bdd.close();
          }
        }






    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
