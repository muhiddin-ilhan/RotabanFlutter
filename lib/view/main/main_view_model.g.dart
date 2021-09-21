// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainViewModel on _MainViewModelBase, Store {
  final _$isLoadingAtom = Atom(name: '_MainViewModelBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$qrKeyAtom = Atom(name: '_MainViewModelBase.qrKey');

  @override
  GlobalKey<State<StatefulWidget>> get qrKey {
    _$qrKeyAtom.reportRead();
    return super.qrKey;
  }

  @override
  set qrKey(GlobalKey<State<StatefulWidget>> value) {
    _$qrKeyAtom.reportWrite(value, super.qrKey, () {
      super.qrKey = value;
    });
  }

  final _$isFlashOpenAtom = Atom(name: '_MainViewModelBase.isFlashOpen');

  @override
  bool get isFlashOpen {
    _$isFlashOpenAtom.reportRead();
    return super.isFlashOpen;
  }

  @override
  set isFlashOpen(bool value) {
    _$isFlashOpenAtom.reportWrite(value, super.isFlashOpen, () {
      super.isFlashOpen = value;
    });
  }

  final _$controllerAtom = Atom(name: '_MainViewModelBase.controller');

  @override
  QRViewController? get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(QRViewController? value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  final _$userAtom = Atom(name: '_MainViewModelBase.user');

  @override
  DTOUserInfo? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(DTOUserInfo? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$positionAtom = Atom(name: '_MainViewModelBase.position');

  @override
  Position? get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(Position? value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  final _$ctxAtom = Atom(name: '_MainViewModelBase.ctx');

  @override
  BuildContext? get ctx {
    _$ctxAtom.reportRead();
    return super.ctx;
  }

  @override
  set ctx(BuildContext? value) {
    _$ctxAtom.reportWrite(value, super.ctx, () {
      super.ctx = value;
    });
  }

  final _$getUserInfoAsyncAction =
      AsyncAction('_MainViewModelBase.getUserInfo');

  @override
  Future<dynamic> getUserInfo() {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo());
  }

  final _$alertDialogAsyncAction =
      AsyncAction('_MainViewModelBase.alertDialog');

  @override
  Future<dynamic> alertDialog(
      AlertType type, String title, String desc, String btnText) {
    return _$alertDialogAsyncAction
        .run(() => super.alertDialog(type, title, desc, btnText));
  }

  final _$readQRCodeAsyncAction = AsyncAction('_MainViewModelBase.readQRCode');

  @override
  Future<bool> readQRCode(Map<String, dynamic> requestDate) {
    return _$readQRCodeAsyncAction.run(() => super.readQRCode(requestDate));
  }

  final _$startLocationListenerAsyncAction =
      AsyncAction('_MainViewModelBase.startLocationListener');

  @override
  Future<dynamic> startLocationListener() {
    return _$startLocationListenerAsyncAction
        .run(() => super.startLocationListener());
  }

  final _$getLocationAsyncAction =
      AsyncAction('_MainViewModelBase.getLocation');

  @override
  Future<dynamic> getLocation() {
    return _$getLocationAsyncAction.run(() => super.getLocation());
  }

  final _$signOutAsyncAction = AsyncAction('_MainViewModelBase.signOut');

  @override
  Future<void> signOut(BuildContext ctx) {
    return _$signOutAsyncAction.run(() => super.signOut(ctx));
  }

  final _$_MainViewModelBaseActionController =
      ActionController(name: '_MainViewModelBase');

  @override
  void setCtx(BuildContext context) {
    final _$actionInfo = _$_MainViewModelBaseActionController.startAction(
        name: '_MainViewModelBase.setCtx');
    try {
      return super.setCtx(context);
    } finally {
      _$_MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onQRViewCreated(QRViewController controller) {
    final _$actionInfo = _$_MainViewModelBaseActionController.startAction(
        name: '_MainViewModelBase.onQRViewCreated');
    try {
      return super.onQRViewCreated(controller);
    } finally {
      _$_MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
qrKey: ${qrKey},
isFlashOpen: ${isFlashOpen},
controller: ${controller},
user: ${user},
position: ${position},
ctx: ${ctx}
    ''';
  }
}
