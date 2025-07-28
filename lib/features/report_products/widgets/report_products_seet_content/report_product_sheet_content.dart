import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/config/const/sensei_const.dart';
import '../../../../core/widgets/button_components/elevated_button_components/elevated_icon_button_component.dart';
import '../../../../core/widgets/text_filed_component/text_filed_component.dart';
import '../../logic/bloc/report_product_cubit.dart';
import '../../logic/bloc/report_product_state.dart';
import 'radio_selection_tile_component.dart';

class ReportProductSheetContent extends StatefulWidget {
  const ReportProductSheetContent({super.key});

  @override
  State<ReportProductSheetContent> createState() =>
      _ReportProductSheetContentState();
}

class _ReportProductSheetContentState extends State<ReportProductSheetContent> {
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  String status = 'لا أعرف';

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (_) => ReportProductCubit(),
    child: BlocBuilder<ReportProductCubit, ReportProductState>(
      builder: (final context, final state) {
        final isValid = state is ReportProductIsValid;
        final isSerialNumberError =
            state is ReportProductSerialNumberIsNotValid;
        final isProductNameError = state is ReportProductProductNameIsNotValid;
        void sendReport(final BuildContext context) {
          if (state is ReportProductProductNameIsNotValid &&
              state is ReportProductSerialNumberIsNotValid) {
            return;
          }
          context.read<ReportProductCubit>().submitReport(
            serialNumberController.text,
            productNameController.text,
            status,
          );
          Navigator.pop(context);
        }

        return Column(
          children: [
            TextFieldComponent(
              controller: serialNumberController,
              onChange: (_) =>
                  context.read<ReportProductCubit>().validateInputs(
                    serialNumberController.text,
                    productNameController.text,
                  ),
              icon: Icons.qr_code_rounded,
              isNumeric: true,
              hint: 'ادخل الرقم التسلسلي (6-13 أرقام)',
              maxLength: 13,
              errorText: isSerialNumberError ? state.error : null,
              suffixIcon: IconButton(
                icon: const Icon(Icons.camera_alt_outlined),
                onPressed: () => context.read<ReportProductCubit>().scanBarcode(
                  context,
                  serialNumberController,
                ),
              ),
            ),
            SizedBox(height: SenseiConst.margin.h),
            TextFieldComponent(
              controller: productNameController,
              onChange: (_) =>
                  context.read<ReportProductCubit>().validateInputs(
                    serialNumberController.text,
                    productNameController.text,
                  ),
              icon: Icons.label_outline_rounded,
              hint: 'ادخل اسم المنتج',
              errorText: isProductNameError ? state.error : null,
              maxLength: 50,
            ),
            SizedBox(height: SenseiConst.margin.h),
            RadioSelectionTileComponent(
              onChanged: (final value) {
                setState(() {
                  status = value;
                });
              },
            ),
            SizedBox(height: SenseiConst.margin.h - 4),
            if (state is ReportProductIsLoading)
              const CircularProgressIndicator(),
            SizedBox(
              width: 1.sw,
              child: ElevatedIconButtonComponent(
                label: 'ارسال التقرير',
                icon: Icons.send,
                isEnabled: isValid,
                onPressed: () => sendReport(context),
                useInBorderRadius: true,
              ),
            ),
            if (state is ReportProductIsError)
              Text(state.error, style: const TextStyle(color: Colors.red)),
          ],
        );
      },
    ),
  );

  @override
  void dispose() {
    serialNumberController.dispose();
    productNameController.dispose();
    super.dispose();
  }
}
