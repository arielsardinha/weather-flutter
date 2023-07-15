import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_weather_map/app/modules/home/factory/home_factory.dart';
import 'package:open_weather_map/app/modules/home/view/home_view.dart';
import 'package:open_weather_map/app/modules/splash/view/splash_view.dart';
import 'package:open_weather_map/app/router/navigator_config.dart';
import 'package:open_weather_map/app/router/routers.dart';
import 'package:open_weather_map/data/blocs/forecast/forecast_bloc.dart';
import 'package:open_weather_map/data/blocs/weather/weather_bloc.dart';

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    log('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    log('Returning to route: ${previousRoute?.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    log('Route removed: ${route.settings.name}');
  }
}

sealed class AppRoutes {
  static final routesConfig = GoRouter(
    observers: [MyNavigatorObserver()],
    routes: [
      GoRoute(
        name: Routes.HOME,
        path: Routes.HOME,
        // redirect: (BuildContext context, GoRouterState state) async {
        //   final result = await Future.delayed(
        //     const Duration(seconds: 1),
        //     () => true,
        //   );
        //   if (result) {
        //     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(
        //           content: Text('Usuário não autenticao'),
        //         ),
        //       );
        //     });
        //     return '/signin';
        //   } else {
        //     return null;
        //   }
        // },
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<WeatherBloc>(
                lazy: true,
                create: (context) => HomeFactory.weatherBloc,
              ),
              BlocProvider<ForecastBloc>(
                lazy: true,
                create: (context) => HomeFactory.forecastBloc,
              ),
            ],
            child: Builder(
              builder: (context) {
                return HomeView(
                  forecastBloc: context.read(),
                  weatherBloc: context.read(),
                );
              },
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.SPLASH,
        builder: (context, state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  CustonNavigator.pushNamed(context, Routes.SPLASH);
                },
                child: const Text('data'),
              ),
            ),
          );
        },
      ),
    ],
  );
}
