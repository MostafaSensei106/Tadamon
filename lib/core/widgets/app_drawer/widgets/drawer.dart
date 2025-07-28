import 'package:flutter/material.dart'
    show Icons, Theme, Drawer, ThemeMode, Switch, Colors;
import 'package:flutter/widgets.dart'
    show
        StatelessWidget,
        WidgetStateProperty,
        BuildContext,
        Icon,
        WidgetState,
        Widget,
        ContinuousRectangleBorder,
        SizedBox,
        BorderRadius,
        Radius,
        EdgeInsets,
        Column,
        AnimatedSize,
        ListView,
        ValueKey,
        Navigator;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, ReadContext, BlocProvider, BlocListener, BlocConsumer;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../features/pdf_export/logic/cubit/pdf_export_cubit.dart'
    show PdfExportCubit;
import '../../../../features/pdf_export/logic/cubit/pdf_export_state.dart'
    show PdfExportState, PdfExportLoading;
import '../../../../features/products_scanner/data/repository/objectbox_repositories.dart'
    show ObjectboxRepository;
import '../../../../features/products_scanner/logic/cubit/localdb_cubit/localdb_cubit.dart'
    show
        LocalDBCubit,
        LocalDBState,
        LoclaDBDataBaseHasData,
        LoclaDBDataBaseEmpty,
        LoclaDBDataFetchingFromFireStore,
        LoclaDBDataFetchingFromFireStoreSuccess,
        LoclaDBDataFetchingFromFireStoreFailure,
        LoclaDBDataDeleteFailure,
        LoclaDBDataBaseDeleting,
        LoclaDBDataDeleteSuccess;
import '../../../../features/report_products/widgets/report_products_seet_content/report_product_sheet_content.dart'
    show ReportProductSheetContent;
import '../../../../generated/l10n.dart' show S;
import '../../../config/const/app_enums.dart' show ListTileGroupType;
import '../../../config/const/sensei_const.dart' show SenseiConst;
import '../../../config/theme/colors/logic/cubit/theme_cubit.dart'
    show ThemeCubit;
import '../../../config/theme/colors/logic/cubit/theme_state.dart'
    show ThemeState;
import '../../../config/theme/colors/logic/helper/theme_toggle_helper.dart'
    show toggleTheme;
import '../../../routing/routes.dart' show Routes;
import '../../../services/url_services/url_services.dart' show launchURL;
import '../../app_toast/app_toast.dart' show showSuccessToast, showErrorToast;
import '../../bottom_sheet/ui/model_bottom_sheet.dart' show showBottomSheet;
import '../../button_component/button_compnent.dart' show ButtonCompnent;
import '../../dilog_components/dilog_waiting_component.dart'
    show DilogWatingComponent;
import '../../list_tile_components/list_tile_icon_component.dart'
    show ListTileIconComponent;
import 'drawer_header.dart' show DrawerHeaderWidget;

class SenseiDrawer extends StatelessWidget {
  const SenseiDrawer({super.key});

  /// Creates an [Icon] that is conditionally styled based on the presence of
  /// [WidgetState.selected] in the given [Set] of [WidgetState]s.
  ///
  /// If the set contains [WidgetState.selected], the icon is an [Icons.check]
  /// with the primary color of the current [Theme].  Otherwise, the icon is an
  /// [Icons.close].
  WidgetStateProperty<Icon> thumbIcon(final BuildContext context) =>
      WidgetStateProperty.resolveWith<Icon>((final Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Icon(
            Icons.check,
            color: Theme.of(context).colorScheme.primary,
          );
        }
        return const Icon(Icons.close);
      });

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
  Widget build(final BuildContext context) => SizedBox(
    width: 0.90.sw,
    child: Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(SenseiConst.outBorderRadius),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.only(
          left: SenseiConst.padding,
          right: SenseiConst.padding,
          bottom: SenseiConst.padding,
        ),
        children: [
          const DrawerHeaderWidget(),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            child: Column(
              children: [
                _buildThemeSwitch(context),
                _buildModeSwitch(context),
                _buildAppOffline(context),
                _buildEnableOnline(context),
                _buildUpdateLocalHiveDataBase(context),
                _buildDeleteLocalData(context),
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
        ],
      ),
    ),
  );

  Widget _buildThemeSwitch(final BuildContext context) =>
      BlocBuilder<ThemeCubit, ThemeState>(
        buildWhen: (final previous, final current) =>
            previous.themeMode != current.themeMode,
        builder: (final context, final state) => ListTileIconComponent(
          groupType: state.themeMode != ThemeMode.system
              ? ListTileGroupType.top
              : ListTileGroupType.single,
          iconLeading: Icons.brightness_auto_outlined,
          title: S.of(context).systemTheme,
          subtitle: S.of(context).followSystemTheme,
          trailing: Switch(
            thumbIcon: thumbIcon(context),
            value: state.themeMode == ThemeMode.system,
            onChanged: (final bool value) {
              toggleTheme(isSystemTheme: value, context: context);
            },
          ),
          onTap: () {
            final newValue = !(state.themeMode == ThemeMode.system);
            toggleTheme(isSystemTheme: newValue, context: context);
          },
        ),
      );

  Widget _buildModeSwitch(final BuildContext context) =>
      BlocBuilder<ThemeCubit, ThemeState>(
        buildWhen: (final previous, final current) =>
            previous.isDark != current.isDark ||
            previous.themeMode != current.themeMode,
        builder: (final context, final state) =>
            state.themeMode == ThemeMode.system
            ? const SizedBox.shrink()
            : ListTileIconComponent(
                key: ValueKey(state.isDark),
                groupType: ListTileGroupType.bottom,
                iconLeading: state.isDark
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
                  onChanged: (final bool value) {
                    context.read<ThemeCubit>().toggleTheme(isDark: value);
                  },
                ),
                onTap: () {
                  context.read<ThemeCubit>().toggleTheme(isDark: !state.isDark);
                },
              ),
      );

  Widget _buildAppOffline(final BuildContext context) => BlocProvider(
    create: (final context) => LocalDBCubit()..loclaDBHasData(),
    child: BlocBuilder<LocalDBCubit, LocalDBState>(
      builder: (final context, final state) {
        Widget trailingWidget = const Icon(
          Icons.query_builder_rounded,
          color: Colors.red,
        );
        var subtitleText = S.of(context).appOffLine;
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
          subtitleText = S.of(context).appOffLineMassageDontRunning;
        } else {
          trailingWidget = const Icon(
            Icons.query_builder_rounded,
            color: Colors.yellow,
          );
          subtitleText = S.of(context).appOflineLoading;
        }
        return ListTileIconComponent(
          iconLeading: state is LoclaDBDataBaseHasData
              ? Icons.cloud_done_outlined
              : Icons.cloud_off_rounded,
          title: S.of(context).appOffLine,
          subtitle: subtitleText,
          trailing: trailingWidget,
          groupType: state is LoclaDBDataBaseHasData
              ? ListTileGroupType.top
              : ListTileGroupType.single,
        );
      },
    ),
  );

  Widget _buildEnableOnline(final BuildContext context) => BlocProvider(
    create: (final context) => LocalDBCubit()..loclaDBHasData(),
    child: BlocListener<LocalDBCubit, LocalDBState>(
      listenWhen: (final previous, final current) => previous != current,
      listener: (final context, final state) {
        if (state is LoclaDBDataFetchingFromFireStore) {
          const DilogWatingComponent(
            icon: Icons.cloud_download_outlined,
            title: 'جاري استيراد البيانات',
            message: 'يرجى الانتظار حتى تكتمل المزامنة...',
          ).show(context);
        }
        if (state is LoclaDBDataFetchingFromFireStoreSuccess) {
          showSuccessToast('تم تهيئة البيانات بنجاح.');
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else if (state is LoclaDBDataFetchingFromFireStoreFailure) {
          showErrorToast('حدث خطأ في استيراد البيانات.');
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<LocalDBCubit, LocalDBState>(
        builder: (final context, final state) {
          if (state is LoclaDBDataBaseEmpty) {
            return SizedBox(
              width: double.infinity,
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

  Widget _buildUpdateLocalHiveDataBase(final BuildContext context) =>
      BlocProvider(
        create: (_) => LocalDBCubit()..loclaDBHasData(),
        child: BlocListener<LocalDBCubit, LocalDBState>(
          listenWhen: (final previous, final current) => previous != current,
          listener: (final context, final state) {
            if (state is LoclaDBDataFetchingFromFireStore) {
              const DilogWatingComponent(
                icon: Icons.cloud_download_outlined,
                title: 'جاري تحديث قاعدة البيانات',
                message: 'يرجى الانتظار حتى تكتمل المزامنة...',
              ).show(context);
            }
            if (state is LoclaDBDataFetchingFromFireStoreSuccess) {
              showSuccessToast('تم تحديث قاعدة البيانات بنجاح.');
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
            if (state is LoclaDBDataDeleteFailure) {
              showErrorToast('حدث خطاء في تحديث قاعدة البيانات.');
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<LocalDBCubit, LocalDBState>(
            builder: (final context, final state) {
              if (state is LoclaDBDataBaseHasData) {
                return ListTileIconComponent(
                  groupType: ListTileGroupType.middle,
                  iconLeading: Icons.dataset_linked_outlined,
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

  Widget _buildDeleteLocalData(final BuildContext context) => BlocProvider(
    create: (_) => LocalDBCubit()..loclaDBHasData(),
    child: BlocListener<LocalDBCubit, LocalDBState>(
      listenWhen: (final previous, final current) => previous != current,
      listener: (final context, final state) {
        if (state is LoclaDBDataBaseDeleting) {
          const DilogWatingComponent(
            icon: Icons.delete_forever_outlined,
            title: 'جاري حذف البيانات',
            message: 'يرجى الانتظار حتى تكتمل المزامنة...',
          ).show(context);
        }
        if (state is LoclaDBDataDeleteSuccess) {
          showSuccessToast('تم حذف البيانات بنجاح.');
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
        if (state is LoclaDBDataDeleteFailure) {
          showErrorToast('حدث خطأ في حذف البيانات.');
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<LocalDBCubit, LocalDBState>(
        builder: (final context, final state) {
          if (state is LoclaDBDataBaseHasData) {
            return ListTileIconComponent(
              iconLeading: Icons.delete_forever_outlined,
              title: 'حذف البيانات',
              subtitle: 'سوف يتم حذف جميع المنتجات المحفوظة',
              onTap: () {
                context.read<LocalDBCubit>().deleteAllLocalProducts();
              },
              groupType: ListTileGroupType.bottom,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    ),
  );

  Widget _buildClearLogs(final BuildContext context) => ListTileIconComponent(
    iconLeading: Icons.clear_all_rounded,
    title: S.of(context).clearLogs,
    subtitle: S.of(context).clearLogs,
    onTap: () {
      Navigator.of(context).pop();
      ObjectboxRepository().clearTadamonLogsFromLocalDB();
    },
    groupType: ListTileGroupType.top,
  );

  Widget _buildExportLogs(final BuildContext context) => BlocProvider(
    create: (_) => PdfExportCubit(),
    child: BlocConsumer<PdfExportCubit, PdfExportState>(
      listener: (final context, final state) {},
      builder: (final context, final state) {
        if (state is PdfExportLoading) {
          return const DilogWatingComponent(
            icon: Icons.picture_as_pdf_rounded,
            title: 'جاري تصدير السجلات',
            message: 'الرجاء الانتظار',
          );
        }
        return ListTileIconComponent(
          iconLeading: Icons.picture_as_pdf_rounded,
          title: 'تصدير السجلات',
          subtitle: 'تصطير السجلات علي شكل PDF',
          onTap: () {
            Navigator.of(context).pop();
            context.read<PdfExportCubit>().exportPdf();
          },
          groupType: ListTileGroupType.bottom,
        );
      },
    ),
  );
}

Widget _buildHowToUse(final BuildContext context) => ListTileIconComponent(
  groupType: ListTileGroupType.top,
  iconLeading: Icons.question_answer_outlined,
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

Widget _buildReportProduct(final BuildContext context) => ListTileIconComponent(
  groupType: ListTileGroupType.bottom,
  iconLeading: Icons.production_quantity_limits_outlined,
  title: S.of(context).reportProduct,
  subtitle: S.of(context).reportProductMassage,
  onTap: () {
    Navigator.pop(context);
    showBottomSheet(
      context,
      'بلغ عن منتج',
      child: const ReportProductSheetContent(),
    );
  },
);

Widget _buildReadMe(final BuildContext context) => ListTileIconComponent(
  groupType: ListTileGroupType.top,
  iconLeading: Icons.description_outlined,
  title: S.of(context).readMe,
  subtitle: S.of(context).readMeMassage,
  trailing: Icon(
    Icons.link_rounded,
    color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
  ),
  onTap: () {
    Navigator.pop(context);
    launchURL(SenseiConst.devReadMeLink);
  },
);

Widget _buildLetestUpdate(final BuildContext context) => ListTileIconComponent(
  groupType: ListTileGroupType.middle,
  iconLeading: Icons.update_outlined,
  title: S.of(context).letastUpdate,
  subtitle: S.of(context).letestUpdateMassage,
  trailing: Icon(
    Icons.link_rounded,
    color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
  ),
  onTap: () {
    Navigator.pop(context);

    launchURL(SenseiConst.devReleaseAppLink);
  },
);

Widget _buildGithubToken(final BuildContext context) => ListTileIconComponent(
  groupType: ListTileGroupType.middle,
  iconLeading: Icons.live_help_outlined,
  title: S.of(context).githubTiket,
  subtitle: S.of(context).githubTiketMassage,
  trailing: Icon(
    Icons.link_rounded,
    color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
  ),
  onTap: () {
    Navigator.pop(context);

    launchURL(SenseiConst.devGitHubIssuesLink);
  },
);

Widget _buildTelegramChannel(final BuildContext context) =>
    ListTileIconComponent(
      groupType: ListTileGroupType.bottom,
      iconLeading: Icons.telegram_rounded,
      title: S.of(context).telegramChannel,
      subtitle: S.of(context).telegramChannelMassage,
      trailing: Icon(
        Icons.link_rounded,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
      ),
      onTap: () {
        Navigator.pop(context);

        launchURL(SenseiConst.tadamonTelegramLink);
      },
    );

Widget _buildDeveloper(final BuildContext context) => ListTileIconComponent(
  groupType: ListTileGroupType.top,
  iconLeading: Icons.verified_outlined,
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

Widget _buildAbout(final BuildContext context) => ListTileIconComponent(
  groupType: ListTileGroupType.bottom,
  iconLeading: Icons.info_outline,
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
