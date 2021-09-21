import 'package:nestle_app/core/model/DTOUserInfo.dart';

class AppSession {
  static AppSession? _instance;

  static AppSession? get instance {
    if (_instance == null) {
      _instance = AppSession();
    }

    return _instance;
  }

  String _accessToken = "";

  String _refreshToken = "";

  DTOUserInfo? _user;

  bool _isOpenDialog = false;

  void setIsOpenDialog(bool value) {
    this._isOpenDialog = value;
  }

  bool getIsOpenDialog() {
    return this._isOpenDialog;
  }

  void setUserInfo(DTOUserInfo value) {
    this._user = value;
  }

  DTOUserInfo? getUserInfo() {
    return this._user;
  }

  void setAccessToken(String value) {
    this._accessToken = value;
  }

  String getAccessToken() {
    return this._accessToken;
  }

  void setRefreshToken(String value) {
    this._refreshToken = value;
  }

  String getRefreshToken() {
    return this._refreshToken;
  }
}
