import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/products_scanner/logic/cubit/localdb_cubit/localdb_cubit.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../config/const/app_enums.dart';
import '../../app_toast/app_toast.dart';
import '../../button_components/elevated_button_components/elevated_icon_button_component.dart';
import '../../dialog_components/dialog_waiting_component.dart';
import '../../list_tile_components/list_tile_icon_component.dart';

class DataManagementSection extends StatelessWidget {
  const DataManagementSection({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => LocalDBCubit()..loclaDBHasData(),
    child: const DataManagementView(),
  );
}

class DataManagementView extends StatelessWidget {
  const DataManagementView({super.key});

  void _showWaitingDialog(
    final BuildContext context,
    final String title,
    final String message,
    final IconData icon,
  ) {
    DialogWatingComponent(
      icon: icon,
      title: title,
      message: message,
    ).show(context);
  }

  @override
  Widget build(final BuildContext context) =>
      BlocConsumer<LocalDBCubit, LocalDBState>(
        listener: (final context, final state) {
          if (state is LoclaDBDataFetchingFromFireStore) {
            _showWaitingDialog(
              context,
              'جاري استيراد البيانات',
              'يرجى الانتظار حتى تكتمل المزامنة...',
              Icons.cloud_download_outlined,
            );
          } else if (state is LoclaDBDataFetchingFromFireStoreSuccess) {
            if (!context.mounted) {
              return;
            }
            Navigator.of(context).pop();
            Navigator.of(context).pop();

            showSuccessToast('تم تهيئة البيانات بنجاح.');
          } else if (state is LoclaDBDataFetchingFromFireStoreFailure) {
            if (!context.mounted) {
              return;
            }
            Navigator.of(context).pop();
            Navigator.of(context).pop();

            showErrorToast('حدث خطأ في استيراد البيانات.');
          } else if (state is LoclaDBDataBaseDeleting) {
            _showWaitingDialog(
              context,
              'جاري حذف البيانات',
              'يرجى الانتظار حتى تكتمل المزامنة...',
              Icons.delete_forever_outlined,
            );
          } else if (state is LoclaDBDataDeleteSuccess) {
            if (!context.mounted) {
              return;
            }
            Navigator.of(context).pop();
            Navigator.of(context).pop();

            showSuccessToast('تم حذف البيانات بنجاح.');
          } else if (state is LoclaDBDataDeleteFailure) {
            if (!context.mounted) {
              return;
            }
            Navigator.of(context).pop();
            Navigator.of(context).pop();

            showErrorToast('حدث خطأ في حذف البيانات.');
          }
        },
        builder: (final context, final state) => Column(
          children: [
            _buildAppOffline(),
            _buildEnableOnline(),
            _buildUpdateLocalHiveDataBase(),
            _buildDeleteLocalData(),
          ],
        ),
      );

  Widget _buildAppOffline() => BlocBuilder<LocalDBCubit, LocalDBState>(
    builder: (final context, final state) {
      Widget trailingWidget = const Icon(
        Icons.query_builder_rounded,
        color: Colors.red,
      );
      var subtitleText = AppLocalizations.of(context)!.appOffLine;
      if (state is LoclaDBDataBaseHasData) {
        trailingWidget = const Icon(
          Icons.check_box_outlined,
          color: Colors.green,
        );
        subtitleText = AppLocalizations.of(context)!.appOnLineMassageRunning;
      } else if (state is LoclaDBDataBaseEmpty) {
        trailingWidget = const Icon(
          Icons.error_outline_rounded,
          color: Colors.red,
        );
        subtitleText = AppLocalizations.of(
          context,
        )!.appOffLineMassageDontRunning;
      } else {
        trailingWidget = const Icon(
          Icons.query_builder_rounded,
          color: Colors.yellow,
        );
        subtitleText = AppLocalizations.of(context)!.appOflineLoading;
      }
      return ListTileIconComponent(
        icon: state is LoclaDBDataBaseHasData
            ? Icons.cloud_done_outlined
            : Icons.cloud_off_rounded,
        title: AppLocalizations.of(context)!.appOffLine,
        subtitle: subtitleText,
        trailing: trailingWidget,
        groupType: state is LoclaDBDataBaseHasData
            ? ListTileGroupType.top
            : ListTileGroupType.single,
      );
    },
  );

  Widget _buildEnableOnline() => BlocBuilder<LocalDBCubit, LocalDBState>(
    builder: (final context, final state) {
      if (state is LoclaDBDataBaseEmpty) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedIconButtonComponent(
            useMargin: true,
            label: AppLocalizations.of(context)!.enableOnline,
            icon: Icons.cloud_download_outlined,
            onPressed: () {
              context.read<LocalDBCubit>().fetchDataFromFireStore();
            },
          ),
        );
      }
      return const SizedBox.shrink();
    },
  );

  Widget _buildUpdateLocalHiveDataBase() =>
      BlocBuilder<LocalDBCubit, LocalDBState>(
        builder: (final context, final state) {
          if (state is LoclaDBDataBaseHasData) {
            return ListTileIconComponent(
              groupType: ListTileGroupType.middle,
              icon: Icons.dataset_linked_outlined,
              title: AppLocalizations.of(context)!.letastUpdate,
              subtitle: AppLocalizations.of(context)!.letestUpdateMassage,
              onTap: () {
                context.read<LocalDBCubit>().updateDataBaseFromFireStore();
              },
            );
          }
          return const SizedBox.shrink();
        },
      );

  Widget _buildDeleteLocalData() => BlocBuilder<LocalDBCubit, LocalDBState>(
    builder: (final context, final state) {
      if (state is LoclaDBDataBaseHasData) {
        return ListTileIconComponent(
          icon: Icons.delete_forever_outlined,
          title: AppLocalizations.of(context)!.clearLogs,
          subtitle: AppLocalizations.of(context)!.clearLogsMassage,
          onTap: () {
            context.read<LocalDBCubit>().deleteAllLocalProducts();
          },
          groupType: ListTileGroupType.bottom,
        );
      }
      return const SizedBox.shrink();
    },
  );
}
