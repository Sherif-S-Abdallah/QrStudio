import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_onetime_onboarding_page/Components/color.dart';
import 'package:gal/gal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/quickalert.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class Generate extends StatefulWidget {
  Generate({Key? key}) : super(key: key);

  @override
  State<Generate> createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  TextEditingController _controller = TextEditingController();
  WidgetsToImageController controller = WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(title: const Text('Genrate QR Code')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter data to generate QR code',
              ),
            ),
            SizedBox(height: 20),
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
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      //pop up dialog with qr code
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        barrierDismissible: true,
                        widget: Column(
                          children: [
                            WidgetsToImage(
                              controller: controller,
                              child: QrImageView(
                                data: _controller.text,
                                version: QrVersions.auto,
                                size: 200.0,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //save icon and share icon
                                IconButton(
                                  onPressed: () async {
                                    final bytes = await controller.capture();
                                    await Gal.putImageBytes(bytes!,
                                        album: 'QrStudio');
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Saved! ✅'),
                                        action: SnackBarAction(
                                          label: 'Gallery ->',
                                          onPressed: () async => Gal.open(),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.save,
                                    size: 40,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final bytes = await controller.capture();
                                    final result = await Share.shareXFiles(
                                      [XFile.fromData(bytes!)],
                                      text: 'QR Code',
                                    );
                                    if (result.status ==
                                        ShareResultStatus.success) {
                                      print('Thank you for sharing the picture!');
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    size: 40,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        showConfirmBtn: false,
                      );
                    }
                  },
                  child: const Text(
                    "Generate QR Code",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
