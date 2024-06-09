import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../features/create_work/create_work_view.dart';
import '../../features/home/home_view.dart';
import '../model/work_model.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'View,Route',
)

final class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/home', initial: true),
    AutoRoute(page: CreateWorkRoute.page, path: '/create-work')
  ];
}