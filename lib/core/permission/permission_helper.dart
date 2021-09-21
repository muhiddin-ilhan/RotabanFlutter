import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nestle_app/core/application/app_session.dart';
import 'package:nestle_app/core/components/bottom_sheet_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<int> checkAndRequestCameraPermission() async {
    PermissionStatus permissionStatus = await Permission.camera.request();
    if (permissionStatus.isDenied)
      return 0;
    else if (permissionStatus.isPermanentlyDenied)
      return -1;
    else
      return 1;
  }

  static void openCameraAppSetting(BuildContext context) async {
    AppSession.instance!.setIsOpenDialog(true);
    openBottomSheetDialog(
        context: context,
        dialogTitle: "Kamera İzniniz Yetersiz",
        dialogMessage: "Lütfen Uygulama Ayarlarından Kamera İzni Veriniz",
        negativeButtonText: "Reddet",
        barrierDismissible: false,
        negativeButtonOnPress: () async {
          if (await checkAndRequestCameraPermission() == 1) {
            AppSession.instance!.setIsOpenDialog(false);
            Navigator.pop(context);
          }
        },
        positiveButtonText: "Aç",
        positiveButtonOnPress: () async {
          Navigator.pop(context);
          await Geolocator.openAppSettings();
        });
  }

  static Future<bool> controlCameraPermission(BuildContext ctx) async {
    int cameraPermission = await PermissionHelper.checkAndRequestCameraPermission();
    if (cameraPermission != 1) {
      if (cameraPermission == 0) {
        while (cameraPermission == 0) {
          cameraPermission = await PermissionHelper.checkAndRequestCameraPermission();
          await Future.delayed(Duration(milliseconds: 500));
        }
      }
      if (cameraPermission == -1) {
        while (await Permission.camera.status != PermissionStatus.granted) {
          if (!(AppSession.instance!.getIsOpenDialog())) {
            PermissionHelper.openCameraAppSetting(ctx);
          }
          await Future.delayed(Duration(milliseconds: 500));
        }
        cameraPermission = 2;
      }
      if (cameraPermission == 2) {
        if (AppSession.instance!.getIsOpenDialog()) {
          Navigator.pop(ctx);
        }
      }
    }

    return true;
  }

  static Future<int> checkAndRequestLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isDenied)
      return 0;
    else if (permissionStatus.isPermanentlyDenied)
      return -1;
    else
      return 1;
  }

  static void openLocationAppSetting(BuildContext context) async {
    AppSession.instance!.setIsOpenDialog(true);
    openBottomSheetDialog(
        context: context,
        dialogTitle: "Konum İzniniz Yetersiz",
        dialogMessage: "Lütfen Uygulama Ayarlarından Konum İzni Veriniz",
        negativeButtonText: "Reddet",
        barrierDismissible: false,
        negativeButtonOnPress: () async {
          if (await checkAndRequestLocationPermission() == 1) {
            AppSession.instance!.setIsOpenDialog(false);
            Navigator.pop(context);
          }
        },
        positiveButtonText: "Aç",
        positiveButtonOnPress: () async {
          Navigator.pop(context);
          await openAppSettings();
        });
  }

  static Future<bool> controlLocationPermission(BuildContext ctx) async {
    int locationPermission = await PermissionHelper.checkAndRequestLocationPermission();
    if (locationPermission != 1) {
      if (locationPermission == 0) {
        while (locationPermission == 0) {
          locationPermission = await PermissionHelper.checkAndRequestLocationPermission();
          await Future.delayed(Duration(milliseconds: 500));
        }
      }
      if (locationPermission == -1) {
        while (await Permission.location.status != PermissionStatus.granted) {
          if (!(AppSession.instance!.getIsOpenDialog())) {
            PermissionHelper.openLocationAppSetting(ctx);
          }
          await Future.delayed(Duration(milliseconds: 500));
        }
        locationPermission = 2;
      }
      if (locationPermission == 2) {
        if (AppSession.instance!.getIsOpenDialog()) {
          Navigator.pop(ctx);
        }
      }
    }

    return true;
  }

  static Future<int> checkLocationService() async {
    bool locationServiceStatus = await Geolocator.isLocationServiceEnabled();
    if (locationServiceStatus)
      return 1;
    else
      return 0;
  }

  static void openLocationServiceSettings(BuildContext context) {
    openBottomSheetDialog(
        context: context,
        dialogTitle: "Konum Hizmetleriniz Kapalı",
        dialogMessage: "Lütfen Cihazınızın Konum Hizmetlerini Aktif Hale Getirin",
        negativeButtonText: "Reddet",
        barrierDismissible: false,
        negativeButtonOnPress: () async {
          if (await checkLocationService() == 1) Navigator.pop(context);
        },
        positiveButtonText: "Aç",
        positiveButtonOnPress: () async {
          Navigator.pop(context);
          await Geolocator.openLocationSettings();
        });
  }
}
