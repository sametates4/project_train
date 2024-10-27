// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CreateWorkView]
class CreateWorkRoute extends PageRouteInfo<CreateWorkRouteArgs> {
  CreateWorkRoute({
    Key? key,
    WorkModel? model,
    required DateTime date,
    List<PageRouteInfo>? children,
  }) : super(
          CreateWorkRoute.name,
          args: CreateWorkRouteArgs(
            key: key,
            model: model,
            date: date,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateWorkRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateWorkRouteArgs>();
      return CreateWorkView(
        key: args.key,
        model: args.model,
        date: args.date,
      );
    },
  );
}

class CreateWorkRouteArgs {
  const CreateWorkRouteArgs({
    this.key,
    this.model,
    required this.date,
  });

  final Key? key;

  final WorkModel? model;

  final DateTime date;

  @override
  String toString() {
    return 'CreateWorkRouteArgs{key: $key, model: $model, date: $date}';
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeView();
    },
  );
}
