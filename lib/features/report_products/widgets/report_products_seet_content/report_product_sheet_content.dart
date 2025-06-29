import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/text_filed_component/text_filed_component.dart';
import 'package:tadamon/features/report_products/logic/bloc/report_product_cubit.dart';
import 'package:tadamon/features/report_products/logic/bloc/report_product_state.dart';
import 'package:tadamon/features/report_products/widgets/report_products_seet_content/radio_selection_tile_component.dart';

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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportProductCubit(),
      child: BlocBuilder<ReportProductCubit, ReportProductState>(
        builder: (context, state) {
          final bool isValid = state is ReportProductIsValid;
          bool isSerialNumberError =
              state is ReportProductSerialNumberIsNotValid;
          bool isProductNameError = state is ReportProductProductNameIsNotValid;
          void sendReport(BuildContext context) {
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
                  onPressed: () => context
                      .read<ReportProductCubit>()
                      .scanBarcode(context, serialNumberController),
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
                onChanged: (value) {
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
                child: ButtonCompnent(
                  label: 'ارسال التقرير',
                  icon: Icons.send,
                  onPressed: isValid ? () => {sendReport(context)} : null,
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
  }

  @override
  void dispose() {
    serialNumberController.dispose();
    productNameController.dispose();
    super.dispose();
  }
}
