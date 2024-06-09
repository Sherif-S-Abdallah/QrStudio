import 'package:flutter/material.dart';
import 'package:flutter_onetime_onboarding_page/Components/color.dart';
import 'package:flutter_onetime_onboarding_page/barcode_scanner_view.dart';
import 'package:flutter_onetime_onboarding_page/genrate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Image.asset('assets/qr-code-codigo-qr.gif'),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.orange,
            ),
            width: MediaQuery.of(context).size.width * .9,
            height: 55,
            child: TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                            (state) => MyColors.orange),
                    backgroundColor: MaterialStateProperty.resolveWith(
                            (state) => MyColors.orange)),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BarcodeScannerView()));
                },
                child: const Text(
                  "Scan Qr Code",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.orange,
            ),
            width: MediaQuery.of(context).size.width * .9,
            height: 55,
            child: TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                            (state) => MyColors.orange),
                    backgroundColor: MaterialStateProperty.resolveWith(
                            (state) => MyColors.orange)),
                onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Generate()));
                },
                child: const Text(
                  "Generate QR Code",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.orange,
            ),
            width: MediaQuery.of(context).size.width * .9,
            height: 55,
            child: TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (state) => MyColors.orange),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (state) => MyColors.orange)),
                onPressed: () async{
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('onboarding', false);
                  Navigator.pushReplacementNamed(context, '/onboarding');
                },
                child: const Text(
                  "Reset Onboarding",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ),
        ],
      ),
    );
  }
}
