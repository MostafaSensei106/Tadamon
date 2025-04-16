import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/bottom_sheet/widget/bottom_model_sheet_content.dart';
import 'package:tadamon/core/widgets/bottom_sheet/widget/sheet_header.dart';
import 'package:tadamon/core/widgets/textbutton_component/textbuttonicon_component.dart';
import 'package:tadamon/generated/l10n.dart';

class ModelBottomSheet {
  ///
  /// Shows a bottom sheet with the given [title] and [child] in the given
  /// [context].
  ///
  /// The bottom sheet is scrollable, drags, uses the root navigator, and
  /// is dismissible.
  ///
  /// The bottom sheet is clipped at the top with a corner radius of
  /// 14 logical pixels.
  ///
  /// The [child] is displayed within a [ClipRRect] with a circular corner radius
  /// of 14 logical pixels.
  static void show(BuildContext context, String title,
      {required Widget child}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      useRootNavigator: true,
      isDismissible: true,
      builder: (context) => _buildBottomSheet(context, title, child),
    );
  }

  /// Builds a bottom sheet with the given [title] and [child].
  ///
  /// The bottom sheet is scrollable, has a top border radius of 14 logical
  /// pixels, uses the root navigator, and is dismissible.
  ///
  /// The child is displayed within a [ClipRRect] with a circular corner radius
  /// of 14 logical pixels.
  ///
  /// The [child] is wrapped in a [Column] with a [Padding] widget to add
  /// horizontal padding and a [Wrap] widget to stack the title and the child
  /// vertically.
  ///
  /// The [child] is also wrapped in a [SingleChildScrollView] to make the
  /// bottom sheet scrollable.
  ///
  /// The [child] is displayed at the bottom of the screen with a padding of
  /// 16 logical pixels.
  ///
  /// The [child] is also padded with a [Padding] widget to add a bottom padding
  /// of 16 logical pixels.
  ///
  /// The close button is displayed at the bottom of the screen with a padding
  /// of 16 logical pixels.
  ///
  /// The close button is also padded with a [Padding] widget to add a bottom
  /// padding of 16 logical pixels.
  static Widget _buildBottomSheet(
      BuildContext context, String title, Widget child) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                BottomSheetHeader(titile: title),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: SenseiConst.padding.w),
                  child: Column(
                    children: [
                      BottomModelSheetContent(
                        child: child,
                      ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         TextbuttonIconComponent(
                          text: S.of(context).close, onPressed: () => {
                          HapticFeedback.vibrate(),
                          Navigator.of(context).pop()}, icon: Icons.close,),
                       ],
                     ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
