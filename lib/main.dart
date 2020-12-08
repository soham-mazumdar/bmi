import 'package:bmi/ad_manager.dart';
import 'package:bmi/utils/ui.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BMI());
}

class BMI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        canvasColor: AppColors.canvasColor,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  InterstitialAd _interstitialAd;
  
  bool _isInterstitialAdReady;

  void _loadInterstitialAd() {
    _interstitialAd.load();
  }

  void _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        print('Failed to load an interstitial ad');
        break;
      case MobileAdEvent.closed:
        // _moveToHome();
        break;
      default:
      // do nothing
    }
  }

  

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: AdManager.appId);
    _isInterstitialAdReady = false;
    
    _interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: _onInterstitialAdEvent,
    );
    
    _loadInterstitialAd();
    
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  TextEditingController massController = TextEditingController(text: '0');
  TextEditingController heightController = TextEditingController(text: '0');
  double bmi = 0;
  

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 13,
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Container(
                child: Center(
                  child: Image.asset('assets/logo.png',width: 200,),
                )
              ),
              SizedBox(height: 50,),
              Row(
                children: [
                    Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: massController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                        ),
                        decoration: new InputDecoration(
                          labelText: "mass (kg)",
                          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(color: Theme.of(context).primaryColor),
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                      ),
                    ),
                  ), 
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                        ),
                        decoration: new InputDecoration(
                          labelText: "Height (meters)",
                          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(color: Theme.of(context).primaryColor),
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                      ),
                    ),
                  ), 
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  setState(() {
                    double _mass = double.parse(massController.text);
                    double _height = double.parse(heightController.text);
                    bmi = _mass / (_height * _height);
                    _interstitialAd.show();
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'Calculate',
                    style: TextStyle(fontSize: 26, color: Theme.of(context).canvasColor)
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                bmi > 0 ? 'BMI : ' + bmi.toStringAsFixed(2) : '',
                style: TextStyle(fontSize: 28, color: Theme.of(context).primaryColor)
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).primaryColor
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Body mass index is a value derived from the mass and height of a person. The BMI is defined as the body mass divided by the square of the body height, and is universally expressed in units of kg/m²,',
                  style : TextStyle(fontSize: 15, color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        )
      ),
    );
  }
}

