import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:nestle_app/core/application/app_session.dart';
import 'package:nestle_app/core/model/DTOUserInfo.dart';
import 'package:nestle_app/core/network/network_manager.dart';
import 'package:nestle_app/core/permission/permission_helper.dart';
import 'package:nestle_app/core/preferences/shared_preferences.dart';
import 'package:nestle_app/core/routing/route_helper.dart';
import 'package:nestle_app/view/authenticate/login/login_view.dart';
import 'package:nestle_app/view/main/main_view.dart';

part 'splash_view_model.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store {
  @action
  isUserLogin(BuildContext ctx) async {
    await SharedManager.preferencesInit();
    String accessToken = await SharedManager.instance.getStringValue("access_token") ?? "";

    await PermissionHelper.controlCameraPermission(ctx);

    await PermissionHelper.controlLocationPermission(ctx);

    if (accessToken != "") {
      try {
        NetworkManager.instance!.setCustomHeader(accessToken);

        bool? response = await NetworkManager.instance!.dioGetNoMode("/auth/isauthenticated");
        if (response != null) {
          if (response) {
            await getUserInfo(ctx);
            return;
          } else {
            RouteHelper().pushReplacement(ctx, LoginView());
          }
        } else {
          RouteHelper().pushReplacement(ctx, LoginView());
        }
      } catch (e) {
        print(e);
        RouteHelper().pushReplacement(ctx, LoginView());
      }
    } else {
      RouteHelper().pushReplacement(ctx, LoginView());
    }
  }

  @action
  Future<void> getUserInfo(BuildContext ctx) async {
    try {
      NetworkManager.instance!.setHeader();
      DTOUserInfo? response = await NetworkManager.instance!.dioGet("/auth/getuserinfo", DTOUserInfo());

      if (validateGetUserInfoResponse(response)) {
        AppSession.instance!.setUserInfo(response!);
        RouteHelper().pushReplacement(ctx, MainView());
      } else {
        RouteHelper().pushReplacement(ctx, LoginView());
      }
    } catch (e) {
      print(e);
      RouteHelper().pushReplacement(ctx, LoginView());
    }
  }

  bool validateGetUserInfoResponse(DTOUserInfo? response) {
    if (response == null) return false;

    if (response.username == null || response.name == null || response.surname == null || response.client == null || response.useService == null)
      return false;

    if (response.client!.clientId == null || response.client!.companyName == null || response.client!.logoUrl == null) return false;

    return true;
  }
}
