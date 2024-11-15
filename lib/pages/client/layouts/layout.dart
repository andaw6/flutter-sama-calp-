import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/context.dart';
import 'package:wave_odc/pages/client/layouts/widgets/aside_bar.dart';
import 'package:wave_odc/pages/client/layouts/widgets/custom_app_bar.dart';
import 'package:wave_odc/pages/client/layouts/widgets/custom_bottom_nav_bar.dart';
import 'package:wave_odc/providers/data_provider.dart';
import 'package:wave_odc/services/token_expiry_service.dart';
import 'package:wave_odc/utils/constants/colors.dart';

class ClientLayout extends StatefulWidget {
  final Widget body;
  final String title;

  const ClientLayout(
      {super.key, required this.body, this.title = 'Sama Calpé'});

  @override
  BaseLayoutState createState() => BaseLayoutState();
}

class BaseLayoutState extends State<ClientLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBalanceVisible = false;
  int _selectedIndex = 0;
  late TokenExpiryService _tokenExpiryService;
  late Context appContext;

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadToken();
  }

  void _loadToken() {
    _tokenExpiryService = locator<TokenExpiryService>();
    _tokenExpiryService.setContext(context);
    _tokenExpiryService.startTokenExpiryCheck();
  }

  Future<void> _loadData() async {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   DataProvider provider = Provider.of<DataProvider>(context, listen: false);
    //   provider.fetchData();
    //   appContext = provider.context;
    // });

    appContext = Provider.of<DataProvider>(context, listen: false).context;
  }

  @override
  void dispose() {
    _tokenExpiryService.stopTokenExpiryCheck();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: widget.title,
        scaffoldKey: _scaffoldKey,
      ),
      drawer: AsideBar(
        user: appContext.user,
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
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
