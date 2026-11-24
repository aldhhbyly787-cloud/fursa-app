
import 'package:flutter/material.dart';

void main() {
  runApp(const FursaApp());
}

class FursaApp extends StatelessWidget {
  const FursaApp({super.key});

  static const gold = Color(0xFFD4AF37);
  static const black = Color(0xFF101010);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'فُرصة',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: black,
        colorScheme: const ColorScheme.dark(
          primary: gold,
          surface: Color(0xFF202020),
        ),
        useMaterial3: true,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomePage(),
      ),
    );
  }
}

class FursaLogo extends StatelessWidget {
  const FursaLogo({super.key, this.size = 48});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size * 1.7,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: const Offset(0, 5),
            child: Text(
              'فُرصة',
              style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF805B0B),
                shadows: const [
                  Shadow(color: Colors.black, blurRadius: 8,
                      offset: Offset(3, 5)),
                ],
              ),
            ),
          ),
          Text(
            'فُرصة',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w900,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [
                    Color(0xFFFFF1A8),
                    Color(0xFFD4AF37),
                    Color(0xFFFFD966),
                    Color(0xFF9C7418),
                  ],
                ).createShader(const Rect.fromLTWH(0, 0, 220, 80)),
              shadows: const [
                Shadow(color: Color(0xFFFFD700), blurRadius: 12),
                Shadow(color: Colors.black, blurRadius: 4,
                    offset: Offset(2, 3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Job {
  final String title;
  final String company;
  final String city;
  final String salary;
  final String details;

  const Job({
    required this.title,
    required this.company,
    required this.city,
    required this.salary,
    required this.details,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  String accountType = '';
  String search = '';

  final name = TextEditingController();
  final phone = TextEditingController();
  final city = TextEditingController();
  final profession = TextEditingController();
  final searchController = TextEditingController();

  final List<Job> jobs = [
    const Job(
      title: 'عامل بناء',
      company: 'شركة الإعمار',
      city: 'بغداد',
      salary: 'حسب الاتفاق',
      details: 'مطلوب عامل بناء للعمل ضمن فريق محترف.',
    ),
    const Job(
      title: 'صباغ بيوت',
      company: 'شركة الديكور',
      city: 'بغداد',
      salary: 'حسب الخبرة',
      details: 'مطلوب صباغ لديه خبرة في صبغ المنازل.',
    ),
    const Job(
      title: 'سائق',
      company: 'شركة النقل',
      city: 'البصرة',
      salary: '600,000 دينار',
      details: 'مطلوب سائق للعمل بدوام كامل.',
    ),
    const Job(
      title: 'موظف مبيعات',
      company: 'شركة تجارية',
      city: 'كربلاء',
      salary: '500,000 دينار',
      details: 'مطلوب موظف مبيعات حسن التعامل.',
    ),
  ];

  final Set<int> favorites = {};

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    city.dispose();
    profession.dispose();
    searchController.dispose();
    super.dispose();
  }

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  InputDecoration fieldDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: FursaApp.gold),
      filled: true,
      fillColor: const Color(0xFF202020),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF51421C)),
      ),
    );
  }

  Widget goldButton(String title, VoidCallback action) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: FursaApp.gold,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(
        title,
        style: const TextStyle(
          color: FursaApp.gold,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List<int> get filteredJobs {
    return List.generate(jobs.length, (i) => i).where((i) {
      final j = jobs[i];
      final q = search.toLowerCase();
      return j.title.toLowerCase().contains(q) ||
          j.company.toLowerCase().contains(q) ||
          j.city.toLowerCase().contains(q);
    }).toList();
  }

  void chooseAccount() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF202020),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            sectionTitle('اختر نوع الحساب'),
            goldButton('حساب عامل', () {
              Navigator.pop(ctx);
              accountType = 'عامل';
              showProfileForm();
            }),
            const SizedBox(height: 12),
            goldButton('حساب صاحب عمل', () {
              Navigator.pop(ctx);
              accountType = 'صاحب عمل';
              showProfileForm();
            }),
          ],
        ),
      ),
    );
  }

  void showProfileForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF171717),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
          20, 24, 20,
          MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const FursaLogo(size: 38),
              sectionTitle('إنشاء حساب $accountType'),
              TextField(
                controller: name,
                decoration: fieldDecoration('الاسم الكامل', Icons.person),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: fieldDecoration('رقم الهاتف', Icons.phone),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: city,
                decoration: fieldDecoration('المحافظة', Icons.location_on),
              ),
              if (accountType == 'عامل') ...[
                const SizedBox(height: 12),
                TextField(
                  controller: profession,
                  decoration: fieldDecoration(
                    'المهنة أو الاختصاص',
                    Icons.work,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              goldButton('حفظ البيانات', () {
                if (name.text.trim().isEmpty ||
                    phone.text.trim().isEmpty) {
                  message('يرجى إدخال الاسم ورقم الهاتف');
                  return;
                }
                Navigator.pop(ctx);
                setState(() => tab = 3);
                message('تم حفظ البيانات في هذه النسخة التجريبية');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget jobCard(int index) {
    final job = jobs[index];
    final saved = favorites.contains(index);

    return Card(
      color: const Color(0xFF202020),
      margin: const EdgeInsets.only(bottom: 13),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFF51421C)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF3B3018),
          child: Icon(Icons.work, color: FursaApp.gold),
        ),
        title: Text(
          job.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${job.company}\n${job.city} • ${job.salary}',
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(
            saved ? Icons.favorite : Icons.favorite_border,
            color: FursaApp.gold,
          ),
          onPressed: () {
            setState(() {
              saved ? favorites.remove(index) : favorites.add(index);
            });
          },
        ),
        onTap: () => showJobDetails(index),
      ),
    );
  }

  void showJobDetails(int index) {
    final job = jobs[index];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF202020),
        title: Text(
          job.title,
          style: const TextStyle(color: FursaApp.gold),
        ),
        content: Text(
          'الشركة: ${job.company}\n'
          'المحافظة: ${job.city}\n'
          'الراتب: ${job.salary}\n\n'
          '${job.details}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              if (accountType != 'عامل' || name.text.trim().isEmpty) {
                message('يرجى إنشاء حساب عامل أولاً');
              } else {
                message('التقديم الحقيقي يحتاج ربط قاعدة البيانات');
              }
            },
            child: const Text('تقديم على الوظيفة'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  Widget buildHome() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 12),
        const Center(child: FursaLogo(size: 65)),
        const Center(
          child: Text(
            'منصتك للعمل والتوظيف',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: searchController,
          onChanged: (v) => setState(() => search = v),
          decoration: fieldDecoration(
            'ابحث عن وظيفة أو مهنة',
            Icons.search,
          ),
        ),
        sectionTitle('ماذا تريد أن تفعل؟'),
        Row(
          children: [
            Expanded(
              child: actionCard(
                Icons.work_outline,
                'البحث عن عمل',
                () => setState(() => tab = 1),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: actionCard(
                Icons.people_outline,
                'البحث عن عمال',
                () => message('قسم البحث عن العمال قيد التطوير'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        goldButton('إنشاء حساب جديد', chooseAccount),
        sectionTitle('أحدث الوظائف'),
        ...filteredJobs.map((i) => jobCard(i)),
      ],
    );
  }

  Widget actionCard(IconData icon, String title, VoidCallback action) {
    return InkWell(
      onTap: action,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF202020),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF51421C)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: FursaApp.gold, size: 36),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget buildJobs() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        sectionTitle('الوظائف المتاحة'),
        TextField(
          controller: searchController,
          onChanged: (v) => setState(() => search = v),
          decoration: fieldDecoration('ابحث عن وظيفة', Icons.search),
        ),
        const SizedBox(height: 16),
        ...filteredJobs.map((i) => jobCard(i)),
        if (filteredJobs.isEmpty)
          const Center(child: Text('لا توجد وظائف مطابقة')),
      ],
    );
  }

  Widget buildFavorites() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        sectionTitle('الوظائف المحفوظة'),
        ...favorites.map((i) => jobCard(i)),
        if (favorites.isEmpty)
          const Center(child: Text('لم تحفظ أي وظيفة بعد')),
      ],
    );
  }

  Widget buildAccount() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 20),
        const Center(child: FursaLogo(size: 55)),
        sectionTitle('حسابي'),
        ListTile(
          leading: const Icon(Icons.person, color: FursaApp.gold),
          title: Text(name.text.isEmpty ? 'لم يتم التسجيل' : name.text),
        ),
        ListTile(
          leading: const Icon(Icons.phone, color: FursaApp.gold),
          title: Text(phone.text.isEmpty ? 'رقم الهاتف غير مسجل' : phone.text),
        ),
        ListTile(
          leading: const Icon(Icons.work, color: FursaApp.gold),
          title: Text('نوع الحساب: ${accountType.isEmpty ? "غير محدد" : accountType}'),
        ),
        ListTile(
          leading: const Icon(Icons.location_on, color: FursaApp.gold),
          title: Text('المحافظة: ${city.text}'),
        ),
        const Divider(color: FursaApp.gold),
        ListTile(
          leading: const Icon(Icons.verified_user, color: FursaApp.gold),
          title: const Text('توثيق الهوية'),
          onTap: () => message('التوثيق يحتاج ربط قاعدة البيانات'),
        ),
        ListTile(
          leading: const Icon(Icons.star, color: FursaApp.gold),
          title: const Text('التقييمات'),
          onTap: () => message('التقييمات قيد التطوير'),
        ),
        ListTile(
          leading: const Icon(Icons.info_outline, color: FursaApp.gold),
          title: const Text('عن منصة فُرصة'),
          onTap: () => message('فُرصة منصة عراقية للعمل والتوظيف'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildHome(),
      buildJobs(),
      buildFavorites(),
      buildAccount(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: FursaApp.black,
        centerTitle: true,
        title: const FursaLogo(size: 27),
        actions: [
          IconButton(
            onPressed: () => message('لا توجد إشعارات حالياً'),
            icon: const Icon(
              Icons.notifications_none,
              color: FursaApp.gold,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
        onTap: (i) => setState(() => tab = i),
        backgroundColor: const Color(0xFF202020),
        selectedItemColor: FursaApp.gold,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'الوظائف',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'المحفوظة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}
