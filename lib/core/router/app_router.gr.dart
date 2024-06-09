// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CreateWorkRoute.name: (routeData) {
      final args = routeData.argsAs<CreateWorkRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateWorkView(
          key: args.key,
          model: args.model,
          controller: args.controller,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
  };
}

/// generated route for
/// [CreateWorkView]
class CreateWorkRoute extends PageRouteInfo<CreateWorkRouteArgs> {
  CreateWorkRoute({
    Key? key,
    WorkModel? model,
    required CalendarController controller,
    List<PageRouteInfo>? children,
  }) : super(
          CreateWorkRoute.name,
          args: CreateWorkRouteArgs(
            key: key,
            model: model,
            controller: controller,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateWorkRoute';

  static const PageInfo<CreateWorkRouteArgs> page =
      PageInfo<CreateWorkRouteArgs>(name);
}

class CreateWorkRouteArgs {
  const CreateWorkRouteArgs({
    this.key,
    this.model,
    required this.controller,
  });

  final Key? key;

  final WorkModel? model;

  final CalendarController controller;

  @override
  String toString() {
    return 'CreateWorkRouteArgs{key: $key, model: $model, controller: $controller}';
  }
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
