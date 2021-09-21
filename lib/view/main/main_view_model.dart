import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:nestle_app/core/application/app_session.dart';
import 'package:nestle_app/core/model/DTOClient.dart';
import 'package:nestle_app/core/model/DTOReadQRCodeResponse.dart';
import 'package:nestle_app/core/model/DTOUserInfo.dart';
import 'package:nestle_app/core/network/network_manager.dart';
import 'package:nestle_app/core/permission/permission_helper.dart';
import 'package:nestle_app/core/preferences/shared_preferences.dart';
import 'package:nestle_app/core/routing/route_helper.dart';
import 'package:nestle_app/view/authenticate/login/login_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

part 'main_view_model.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store {
  @observable
  bool isLoading = true;
  @observable
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @observable
  bool isFlashOpen = false;
  @observable
  QRViewController? controller;
  @observable
  DTOUserInfo? user;
  @observable
  Position? position;
  @observable
  BuildContext? ctx;

  @action
  Future getUserInfo() async {
    if (AppSession.instance!.getUserInfo() != null) {
      user = AppSession.instance!.getUserInfo();
    } else {
      user = new DTOUserInfo(
          name: "Bilgi",
          surname: "Getirilemedi",
          username: "bilgi.getirilemedi",
          useService: false,
          client: new DTOClient(clientId: "0", companyName: "...", logoUrl: ".."));
    }
  }

  @action
  void setCtx(BuildContext context) {
    ctx = context;
  }

  @action
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      await controller.pauseCamera();

      if (position == null) {
        await getLocation();
      }

      if (!scanData.code.contains("SeatNum")) {
        await alertDialog(AlertType.error, "Hata", "Hatalı Bir QR Okuttunuz", "Tamam");
        await controller.resumeCamera();
        return;
      }

      Map<String, dynamic> qrData = jsonDecode(scanData.code);

      if (!qrData.containsKey("PlateNo") || !qrData.containsKey("SeatNum") || !qrData.containsKey("Key")) {
        await alertDialog(AlertType.error, "Hata", "Hatalı Bir QR Okuttunuz", "Tamam");
        await controller.resumeCamera();
        return;
      }

      if (position == null) {
        await alertDialog(AlertType.error, "Konum Hatası", "Konumunuzu Alamıyoruz, Az sonra tekrar deneyiniz", "Tamam");
        await controller.resumeCamera();
        return;
      }

      Map<String, dynamic> requestData = {
        "SeatNum": qrData["SeatNum"],
        "QRCodeKey": qrData["Key"],
        "Lat": position!.latitude,
        "Lng": position!.longitude
      };

      bool result = await readQRCode(requestData);

      if (result) {
        await alertDialog(AlertType.success, "Başarılı", "QR Okutma Başarıyla Gerçekleşti", "Kapat");
      } else {
        await alertDialog(AlertType.error, "Hata", "QR Okuturken Bir Hata Oluştu", "Tamam");
      }

      await Future.delayed(Duration(milliseconds: 500), () async {
        await controller.resumeCamera();
      });
    }).onError((error) {
      print(error);
      controller.resumeCamera();
      return;
    });
  }

  @action
  Future alertDialog(AlertType type, String title, String desc, String btnText) async {
    await Alert(
      context: ctx!,
      type: type,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            btnText,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (btnText == "Kapat") {
              if(Platform.isAndroid)
                SystemNavigator.pop();
              else
                exit(0);
            } else {
              Navigator.pop(ctx!);
            }
          },
        )
      ],
    ).show();
  }

  @action
  Future<bool> readQRCode(Map<String, dynamic> requestDate) async {
    try {
      DTOReadQRCodeResponse? response = await NetworkManager.instance!.dioPost("/auth/ReadQRCodeData", DTOReadQRCodeResponse(), requestDate);

      if (response == null) return false;

      if (response.code == null) return false;

      if (response.code == 0) return false;

      if (response.code == 1) return true;

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @action
  Future startLocationListener() async {
    Geolocator.getPositionStream().listen((Position pos) {
      position = pos;
    });
  }

  @action
  Future getLocation() async {
    try {
      position = await Geolocator.getCurrentPosition().timeout(Duration(seconds: 8));
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> signOut(BuildContext ctx) async {
    await SharedManager.instance.setStringValue("access_token", "");
    await SharedManager.instance.setStringValue("refresh_token", "");
    await RouteHelper().puhsAndCloseOther(ctx, LoginView());
  }
}
