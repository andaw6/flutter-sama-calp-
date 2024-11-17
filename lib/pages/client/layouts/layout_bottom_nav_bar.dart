import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/context.dart';
import 'package:wave_odc/pages/client/layouts/controllers/layout_controller.dart';
import 'package:wave_odc/pages/client/layouts/widgets/custom_bottom_nav_bar.dart';
import 'package:wave_odc/providers/data_provider.dart';
import 'package:wave_odc/services/auth/token_expiry_service.dart';
import 'package:wave_odc/utils/constants/colors.dart';

class LayoutBottomNavBar extends StatefulWidget {
  final Widget body;

  const LayoutBottomNavBar({
    super.key,
    required this.body,
  });

  @override
  LayoutBottomNavBarState createState() => LayoutBottomNavBarState();
}

class LayoutBottomNavBarState extends State<LayoutBottomNavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBalanceVisible = false;
  late TokenExpiryService _tokenExpiryService;
  late Context appContext;
  late LayoutController _layoutController;

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
    return Consumer<DataProvider>(builder: (context, provider, child) {
      appContext = provider.context;
      _layoutController = LayoutController(provider: provider, context: context);

      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.backgroundColor,
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
          margin: const EdgeInsets.all(3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: widget.body,
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: provider.selectedIndex,
            onItemTapped:_layoutController.changerPage
        ),
      );
    });
  }
}
