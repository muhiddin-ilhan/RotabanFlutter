import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:nestle_app/core/application/app_session.dart';
import 'package:nestle_app/core/components/snack_bar.dart';
import 'package:nestle_app/core/model/DTOLoginRequest.dart';
import 'package:nestle_app/core/model/DTOLoginResponse.dart';
import 'package:nestle_app/core/model/DTOUserInfo.dart';
import 'package:nestle_app/core/network/network_manager.dart';
import 'package:nestle_app/core/preferences/shared_preferences.dart';
import 'package:nestle_app/core/routing/route_helper.dart';
import 'package:nestle_app/view/main/main_view.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  @observable
  TextEditingController usernameController = TextEditingController();
  @observable
  TextEditingController passwordControllerr = TextEditingController();
  @observable
  bool showPassword = true;
  @observable
  bool isLoading = false;
  @observable
  bool loadingOrSuccessAnim = true;

  @action
  setShowPassword() {
    showPassword = !showPassword;
  }

  // ignore: non_constant_identifier_names
  Future setSharedPrefs(String access_token, String refresh_token) async {
    await SharedManager.instance.setStringValue("access_token", access_token);
    await SharedManager.instance.setStringValue("refresf_token", refresh_token);

    AppSession.instance!.setAccessToken(access_token);
    AppSession.instance!.setRefreshToken(refresh_token);
  }

  @action
  Future<void> login(BuildContext ctx, AnimationController animationController) async {
    isLoading = true;

    if (validateUsername(ctx) && validatePassword(ctx)) {
      try {
        DTOLoginRequest requestData = new DTOLoginRequest(UserName: usernameController.text, Password: passwordControllerr.text, RememberMe: true);

        DTOLoginResponse? response = await NetworkManager.instance!.dioPost("/auth/login", DTOLoginResponse(), requestData);

        if (validateLoginResponse(response)) {
          await setSharedPrefs(response!.access_token!, response.refresh_token!);
          await getUserInfo(ctx, animationController);
          isLoading = false;
        } else {
          showSnackBar(ctx, "Bir Hata Oluştu!");
          isLoading = false;
        }
      } catch (e) {
        print(e);
        showSnackBar(ctx, "İnternet Bağlantınızı Kontrol Edin!");
        isLoading = false;
      }
    } else {
      isLoading = false;
    }
  }

  @action
  Future<void> getUserInfo(BuildContext ctx, AnimationController animationController) async {
    try {
      NetworkManager.instance!.setHeader();
      DTOUserInfo? response = await NetworkManager.instance!.dioGet("/auth/getuserinfo", DTOUserInfo());

      if (validateGetUserInfoResponse(response)) {
        AppSession.instance!.setUserInfo(response!);
        successAnimStart(animationController);
        await Future.delayed(Duration(milliseconds: 1250), () {
          successAnimStop(animationController);
          RouteHelper().pushReplacement(ctx, MainView());
        });
      } else {
        showSnackBar(ctx, "Bir Hata Oluştu!");
      }
    } catch (e) {
      print(e);
      showSnackBar(ctx, "İnternet Bağlantınızı Kontrol Edin!");
    }

    isLoading = false;
  }

  bool validateLoginResponse(DTOLoginResponse? response) {
    if (response == null) return false;

    if (response.access_token == null || response.refresh_token == null) return false;

    if (response.access_token!.isEmpty || response.refresh_token!.isEmpty) return false;

    return true;
  }

  bool validateGetUserInfoResponse(DTOUserInfo? response) {
    if (response == null) return false;

    if (response.username == null || response.name == null || response.surname == null || response.client == null || response.useService == null)
      return false;

    if (response.client!.clientId == null || response.client!.companyName == null || response.client!.logoUrl == null) return false;

    return true;
  }

  bool validateUsername(BuildContext ctx) {
    if (usernameController.text.isEmpty) {
      showSnackBar(ctx, "Kullanıcı Adı Boş Bırakılamaz");
      isLoading = false;
      return false;
    }

    return true;
  }

  bool validatePassword(BuildContext ctx) {
    if (passwordControllerr.text.isEmpty) {
      showSnackBar(ctx, "Şifre Boş Bırakılamaz");
      isLoading = false;
      return false;
    }

    return true;
  }

  void successAnimStart(AnimationController animationController) async {
    animationController.reset();
    animationController.forward();
    loadingOrSuccessAnim = false;
  }

  void successAnimStop(AnimationController animationController) async {
    animationController.reset();
    loadingOrSuccessAnim = true;
  }
}
