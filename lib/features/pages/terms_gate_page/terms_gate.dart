import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/routing/routes.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/textbutton_component/textbuttonicon_component.dart';
import 'package:tadamon/core/widgets/app_bar/side_page_app_bar.dart';

class TermsGate extends StatefulWidget {
  const TermsGate({super.key});

  @override
  State<TermsGate> createState() => _TermsGateState();
}

class _TermsGateState extends State<TermsGate> with TickerProviderStateMixin {
  bool _loading = true;
  bool _isChecked = false;
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;

  final List<String> _terms = [
    // ▓ القسم الأول: الرخصة القانونية (GNU GPL v3)
    'يُتاح تطبيق "تضامن" وفق رخصة جنو العمومية الإصدار الثالث (GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007)، وهي رخصة حرة تضمن للمستخدمين حرية استخدام البرنامج ودراسته وتعديله وإعادة توزيعه بشرط الالتزام التام بكافة بنودها.',
    'يتوجب على أي طرف يقوم بتعديل أي جزء من التطبيق أن يُحرص على إبقاء النسخة المعدلة مرخّصة تحت نفس رخصة GPLv3، مع ضرورة ذكر وتوضيح كافة التعديلات التي طرأت على المشروع الأصلي بصورة شفافة وواضحة.',
    'يمنع منعا باتا استخدام الكود المصدري الخاص بالتطبيق في أي مشروع تجاري مغلق المصدر أو تحويله إلى ترخيص يتعارض مع أحكام رخصة GPLv3.',
    'يتوجب على كل من يقوم باستخدام التطبيق أو توزيعه تضمين نسخة كاملة من ملف الرخصة وإشعار حقوق ملكية الكود الأصلي في كافة النسخ الموزعة.',
    'باستخدام التطبيق، يقر المستخدم بأنه على دراية كاملة بمفهوم المصادر المفتوحة وحقوقه والتزاماته الناشئة عن تلك الرخصة.',
    'لا يمنح هذا الترخيص أي حقوق فيما يتعلق ببراءات الاختراع أو العلامات التجارية التابعة لمطوري التطبيق أو لأطراف أخرى.',

    // ▓ القسم الثاني: المسؤولية القانونية وإخلاء المسؤولية
    'يحظر على المستخدم استغلال التطبيق في أنشطة غير قانونية أو تلك التي تتعارض مع الآداب العامة أو تُحدث ضررا لأي طرف سواء كان فردا أو جهة، مع العلم أن أي انتهاك لهذا الشرط سيستدعي اتخاذ الإجراءات التقنية والقانونية المناسبة.',
    'يُمنع استخدام التطبيق بأي شكل من الأشكال للتحريض على الكراهية أو العنف أو التمييز أو الإساءة لأي فرد أو جماعة.',
    'لا يقدم مطورو التطبيق ضمان لاستمرار تشغيل الخدمة بشكل دائم أو خلوها من الأعطال التقنية أو الانقطاعات الطارئة، مما يلغي أي مسؤولية فيما يتعلق باستمرارية الخدمة.',
    'سيقوم المطور بدعم التطبيق عندما يتوفر لديه الوقت لذلك، مع الحرص على تحسين أدائه وجعله يعمل بشكل صحيح.',

    // ▓ القسم الثالث: الخصوصية والبيانات
    'يحافظ تطبيق "تضامن" على خصوصية المستخدم؛ فلا يقوم التطبيق بجمع معلومات تعريف شخصية (PII) أو بيانات حساسة.',
    'يقتصر استخدام الصلاحيات التي يطلبها التطبيق (مثل الوصول إلى الكاميرا أو الإنترنت) على الوظائف المعلنة مثل قراءة الرموز الشريطية أو تحميل البيانات، وتُستخدم هذه الصلاحيات فقط ضمن نطاق الخدمة المُقدمة.',
    'عند تقديم بلاغ عبر التطبيق، تُستخدم البيانات المُرسلة لتوضيح تفاصيل البلاغ وتحليلها، مع التأكيد على أنها لا ترتبط مباشرة بهوية المستخدم؛ كما يتم التعامل مع هذه البيانات بسرية ويتم حذفها بشكل دوري بعد مراجعتها.',

    // ▓ القسم الرابع: المحتوى والمجتمع
    'يحظر نشر محتوى كاذب أو مضلل أو تشهيري أو عنصري أو يحرض على الكراهية، ويعتبر كل مخالفة للسياسة سبباً لاتخاذ إجراءات قد تشمل حذف المحتوى أو إيقاف الحسابات المخالفة بشكل مؤقت أو دائم.',
    'لا يتحمل التطبيق أو فريق تطويره أي مسؤولية عن مصداقية أو دقة البلاغات أو المحتويات التي ينشرها المستخدمون، إذ تبقى المسؤولية القانونية لأصحابها فقط.',
    'يجوز لفريق التطوير تعديل أو حذف المحتوى الذي يخالف شروط الاستخدام أو يُشكّل تهديداً لسلامة المستخدمين دون إشعار مسبق، مع توفير آلية للإبلاغ عن المحتوى المخالف يتم مراجعتها بشكل دوري.',
    'ينبغي على المستخدمين الإبلاغ عن أي محتوى غير لائق أو مخالف لتلك الشروط، وذلك لضمان بيئة رقمية آمنة ومشجعة للجميع.',

    // ▓ القسم الخامس: التحديثات والتعديلات
    'يحتفظ فريق تطوير "تضامن" بالحق الكامل في تعديل أو تحديث أو تغيير هذه الشروط والأحكام دون إشعار مسبق، حيث تُعتبر النسخة المنشورة في التطبيق والموقع الرسمي هي النسخة المعتمدة والنافذة في أي وقت.',
    'يتعين على المستخدمين مراجعة الشروط بشكل دوري للاطلاع على أي تعديلات مستقبلية، ويُعتبر استمرارهم في استخدام التطبيق بعد أي تغيير بمثابة قبول ضمني بهذه التعديلات.',
    'قد تتطلب بعض التحسينات أو الميزات الجديدة إجراء تحديثات تقنية لاحقة قد تؤثر على وظائف التطبيق أو واجهته؛ وفي هذه الحالة يُعلن مسبقًا عن أي تغييرات جذرية قد تؤثر على تجربة المستخدم.',
    'يحتفظ فريق التطوير بالحق في تعليق أو إيقاف أي جزء من التطبيق لأسباب تقنية، تجارية أو تنظيمية دون تحمل أي مسؤولية، مع توفير بدائل أو إعلام المستخدمين حسب الإمكان.',
    'لا يشمل الدعم الفني المستمر في هذه الاتفاقية إلا إذا تم الاتفاق عليه بصيغة منفصلة وواضحة مع المستخدم أو الشركاء.',

    // ▓ القسم السادس: حقوق النشر والممتلكات الفكرية
    'تُعتبر كافة الأكواد المصدرية، التصاميم، الرسومات، الشعارات، العلامات التجارية، والمواد الأخرى المتوفرة في تطبيق "تضامن" ملكية حصرية للمطورين أو لأصحاب الحقوق المصرح لهم، ويُحظر نسخها أو استخدامها أو إعادة نشرها بدون إذن كتابي صريح.',
    'يحظر على أي جهة استغلال أو إعادة توزيع أجزاء من التطبيق أو محتوياته سواء كانت نصوصاً، صوراً، أو غيرها لأي أغراض تجارية أو غير تجارية دون الرجوع إلى حقوق الملكية الفكرية الخاصة بتطبيق "تضامن".',
    'يجب على المستخدمين الالتزام بكافة حقوق النشر وعدم تغيير أو تعديل أي إشارات أو علامات تدل على حقوق الملكية الفكرية الواردة في التطبيق.',
    'أي انتهاك لهذه الحقوق سيُعتبر تعدياً جسيمًا على الملكية الفكرية وقد يؤدي إلى اتخاذ إجراءات قانونية صارمة بحق المخالفين دون سابق إنذار.'
  ];

  @override
  void initState() {
    super.initState();
    _checkAgreement();
    _initAnimations();
  }

  void _initAnimations() {
    _controllers = List.generate(
      _terms.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 250 + (index * 100)),
      ),
    );

    _slideAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));
    }).toList();

    // Delay start a bit for UX
    Future.delayed(const Duration(milliseconds: 200), () {
      for (var controller in _controllers) {
        controller.forward();
      }
    });
  }

  Future<void> _checkAgreement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool agreed = prefs.getBool('agreed_to_terms') ?? false;
    if (agreed) {
      _navigateToHome();
    } else {
      setState(() => _loading = false);
    }
  }

  Future<void> _agree() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('agreed_to_terms', true);
    _navigateToHome();
  }

  void _navigateToHome() {
    HapticFeedback.vibrate();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.mainPage,
      (route) => false,
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: const SidePageAppBar(
        title: 'اتفاقية استخدام التطبيق',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SenseiConst.padding.w,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _terms.length,
                itemBuilder: (context, index) {
                  return SlideTransition(
                    position: _slideAnimations[index],
                    child: FadeTransition(
                      opacity: _controllers[index],
                      child: Card(
                        margin: EdgeInsets.only(top: SenseiConst.margin.h),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(SenseiConst.padding),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${index + 1}. ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: Text(_terms[index])),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                const Text('أوافق على الشروط والأحكام'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: SenseiConst.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextbuttonIconComponent(
                    onPressed: () =>
                        {HapticFeedback.vibrate(), SystemNavigator.pop()},
                    text: ' الخروج من التطبيق',
                    icon: Icons.close,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: ButtonCompnent(
                      label: 'مرحبًا بكم في تضامن',
                      icon: Icons.keyboard_double_arrow_left_rounded,
                      onPressed: _isChecked
                          ? () {
                              HapticFeedback.vibrate();
                              _agree();
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
