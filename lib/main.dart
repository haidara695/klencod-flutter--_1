import 'package:flutter/material.dart';

void main() => runApp(const MadarastiApp());

const navy = Color(0xFF063A91);
const blue = Color(0xFF0866DF);
const pale = Color(0xFFF3F7FF);
const gold = Color(0xFFF4B942);

class MadarastiApp extends StatelessWidget {
  const MadarastiApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'مدرستي',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: pale, colorScheme: ColorScheme.fromSeed(seedColor: blue), fontFamily: 'Roboto'),
        builder: (context, child) => Directionality(textDirection: TextDirection.rtl, child: child!),
        home: const MainShell(),
      );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selected = 0;
  String student = 'جلال الدين';
  final students = ['جلال الدين', 'دلال'];
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text(selected == 0 ? 'مدرستي' : ['الرئيسية', 'أبنائي', 'الإشعارات', 'المزيد'][selected], style: const TextStyle(fontWeight: FontWeight.bold)),
          actions: [IconButton(onPressed: () => setState(() => selected = 2), icon: const Icon(Icons.notifications_outlined))],
        ),
        body: SafeArea(child: selected == 0 ? _home() : selected == 1 ? _children() : selected == 2 ? _notifications() : _more()),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selected,
          onDestinationSelected: (value) => setState(() => selected = value),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.people_outline), label: 'أبنائي'),
            NavigationDestination(icon: Icon(Icons.notifications_outlined), label: 'الإشعارات'),
            NavigationDestination(icon: Icon(Icons.more_horiz), label: 'المزيد'),
          ],
        ),
      );

  Widget _home() => ListView(padding: const EdgeInsets.all(16), children: [
        _studentPicker(),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [navy, blue]), borderRadius: BorderRadius.circular(22)),
          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('مدرسة السلام الأهلية', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 8),
            Text('معًا لمستقبل أفضل ✨', style: TextStyle(color: Colors.white70)),
            SizedBox(height: 8),
            Text('العام الدراسي 2026 / 2027', style: TextStyle(color: Colors.white)),
          ]),
        ),
        const SizedBox(height: 20),
        const Text('الخدمات المدرسية', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: navy)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: .91,
          children: [
            _tile('الجداول الدراسية', Icons.calendar_month, Colors.blue, 'schedule'),
            _tile('الاختبارات', Icons.assignment_outlined, Colors.deepPurple, 'exams'),
            _tile('التقارير', Icons.description_outlined, Colors.teal, 'reports'),
            _tile('الأنشطة', Icons.emoji_events_outlined, Colors.orange, 'activities'),
            _tile('الواجبات', Icons.menu_book_outlined, Colors.cyan, 'homework'),
            _tile('الحضور والغياب', Icons.people_alt_outlined, Colors.green, 'attendance'),
          ],
        ),
        const SizedBox(height: 12),
        Card(color: const Color(0xFFFFEBCB), child: ListTile(
          leading: const Icon(Icons.workspace_premium, color: Color(0xFFB9780B), size: 36),
          title: const Text('كشف الدرجات', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('متابعة نتائج أبنائك بكل سهولة'),
          trailing: const Icon(Icons.arrow_back_ios_new), onTap: () => _open('grades'),
        )),
        const SizedBox(height: 12),
        const Text('هذه نسخة تجريبية ببيانات توضيحية.', style: TextStyle(color: Colors.grey, fontSize: 12)),
      ]);

  Widget _studentPicker() => Card(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), child: Row(children: [
        const CircleAvatar(radius: 25, backgroundColor: Color(0xFFE4EFFF), child: Icon(Icons.person, color: blue)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('ولي الأمر: محمد علي أحمد', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<String>(value: student, underline: const SizedBox(), isDense: true,
            items: students.map((s) => DropdownMenuItem(value: s, child: Text('الطالب: $s'))).toList(),
            onChanged: (s) { if (s != null) setState(() => student = s); }),
        ])),
      ])));

  Widget _tile(String title, IconData icon, Color color, String key) => InkWell(
        borderRadius: BorderRadius.circular(18), onTap: () => _open(key),
        child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: navy.withValues(alpha: .07), blurRadius: 10)]),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 34, color: color), const SizedBox(height: 10),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 3), child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          ])));

  void _open(String key) => Navigator.push(context, MaterialPageRoute(builder: (_) => FeaturePage(feature: key, student: student)));

  Widget _children() => ListView(padding: const EdgeInsets.all(16), children: [
        const Text('ملفات الأبناء', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        ...students.map((s) => Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.school)), title: Text(s), subtitle: const Text('ملف الطالب والبيانات المدرسية'), trailing: const Icon(Icons.chevron_left), onTap: () => setState(() { student = s; selected = 0; }))),
      ]);

  Widget _notifications() => ListView(padding: const EdgeInsets.all(16), children: const [
        Card(child: ListTile(leading: Icon(Icons.info_outline, color: blue), title: Text('مرحبًا بك في مدرستي'), subtitle: Text('ستظهر هنا إشعارات المدرسة عند تفعيل الربط.'))),
      ]);

  Widget _more() => ListView(padding: const EdgeInsets.all(16), children: [
        const Card(child: ListTile(leading: Icon(Icons.person_outline), title: Text('ولي الأمر'), subtitle: Text('محمد علي أحمد'))),
        Card(child: ListTile(leading: const Icon(Icons.info_outline), title: const Text('حول التطبيق'), subtitle: const Text('مدرستي • الإصدار التجريبي 1.0.0'), onTap: () => showAboutDialog(context: context, applicationName: 'مدرستي', applicationVersion: '1.0.0'))),
      ]);
}

class FeaturePage extends StatefulWidget {
  final String feature;
  final String student;
  const FeaturePage({super.key, required this.feature, required this.student});
  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  bool nextWeek = false;
  final completed = <int>{};
  static const titles = {
    'schedule': 'الجداول الدراسية', 'exams': 'جداول الاختبارات', 'reports': 'التقارير المدرسية',
    'activities': 'الأنشطة المدرسية', 'homework': 'الواجبات المنزلية', 'attendance': 'الحضور والغياب', 'grades': 'كشف الدرجات',
  };
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(backgroundColor: navy, foregroundColor: Colors.white, title: Text(titles[widget.feature] ?? 'مدرستي')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          Card(child: ListTile(leading: const Icon(Icons.account_circle, color: blue), title: Text('الطالب: ${widget.student}'), subtitle: const Text('بيانات تجريبية للمعاينة'))),
          const SizedBox(height: 12),
          ..._content(),
        ]),
      );

  Widget _entry(IconData icon, String title, String subtitle, {Color color = blue, Widget? trailing}) => Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: ListTile(
          leading: CircleAvatar(backgroundColor: color.withValues(alpha: .12), child: Icon(icon, color: color)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(subtitle), trailing: trailing,
        )),
      );

  List<Widget> _content() {
    switch (widget.feature) {
      case 'schedule':
        return [SegmentedButton<bool>(segments: const [ButtonSegment(value: false, label: Text('الأسبوع الحالي')), ButtonSegment(value: true, label: Text('الأسبوع القادم'))], selected: {nextWeek}, onSelectionChanged: (s) => setState(() => nextWeek = s.first)),
          const SizedBox(height: 12),
          ...['العلوم', 'الرياضيات', 'اللغة العربية', 'اللغة الإنجليزية', 'التربية الإسلامية'].asMap().entries.map((e) => _entry([Icons.science, Icons.calculate, Icons.menu_book, Icons.language, Icons.mosque][e.key], e.value, 'الحصة ${['الأولى', 'الثانية', 'الثالثة', 'الرابعة', 'الخامسة'][e.key]} • ${8 + e.key}:00', color: [Colors.orange, Colors.blue, Colors.amber.shade800, Colors.purple, Colors.green][e.key]))];
      case 'exams':
        return [const Text('الاختبارات القادمة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          _entry(Icons.calculate, 'اختبار الرياضيات', 'الأحد 2 نوفمبر • المدة: ساعة'),
          _entry(Icons.menu_book, 'اختبار اللغة العربية', 'الثلاثاء 4 نوفمبر • المدة: ساعة'),
          _entry(Icons.science, 'اختبار العلوم', 'الخميس 6 نوفمبر • المدة: ساعة')];
      case 'reports':
        return [_entry(Icons.insert_chart_outlined, 'تقرير الفصل الأول', 'المستوى العام: 95% • التقدير: ممتاز', color: Colors.green),
          _entry(Icons.emoji_events, 'السلوك والانضباط', 'التقدير: ممتاز', color: Colors.orange),
          _entry(Icons.note_alt_outlined, 'ملاحظات المعلم', 'طالب مجتهد ومتميز في جميع المواد.')];
      case 'activities':
        return [_entry(Icons.sports_soccer, 'اليوم الرياضي', 'أنشطة رياضية مدرسية'), _entry(Icons.palette, 'معرض المواهب', 'مشاركة الطلاب في الأنشطة الفنية'), _entry(Icons.volunteer_activism, 'المبادرة التطوعية', 'تعزيز التعاون والعمل الجماعي')];
      case 'homework':
        return [const Text('اضغط على مربع الاختيار لتحديد الواجب المنجز محليًا.', style: TextStyle(color: Colors.grey)),
          ...['اللغة العربية|حل ورقة العمل عن الاسم والفعل', 'الرياضيات|حل التمارين من صفحة 45 إلى 47', 'العلوم|مراجعة درس وحدات الإخراج'].asMap().entries.map((e) {
            final parts = e.value.split('|');
            return _entry(Icons.book_outlined, parts[0], parts[1], trailing: Checkbox(value: completed.contains(e.key), onChanged: (v) => setState(() { if (v == true) { completed.add(e.key); } else { completed.remove(e.key); } })));
          })];
      case 'attendance':
        return [Card(color: const Color(0xFFE4F8EF), child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [const Text('نسبة الحضور هذا الشهر'), const SizedBox(height: 8), Text('92%', style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.green.shade700)), const LinearProgressIndicator(value: .92, minHeight: 10), const SizedBox(height: 10), const Text('22 يوم حضور • يومان غياب')]))),
          _entry(Icons.check_circle, 'أيام الحضور', '22 يومًا', color: Colors.green), _entry(Icons.cancel, 'أيام الغياب', 'يومان', color: Colors.red)];
      case 'grades':
        return [_entry(Icons.calculate, 'الرياضيات', '98 / 100', color: Colors.green), _entry(Icons.science, 'العلوم', '95 / 100', color: Colors.blue), _entry(Icons.menu_book, 'اللغة العربية', '96 / 100', color: Colors.orange), _entry(Icons.language, 'اللغة الإنجليزية', '94 / 100', color: Colors.purple),
          Card(color: const Color(0xFFFFEBCB), child: ListTile(title: const Text('المعدل العام'), trailing: const Text('95.75%', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: navy))))];
      default:
        return [const Text('لا توجد بيانات حاليًا')];
    }
  }
}
