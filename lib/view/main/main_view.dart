import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nestle_app/core/base/state/base_state.dart';
import 'package:nestle_app/core/base/view/BaseView.dart';
import 'package:nestle_app/core/components/bottom_sheet_dialog.dart';
import 'package:nestle_app/core/localization/app_localization.dart';
import 'package:nestle_app/core/routing/route_helper.dart';
import 'package:nestle_app/view/main/main_view_model.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends BaseState<MainView> {
  MainViewModel viewModel = MainViewModel();

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context);
    return BaseView<MainViewModel>(
      onModelReady: (model) {
        viewModel = model;
      },
      viewModel: MainViewModel(),
      onDispose: () {},
      onPageBuilder: (ctx, value) {
        viewModel.setCtx(context);
        viewModel.getUserInfo();
        viewModel.startLocationListener();
        return scaffold;
      },
    );
  }

  Widget get scaffold => WillPopScope(
        onWillPop: onBackPress,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(230, 230, 230, 1),
          appBar: appBar,
          body: Stack(
            children: [
              qrCode(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: dynamicWidth(0.75),
                  height: dynamicHeight(0.12),
                  margin: EdgeInsets.only(bottom: dynamicHeight(0.025)),
                  child: nameCard(),
                ),
              ),
            ],
          ),
        ),
      );

  AppBar get appBar => AppBar(
        title: Text("Rotaban Servisteyim"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on),
            onPressed: () {
              if (viewModel.controller != null) viewModel.controller!.toggleFlash();
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            openSignOutDialog();
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade600, Colors.blue.shade800],
            ),
          ),
        ),
      );

  Widget qrCode() {
    return GestureDetector(
              onDoubleTap: () {
                if (viewModel.controller != null) viewModel.controller!.flipCamera();
              },
              child: QRView(
                key: viewModel.qrKey,
                onQRViewCreated: viewModel.onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  cutOutSize: dynamicWidth(0.75),
                  //overlayColor: Color.fromRGBO(230, 230, 230, 1),
                  borderRadius: dynamicHeight(0.05),
                  borderColor: Colors.blue,
                  borderLength: dynamicWidth(0.15),
                  borderWidth: dynamicHeight(0.01),
                ),
              ),
      
    );
  }

  Widget nameCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      color: Color.fromRGBO(0, 0, 0, 0.15),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(dynamicWidth(0.04)),
        child: Observer(
          builder: (context) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    viewModel.user!.name! + " " + viewModel.user!.surname!,
                    style: TextStyle(fontSize: dynamicWidth(0.05), fontWeight: FontWeight.w600, color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
                SizedBox(
                  height: dynamicHeight(0.01),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    viewModel.user!.client!.companyName!,
                    style: TextStyle(fontSize: dynamicWidth(0.045), fontWeight: FontWeight.w500, color: Color.fromRGBO(255, 255, 255, 0.7)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openSignOutDialog() async {
    openBottomSheetDialog(
        context: context,
        dialogTitle: "Oturumu Kapat",
        dialogMessage: "Oturumu Kapatmak İstediğine Emin Misin?",
        negativeButtonText: "Hayır",
        negativeButtonOnPress: () {
          RouteHelper().pop(context);
        },
        positiveButtonText: "Evet",
        positiveButtonOnPress: () async {
          await viewModel.signOut(context);
        });
  }

  Future<bool> onBackPress() async {
    openBottomSheetDialog(
        context: context,
        dialogTitle: "Uygulamayı Kapat",
        dialogMessage: "Uygulamayı Kapatmak İstediğine Emin Misin?",
        negativeButtonText: "Hayır",
        negativeButtonOnPress: () {
          RouteHelper().pop(context);
        },
        positiveButtonText: "Evet",
        positiveButtonOnPress: () async {
          SystemNavigator.pop();
        });

    return false;
  }
}
