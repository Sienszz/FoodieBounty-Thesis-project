import 'package:get/get.dart';
import 'package:projek_skripsi/application/app_informaton/views/app_information_page.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/store/category_store_page.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/store/expand_store_page.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/dashboard_navigation.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/store/search_store_dashboard_page.dart';
import 'package:projek_skripsi/application/buyer/dashboard/views/screens/store/selected_store_page.dart';
import 'package:projek_skripsi/application/buyer/edit_account/views/edit_buyer_page.dart';
import 'package:projek_skripsi/application/buyer/voucher/views/screen/voucher_buyer_page.dart';
import 'package:projek_skripsi/application/seller/leveling/views/screens/create_level_page.dart';
import 'package:projek_skripsi/utils/routes.dart';
import 'package:projek_skripsi/application/seller/all_voucher/views/screens/all_voucher_page.dart';
import 'package:projek_skripsi/application/seller/all_voucher/views/screens/create_voucher_page.dart';
import 'package:projek_skripsi/application/seller/dashboard/views/screens/dashboard_navigation.dart';
import 'package:projek_skripsi/application/seller/edit_store/views/screens/edit_store_page.dart';
import 'package:projek_skripsi/application/seller/history/views/screens/history_page.dart';
import 'package:projek_skripsi/application/seller/leveling/views/screens/leveling_page.dart';
import 'package:projek_skripsi/application/seller/scan/views/screens/scan_page.dart';
import 'package:projek_skripsi/authorization/modules/register/buyer_register/views/register_page.dart';
import 'package:projek_skripsi/authorization/modules/register/seller_register/views/register_page.dart';
import 'package:projek_skripsi/application/boarding/views/boarding_page.dart';
import 'package:projek_skripsi/authorization/modules/login/buyer_login/views/login_page.dart';
import 'package:projek_skripsi/authorization/modules/login/seller_login/views/login_page.dart';

  class AppPages {
  static final pages = [
    // boarding
    GetPage(
        name: AppRoutes.onBoarding,
        page: () => const BoardingPage(),
    ),

    GetPage(
        name: AppRoutes.appInfo,
        page: () => const AppInformationPage(),
    ),

    // login
    GetPage(
        name: AppRoutes.sellerlogin,
        page: () => const SellerLoginPage(),
    ),
    GetPage(
        name: AppRoutes.buyerlogin,
        page: () => const BuyerLoginPage(),
    ),

    // register
    GetPage(
        name: AppRoutes.sellerregister,
        page: () => const SellerRegisterPage(),
    ),
    GetPage(
        name: AppRoutes.buyerregister,
        page: () => const BuyerRegisterPage(),
    ),

    // seller
    GetPage(
        name: AppRoutes.sellerdashboard,
        page: () => const SellerDashboardNavigation(),
    ),
    GetPage(
        name: AppRoutes.sellereditstore,
        page: () => const EditStorePage(),
    ),
    GetPage(
      name: AppRoutes.sellerscan,
      page: () => const SellerScanPage(),
    ),
    GetPage(
      name: AppRoutes.sellerhistory,
      page: () => const SellerHistoryPage(),
    ),
    GetPage(
      name: AppRoutes.sellerleveling,
      page: () => const SellerLevelingPage(),
    ),
    GetPage(
      name: AppRoutes.sellercreateleveling,
      page: () => const CreateLevelPage(),
    ),
    GetPage(
      name: AppRoutes.sellerallvoucher,
      page: () => const AllVoucherPage(),
    ),
    GetPage(
      name: AppRoutes.sellercreatevoucher,
      page: () => const CreateVoucherPage(),
    ),
    // GetPage(
    //     name: AppRoutes.sellerstore,
    //     page: () => const StorePage(),
    //     binding: StoreSellerBinding()
    // ),

    //buyer
    GetPage(
      name: AppRoutes.buyerDashboard,
      page: () => const BuyerDashboardNavigation(),
    ),

    GetPage(
        name: AppRoutes.expandMoreStore,
        page: () => const MoreExpandStorePage(),
    ),

    GetPage(
        name: AppRoutes.selectedStore,
        page: () => const SelectedStorePage(),
    ),

    GetPage(
        name: AppRoutes.buyerEditStore,
        page: () => const EditBuyerPage(),
    ),

    GetPage(
        name: AppRoutes.voucherBuyer,
        page: () => const VoucherBuyerPage(),
    ),
    
    GetPage(
        name: AppRoutes.expandCategoryStore,
        page: () => const CategoryStorePage(),
    ),
    
    GetPage(
        name: AppRoutes.dashboardSearchStore,
        page: () => const SearchStoreDashboardPage(),
    ),
  ];
}