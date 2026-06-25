import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/constants/app_constants.dart';
import 'core/constants/app_strings.dart';
import 'core/di/injection.dart';
import 'core/routes/navigation_service.dart';
import 'core/routes/routes.dart';
import 'core/session/session_controller.dart';
import 'core/theme/app_theme.dart';

/// Widget raiz: configura tema, responsividade, internacionalização e rotas.
///
/// Camadas de responsividade combinadas (Etapa 13):
///  - [ScreenUtilInit]    -> escala fina de tamanhos a partir de um design base.
///  - [ResponsiveBreakpoints] -> classifica o dispositivo (MOBILE/TABLET/DESKTOP)
///    e centraliza o conteúdo (maxWidth) em telas largas.
class DesperteMulherApp extends StatelessWidget {
  const DesperteMulherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = sl<NavigationService>();
    final session = sl<SessionController>();
    final appRouter = AppRouter(
      navigatorKey: navigation.navigatorKey,
      isAuthenticated: () => session.isLoggedIn,
      refreshListenable: session,
    );

    return ScreenUtilInit(
      designSize: const Size(
        AppConstants.designWidth,
        AppConstants.designHeight,
      ),
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp.router(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.light,
          routerConfig: appRouter.router,
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: const [
              Breakpoint(start: 0, end: 600, name: MOBILE),
              Breakpoint(start: 601, end: 1024, name: TABLET),
              Breakpoint(start: 1025, end: double.infinity, name: DESKTOP),
            ],
          ),
        );
      },
    );
  }
}
