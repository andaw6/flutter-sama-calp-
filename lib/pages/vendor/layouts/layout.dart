import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/context.dart';
import 'package:wave_odc/pages/vendor/layouts/controllers/layout_controller.dart';
import 'package:wave_odc/pages/vendor/layouts/widgets/custom_app_bar.dart';
import 'package:wave_odc/pages/vendor/layouts/widgets/custom_bottom_nav_bar.dart';
import 'package:wave_odc/providers/data_provider.dart';
import 'package:wave_odc/services/auth/token_expiry_service.dart';
import 'package:wave_odc/utils/constants/colors.dart';

class VendorLayout extends StatefulWidget {
  final Widget body;
  final String title;

  const VendorLayout(
      {super.key, required this.body, this.title = 'Sama Calpé'});

  @override
  BaseLayoutState createState() => BaseLayoutState();
}

class BaseLayoutState extends State<VendorLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late LayoutController _layoutController;
  bool isBalanceVisible = false;
  late TokenExpiryService _tokenExpiryService;
  late Context appContext;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  void _loadToken() {
    _tokenExpiryService = locator<TokenExpiryService>();
    _tokenExpiryService.setContext(context);
    _tokenExpiryService.startTokenExpiryCheck();
  }

  @override
  void dispose() {
    _tokenExpiryService.stopTokenExpiryCheck();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, provider, child){
      appContext = provider.context;
      _layoutController = LayoutController(provider: provider, context: context);

      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppBar(
          title: widget.title,
          scaffoldKey: _scaffoldKey,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: widget.body,
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: provider.selectedIndex, onItemTapped: _layoutController.changerPage),
      );
    });
  }
}
