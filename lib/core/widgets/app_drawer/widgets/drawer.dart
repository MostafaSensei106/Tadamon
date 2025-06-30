import 'package:flutter/material.dart' show Icons, Theme, Drawer, ThemeMode, Switch, Colors;
import 'package:flutter/widgets.dart' show StatelessWidget, WidgetStateProperty, BuildContext, Icon, WidgetState, Widget, ContinuousRectangleBorder, SizedBox, BorderRadius, Radius, EdgeInsets, Column, AnimatedSize, Padding, ListView, ValueKey, Navigator;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext, BlocProvider, BlocListener, BlocConsumer;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/app_enums.dart' show ListTileGroupType;
import 'package:tadamon/core/config/const/sensei_const.dart' show SenseiConst;
import 'package:tadamon/core/config/theme/colors/logic/cubit/theme_cubit.dart' show ThemeCubit;
import 'package:tadamon/core/config/theme/colors/logic/cubit/theme_state.dart' show ThemeState;
import 'package:tadamon/core/config/theme/colors/logic/helper/theme_toggle_helper.dart' show toggleTheme;
import 'package:tadamon/core/routing/routes.dart' show Routes;
import 'package:tadamon/core/services/url_services/url_services.dart' show UrlRunServices;
import 'package:tadamon/core/widgets/app_drawer/widgets/drawer_header.dart' show DrawerHeaderWidget;
import 'package:tadamon/core/widgets/app_toast/app_toast.dart' show AppToast;
import 'package:tadamon/core/widgets/bottom_sheet/ui/model_bottom_sheet.dart' show ModelBottomSheet;
import 'package:tadamon/core/widgets/button_component/button_compnent.dart' show ButtonCompnent;
import 'package:tadamon/core/widgets/dilog_components/dilog_waiting_component.dart' show DilogWatingComponent;
import 'package:tadamon/core/widgets/drawer_component/drawer_component.dart' show ListTileIconComponent;
import 'package:tadamon/features/pdf_export/logic/cubit/pdf_export_cubit.dart' show PdfExportCubit;
import 'package:tadamon/features/pdf_export/logic/cubit/pdf_export_state.dart' show PdfExportState, PdfExportLoading;
import 'package:tadamon/features/products_scanner/data/repository/objectbox_repositories.dart' show ObjectboxRepository;
import 'package:tadamon/features/products_scanner/logic/cubit/localdb_cubit/localdb_cubit.dart' show LocalDBCubit, LocalDBState, LoclaDBDataBaseHasData, LoclaDBDataBaseEmpty, LoclaDBDataFetchingFromFireStore, LoclaDBDataFetchingFromFireStoreSuccess, LoclaDBDataFetchingFromFireStoreFailure, LoclaDBDataDeleteFailure, LoclaDBDataBaseDeleting, LoclaDBDataDeleteSuccess;
import 'package:tadamon/features/report_products/widgets/report_products_seet_content/report_product_sheet_content.dart' show ReportProductSheetContent;
import 'package:tadamon/generated/l10n.dart' show S;

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
                bottom: SenseiConst.padding.h,
              ),
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
        return ListTileIconComponent(
          groupType: state.themeMode != ThemeMode.system
              ? ListTileGroupType.top
              : ListTileGroupType.none,
          leading: Icons.brightness_auto_outlined,
          title: S.of(context).systemTheme,
          subtitle: S.of(context).followSystemTheme,
          trailing: Switch(
            thumbIcon: thumbIcon(context),
            value: state.themeMode == ThemeMode.system,
            onChanged: (bool value) {
              toggleTheme(value, context);
            },
          ),
          onTap: () {
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
            : ListTileIconComponent(
                key: ValueKey(state.isDark),
                groupType: ListTileGroupType.bottom,
                leading: state.isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                title: state.isDark
                    ? S.of(context).darkTheme
                    : S.of(context).lightTheme,
                subtitle: state.isDark
                    ? S.of(context).switchToLightTheme
                    : S.of(context).switchToDarkTheme,
                trailing: Switch(
                  thumbIcon: thumbIcon(context),
                  value: state.isDark,
                  onChanged: (bool value) {
                    context.read<ThemeCubit>().toggleTheme(value);
                  },
                ),
                onTap: () {
                  context.read<ThemeCubit>().toggleTheme(!state.isDark);
                },
              );
      },
    );
  }

  Widget _buildAppOffline(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalDBCubit()..loclaDBHasData(),
      child: BlocBuilder<LocalDBCubit, LocalDBState>(
        builder: (context, state) {
          Widget trailingWidget = const Icon(
            Icons.query_builder_rounded,
            color: Colors.red,
          );
          String subtitleText = S.of(context).appOffLine;
          if (state is LoclaDBDataBaseHasData) {
            trailingWidget = const Icon(
              Icons.check_box_outlined,
              color: Colors.green,
            );
            subtitleText = S.of(context).appOnLineMassageRunning;
          } else if (state is LoclaDBDataBaseEmpty) {
            trailingWidget = const Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
            );
            subtitleText = S.of(context).appOnLineMassageRunning;
          } else {
            trailingWidget = const Icon(
              Icons.query_builder_rounded,
              color: Colors.yellow,
            );
            subtitleText = S.of(context).appOflineLoading;
          }
          return ListTileIconComponent(
            leading: state is LoclaDBDataBaseHasData
                ? Icons.cloud_done_outlined
                : Icons.cloud_off_rounded,
            title: S.of(context).appOffLine,
            subtitle: subtitleText,
            trailing: trailingWidget,
            groupType: ListTileGroupType.top,
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
              message: 'يرجى الانتظار حتى تكتمل المزامنة...',
            ).show(context);
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
              message: 'يرجى الانتظار حتى تكتمل المزامنة...',
            ).show(context);
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
              return ListTileIconComponent(
                groupType: ListTileGroupType.middle,
                leading: Icons.dataset_linked_outlined,
                title: 'تحديث قاعدة البيانات',
                subtitle: 'تحديث قاعدة البيانات',
                onTap: () {
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
              message: 'يرجى الانتظار حتى تكتمل المزامنة...',
            ).show(context);
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
              return ListTileIconComponent(
                leading: Icons.delete_forever_outlined,
                title: 'حذف البيانات',
                subtitle: 'سوف يتم حذف جميع المنتجات المحفوظة',
                onTap: () {
                  context.read<LocalDBCubit>().deleteAllLocalProducts();
                },
                groupType: ListTileGroupType.single,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildClearLogs(BuildContext context) {
    return ListTileIconComponent(
      leading: Icons.clear_all_rounded,
      title: S.of(context).clearLogs,
      subtitle: S.of(context).clearLogs,
      onTap: () {
        Navigator.of(context).pop();
        ObjectboxRepository().clearTadamonLogsFromLocalDB();
      },
      groupType: ListTileGroupType.single,
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
          return ListTileIconComponent(
            leading: Icons.picture_as_pdf_rounded,
            title: 'تصدير السجلات',
            subtitle: 'تصطير السجلات علي شكل PDF',
            onTap: () {
              Navigator.of(context).pop();
              context.read<PdfExportCubit>().exportPdf();
            },
            groupType: ListTileGroupType.single,
          );
        },
      ),
    );
  }
}

Widget _buildHowToUse(BuildContext context) {
  return ListTileIconComponent(
    groupType: ListTileGroupType.top,
    leading: Icons.question_answer_outlined,
    title: S.of(context).howToUse,
    subtitle: S.of(context).howToUseMassage,
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.userHelp);
    },
  );
}

Widget _buildReportProduct(BuildContext context) {
  return ListTileIconComponent(
    groupType: ListTileGroupType.bottom,
    leading: Icons.production_quantity_limits_outlined,
    title: S.of(context).reportProduct,
    subtitle: S.of(context).reportProductMassage,
    onTap: () {
      Navigator.pop(context);
      ModelBottomSheet.show(
        context,
        'بلغ عن منتج',
        child: const ReportProductSheetContent(),
      );
    },
  );
}

Widget _buildReadMe(BuildContext context) {
  return ListTileIconComponent(
    groupType: ListTileGroupType.top,
    leading: Icons.description_outlined,
    title: S.of(context).readMe,
    subtitle: S.of(context).readMeMassage,
    trailing: Icon(
      Icons.link_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () {
      Navigator.pop(context);
      UrlRunServices.launchURL(SenseiConst.devReadMeLink);
    },
  );
}

Widget _buildLetestUpdate(BuildContext context) {
  return ListTileIconComponent(
    groupType: ListTileGroupType.middle,
    leading: Icons.update_outlined,
    title: S.of(context).letastUpdate,
    subtitle: S.of(context).letestUpdateMassage,
    trailing: Icon(
      Icons.link_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () {
      Navigator.pop(context);

      UrlRunServices.launchURL(SenseiConst.devReleaseAppLink);
    },
  );
}

Widget _buildGithubToken(BuildContext context) {
  return ListTileIconComponent(
    groupType: ListTileGroupType.middle,
    leading: Icons.live_help_outlined,
    title: S.of(context).githubTiket,
    subtitle: S.of(context).githubTiketMassage,
    trailing: Icon(
      Icons.link_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () {
      Navigator.pop(context);

      UrlRunServices.launchURL(SenseiConst.devGitHubIssuesLink);
    },
  );
}

Widget _buildTelegramChannel(BuildContext context) {
  return ListTileIconComponent(
    groupType: ListTileGroupType.middle,
    leading: Icons.telegram_rounded,
    title: S.of(context).telegramChannel,
    subtitle: S.of(context).telegramChannelMassage,
    trailing: Icon(
      Icons.link_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () {
      Navigator.pop(context);

      UrlRunServices.launchURL(SenseiConst.tadamonTelegramLink);
    },
  );
}

Widget _buildDeveloper(BuildContext context) {
  return ListTileIconComponent(
    groupType: ListTileGroupType.top,
    leading: Icons.verified_outlined,
    title: S.of(context).developer,
    subtitle: S.of(context).mostafaMahmoud,
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    onTap: () => {
      Navigator.pop(context),
      Navigator.pushNamed(context, Routes.chatWithDev),
    },
  );
}

Widget _buildAbout(BuildContext context) {
  return ListTileIconComponent(
    groupType: ListTileGroupType.bottom,
    leading: Icons.info_outline,
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
    ),
    title: S.of(context).about,
    subtitle: S.of(context).about,
    onTap: () => {
      Navigator.pop(context),
      Navigator.pushNamed(context, Routes.appInfo),
    },
  );
}
