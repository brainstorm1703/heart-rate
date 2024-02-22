import 'package:heart_rate/features/heart_rate_page/view/heart_rate_page_screen.dart';
import 'package:heart_rate/features/history_page/view/history_page_screen.dart';
import 'package:heart_rate/features/main_page/view/main_page_screen.dart';

final routes = {
  '/': (context) => const MainPageScreen(),
  '/history': (context) => const HistoryPageScreen(),
  '/heart_rate': (context) => const HeartRatePageScreen(),
};
