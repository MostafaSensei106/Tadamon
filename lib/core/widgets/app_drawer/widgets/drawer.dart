import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/config/theme/colors/logic/cubit/theme_cubit.dart';
import 'package:tadamon/core/config/theme/colors/logic/cubit/theme_state.dart';
import 'package:tadamon/core/config/theme/colors/logic/helper/theme_toggle_helper.dart';

import 'package:tadamon/core/routing/routes.dart';
import 'package:tadamon/core/services/url_services/url_services.dart';
import 'package:tadamon/core/widgets/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/dilog_components/dilog_waiting_component.dart';
import 'package:tadamon/core/widgets/app_toast/app_toast.dart';
import 'package:tadamon/core/widgets/drawer_component/drawer_component.dart';
import 'package:tadamon/core/widgets/app_drawer/widgets/drawer_header.dart';
import 'package:tadamon/features/pdf_export/logic/cubit/pdf_export_cubit.dart';
import 'package:tadamon/features/pdf_export/logic/cubit/pdf_export_state.dart';
import 'package:tadamon/features/products_scanner/data/repository/objectbox_repositories.dart';
import 'package:tadamon/features/products_scanner/logic/cubit/localdb_cubit/localdb_cubit.dart';
import 'package:tadamon/features/report_products/widgets/report_products_seet_content/report_product_sheet_content.dart';
import 'package:tadamon/generated/l10n.dart';

class SenseiDrawer extends StatelessWidget {
  const SenseiDrawer({super.key});

  /// Creates an [Icon] that is conditionally styled based on the presence of
  /// [WidgetState.selected] in the given [Set] of [WidgetState]s.
  ///
  /// If the set contains [WidgetState.selected], the icon is an [Icons.check]
  /// with the primary color of the current [Theme].  Otherwise, the icon is an
  /// [Icons.close].
  WidgetStateProperty<Icon> thumbIcon(BuildContext context) {
    return WidgetStateProperty.resolveWith<Icon>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return Icon(Icons.check, color: Theme.of(context).colorScheme.primary);
      }
      return const Icon(Icons.close);
    });
  }

  @override

  /// Builds the main drawer widget for the application.
  ///
  /// This method returns a [SizedBox] containing a [Drawer] widget with a
  /// specified shape and border radius. The drawer contains a [ListView] that
  /// includes a fixed-size [DrawerHeaderWidget] and a padded [AnimatedSize]
  /// widget wrapping a [Column] of various drawer options including theme
  /// switch, mode switch, offline/online toggles, database actions, usage
  /// instructions, reporting, logging, and developer information.
  ///
  /// The width of the drawer scales with the screen size, utilizing 90% of
  /// the screen width. The padding and radius values are defined in the
  /// [SenseiConst] class to ensure consistency with the app's theme.

  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.90.sw,
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(SenseiConst.outBorderRadius),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 0.25.sh, child: const DrawerHeaderWidget()),
            Padding(
              padding: EdgeInsets.only(
                  left: SenseiConst.padding.w,
                  right: SenseiConst.padding.w,
                  bottom: SenseiConst.padding.h),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 250),
                child: Column(
                  children: [
                    _buildThemeSwitch(context),
                    _buildModeSwitch(context),
                    _buildAppOffline(context),
                    _buildEnableOnline(context),
                    _buildUpdateLocalHiveDataBase(context),
                    _buildDeleteLocalHiveData(context),
                    _buildHowToUse(context),
                    _buildReportProduct(context),
                    _buildClearLogs(context),
                    _buildExportLogs(context),
                    _buildReadMe(context),
                    _buildLetestUpdate(context),
                    _buildGithubToken(context),
                    _buildTelegramChannel(context),
                    _buildDeveloper(context),
                    _buildAbout(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSwitch(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        return ListTileComponent(
          useMargin: false,
          useDivider: state.themeMode != ThemeMode.system,
          useGroupTop: state.themeMode != ThemeMode.system,
          leadingIcon: Icons.brightness_auto_outlined,
          title: S.of(context).systemTheme,
          subtitle: S.of(context).followSystemTheme,
          trailingWidget: Switch(
            thumbIcon: thumbIcon(context),
            value: state.themeMode == ThemeMode.system,
            onChanged: (bool value) {
              toggleTheme(value, context);
            },
          ),
          onTapped: () {
            HapticFeedback.vibrate();
            bool newValue = !(state.themeMode == ThemeMode.system);
            toggleTheme(newValue, context);
          },
        );
      },
    );
  }

  Widget _buildModeSwitch(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) =>
          previous.isDark != current.isDark ||
          previous.themeMode != current.themeMode,
      builder: (context, state) {
        return state.themeMode == ThemeMode.system
            ? const SizedBox.shrink()
            : ListTileComponent(
                key: ValueKey(state.isDark),
                useGroupBottom: true,
                leadingIcon: state.isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                title: state.isDark
                    ? S.of(context).darkTheme
                    : S.of(context).lightTheme,
                subtitle: state.isDark
                    ? S.of(context).switchToLightTheme
                    : S.of(context).switchToDarkTheme,
                trailingWidget: Switch(
                  thumbIcon: thumbIcon(context),
                  value: state.isDark,
                  onChanged: (bool value) {
                    context.read<ThemeCubit>().toggleTheme(value);
                  },
                ),
                onTapped: () {
                  HapticFeedback.vibrate();
                  context.read<ThemeCubit>().toggleTheme(!state.isDark);
                },
                useMargin: false,
                useDivider: false,
              );
      },
    );
  }

  Widget _buildAppOffline(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalDBCubit()..loclaDBHasData(),
      child: BlocBuilder<LocalDBCubit, LocalDBState>(
        builder: (context, state) {
          Widget trailingWidget =
              const Icon(Icons.query_builder_rounded, color: Colors.red);
          String subtitleText = S.of(context).appOffLine;
          bool groupTop = false;
          if (state is LoclaDBDataBaseHasData) {
            trailingWidget =
                const Icon(Icons.check_box_outlined, color: Colors.green);
            subtitleText = S.of(context).appOnLineMassageRunning;
            groupTop = true;
          } else if (state is LoclaDBDataBaseEmpty) {
            trailingWidget =
                const Icon(Icons.error_outline_rounded, color: Colors.red);
            subtitleText = S.of(context).appOnLineMassageRunning;
            groupTop = false;
          } else {
            trailingWidget =
                const Icon(Icons.query_builder_rounded, color: Colors.yellow);
            subtitleText = S.of(context).appOflineLoading;
            groupTop = false;
          }
          return ListTileComponent(
            useMargin: true,
            useDivider: groupTop,
            useGroupTop: groupTop,
            leadingIcon: state is LoclaDBDataBaseHasData
                ? Icons.cloud_done_outlined
                : Icons.cloud_off_rounded,
            title: S.of(context).appOffLine,
            subtitle: subtitleText,
            trailingWidget: trailingWidget,
          );
        },
      ),
    );
  }

  Widget _buildEnableOnline(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalDBCubit()..loclaDBHasData(),
      child: BlocListener<LocalDBCubit, LocalDBState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is LoclaDBDataFetchingFromFireStore) {
            const DilogWatingComponent(
                    title: 'جاري استيراد البيانات',
                    message: 'يرجى الانتظار حتى تكتمل المزامنة...')
                .show(context);
          }
          if (state is LoclaDBDataFetchingFromFireStoreSuccess) {
            AppToast.showSuccessToast('تم تهيئة البيانات بنجاح.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else if (state is LoclaDBDataFetchingFromFireStoreFailure) {
            AppToast.showErrorToast('حدث خطأ في استيراد البيانات.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<LocalDBCubit, LocalDBState>(
          builder: (context, state) {
            if (state is LoclaDBDataBaseEmpty) {
              return SizedBox(
                width: 1.sw,
                child: ButtonCompnent(
                  useMargin: true,
                  label: 'تشغيل الاونلاين',
                  icon: Icons.cloud_download_outlined,
                  onPressed: () {
                    HapticFeedback.vibrate();
                    context.read<LocalDBCubit>().fetchDataFromFireStore();
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildUpdateLocalHiveDataBase(BuildContext context) {
    return BlocProvider(
      create: (_) => LocalDBCubit()..loclaDBHasData(),
      child: BlocListener<LocalDBCubit, LocalDBState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is LoclaDBDataFetchingFromFireStore) {
            const DilogWatingComponent(
                    title: 'جاري تحديث قاعدة البيانات',
                    message: 'يرجى الانتظار حتى تكتمل المزامنة...')
                .show(context);
          }
          if (state is LoclaDBDataFetchingFromFireStoreSuccess) {
            AppToast.showSuccessToast('تم تحديث قاعدة البيانات بنجاح.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
          if (state is LoclaDBDataDeleteFailure) {
            AppToast.showErrorToast('حدث خطاء في تحديث قاعدة البيانات.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<LocalDBCubit, LocalDBState>(
          builder: (context, state) {
            if (state is LoclaDBDataBaseHasData) {
              return ListTileComponent(
                useDivider: true,
                useGroupMiddle: true,
                leadingIcon: Icons.dataset_linked_outlined,
                title: 'تحديث قاعدة البيانات',
                subtitle: 'تحديث قاعدة البيانات',
                onTapped: () {
                  HapticFeedback.vibrate();
                  context.read<LocalDBCubit>().updateDataBaseFromFireStore();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildDeleteLocalHiveData(BuildContext context) {
    return BlocProvider(
      create: (_) => LocalDBCubit()..loclaDBHasData(),
      child: BlocListener<LocalDBCubit, LocalDBState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is LoclaDBDataBaseDeleting) {
            const DilogWatingComponent(
                    title: 'جاري حذف البيانات',
                    message: 'يرجى الانتظار حتى تكتمل المزامنة...')
                .show(context);
          }
          if (state is LoclaDBDataDeleteSuccess) {
            AppToast.showSuccessToast('تم حذف البيانات بنجاح.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
          if (state is LoclaDBDataDeleteFailure) {
            AppToast.showErrorToast('حدث خطأ في حذف البيانات.');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<LocalDBCubit, LocalDBState>(
          builder: (context, state) {
            if (state is LoclaDBDataBaseHasData) {
              return ListTileComponent(
                useGroupBottom: true,
                leadingIcon: Icons.delete_forever_outlined,
                title: 'حذف البيانات',
                subtitle: 'سوف يتم حذف جميع المنتجات المحفوظة',
                onTapped: () {
                  HapticFeedback.vibrate();
                  context.read<LocalDBCubit>().deleteAllLocalProducts();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildClearLogs(BuildContext context) {
    return ListTileComponent(
      useMargin: true,
      useDivider: true,
      useGroupTop: true,
      leadingIcon: Icons.clear_all_rounded,
      title: S.of(context).clearLogs,
      subtitle: S.of(context).clearLogs,
      onTapped: () {
        HapticFeedback.vibrate();
        Navigator.of(context).pop();
        ObjectboxRepository().clearTadamonLogsFromLocalDB();
      },
    );
  }

  Widget _buildExportLogs(BuildContext context) {
    return BlocProvider(
      create: (_) => PdfExportCubit(),
      child: BlocConsumer<PdfExportCubit, PdfExportState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PdfExportLoading) {
            return const DilogWatingComponent(
              title: 'جاري تصدير السجلات',
              message: 'الرجاء الانتظار',
            );
          }
          return ListTileComponent(
            useMargin: false,
            useDivider: false,
            useGroupBottom: true,
            leadingIcon: Icons.picture_as_pdf_rounded,
            title: 'تصدير السجلات',
            subtitle: 'تصطير السجلات علي شكل PDF',
            onTapped: () {
              HapticFeedback.vibrate();
              Navigator.of(context).pop();
              context.read<PdfExportCubit>().exportPdf();
            },
          );
        },
      ),
    );
  }
}

Widget _buildHowToUse(BuildContext context) {
  return ListTileComponent(
      useMargin: true,
      useDivider: true,
      useGroupTop: true,
      leadingIcon: Icons.question_answer_outlined,
      title: S.of(context).howToUse,
      subtitle: S.of(context).howToUseMassage,
      trailingWidget: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
      ),
      onTapped: () {
        HapticFeedback.vibrate();
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.userHelp);
      });
}

Widget _buildReportProduct(BuildContext context) {
  return ListTileComponent(
    useMargin: false,
    useDivider: false,
    useGroupBottom: true,
    leadingIcon: Icons.production_quantity_limits_outlined,
    title: S.of(context).reportProduct,
    subtitle: S.of(context).reportProductMassage,
    onTapped: () {
      HapticFeedback.vibrate();
      Navigator.pop(context);
      ModelBottomSheet.show(context, 'بلغ عن منتج',
          child: const ReportProductSheetContent());
    },
  );
}

Widget _buildReadMe(BuildContext context) {
  return ListTileComponent(
    useMargin: true,
    useDivider: true,
    useGroupTop: true,
    leadingIcon: Icons.description_outlined,
    title: S.of(context).readMe,
    subtitle: S.of(context).readMeMassage,
    trailingWidget: Icon(
      Icons.link_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTapped: () {
      HapticFeedback.vibrate();
      Navigator.pop(context);
      UrlRunServices.launchURL(SenseiConst.devReadMeLink);
    },
  );
}

Widget _buildLetestUpdate(BuildContext context) {
  return ListTileComponent(
    useMargin: false,
    useDivider: true,
    useGroupMiddle: true,
    leadingIcon: Icons.update_outlined,
    title: S.of(context).letastUpdate,
    subtitle: S.of(context).letestUpdateMassage,
    trailingWidget: Icon(
      Icons.link_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTapped: () {
      HapticFeedback.vibrate();
      Navigator.pop(context);

      UrlRunServices.launchURL(SenseiConst.devReleaseAppLink);
    },
  );
}

Widget _buildGithubToken(BuildContext context) {
  return ListTileComponent(
    useMargin: false,
    useDivider: true,
    useGroupMiddle: true,
    leadingIcon: Icons.live_help_outlined,
    title: S.of(context).githubTiket,
    subtitle: S.of(context).githubTiketMassage,
    trailingWidget: Icon(
      Icons.link_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTapped: () {
      HapticFeedback.vibrate();
      Navigator.pop(context);

      UrlRunServices.launchURL(SenseiConst.devGitHubIssuesLink);
    },
  );
}

Widget _buildTelegramChannel(BuildContext context) {
  return ListTileComponent(
      useMargin: false,
      useDivider: false,
      useGroupBottom: true,
      leadingIcon: Icons.telegram_rounded,
      title: S.of(context).telegramChannel,
      subtitle: S.of(context).telegramChannelMassage,
      trailingWidget: Icon(
        Icons.link_rounded,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
      ),
      onTapped: () {
        HapticFeedback.vibrate();
        Navigator.pop(context);

        UrlRunServices.launchURL(SenseiConst.tadamonTelegramLink);
      });
}

Widget _buildDeveloper(BuildContext context) {
  return ListTileComponent(
    useMargin: true,
    useDivider: true,
    useGroupTop: true,
    leadingIcon: Icons.verified_outlined,
    title: S.of(context).developer,
    subtitle: S.of(context).mostafaMahmoud,
    trailingWidget: Icon(
      Icons.arrow_forward_ios_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTapped: () => {
      HapticFeedback.vibrate(),
      Navigator.pop(context),
      Navigator.pushNamed(context, Routes.chatWithDev)
    },
  );
}

Widget _buildAbout(BuildContext context) {
  return ListTileComponent(
    useMargin: false,
    useDivider: false,
    useGroupBottom: true,
    leadingIcon: Icons.info_outline,
    trailingWidget: Icon(
      Icons.arrow_forward_ios_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    title: S.of(context).about,
    subtitle: S.of(context).about,
    onTapped: () => {
      HapticFeedback.vibrate(),
      Navigator.pop(context),
      Navigator.pushNamed(context, Routes.appInfo),
    },
  );
}
