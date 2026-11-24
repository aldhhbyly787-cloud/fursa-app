
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
  int currentTab = 0;
  String accountType = '';
  String searchText = '';

  final searchController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final cityController = TextEditingController();
  final professionController = TextEditingController();
  final experienceController = TextEditingController();
  final companyController = TextEditingController();

  final List<Job> jobs = [
    const Job(
      title: 'عامل بناء',
      company: 'شركة الإعمار',
      city: 'بغداد',
      salary: 'حسب الاتفاق',
      details: 'مطلوب عامل بناء لديه خبرة في أعمال البناء.',
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
    searchController.dispose();
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    cityController.dispose();
    professionController.dispose();
    experienceController.dispose();
    companyController.dispose();
    super.dispose();
  }

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

        child: Column(
          children: [
            Icon(icon, color: FursaApp.gold, size: 32),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  List<int> get filteredJobs {
    return List.generate(jobs.length, (index) => index)
        .where((index) {
      final job = jobs[index];
      final query = searchText.toLowerCase();
      return job.title.toLowerCase().contains(query) ||
          job.company.toLowerCase().contains(query) ||
          job.city.toLowerCase().contains(query);
    }).toList();
  }

  Widget jobCard(int index) {
    final job = jobs[index];
    return Card(
      color: const Color(0xFF202020),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.work, color: FursaApp.gold),
        title: Text(job.title),
        subtitle: Text(
          '${job.company} • ${job.city}\n${job.salary}',
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(
            favorites.contains(index)
                ? Icons.favorite
                : Icons.favorite_border,
            color: FursaApp.gold,
          ),
          onPressed: () {
            setState(() {
              if (favorites.contains(index)) {
                favorites.remove(index);
              } else {
                favorites.add(index);
              }
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
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF202020),
        title: Text(job.title,
            style: const TextStyle(color: FursaApp.gold)),
        content: Text(
          'الشركة: ${job.company}\n'
          'المحافظة: ${job.city}\n'
          'الراتب: ${job.salary}\n\n'
          '${job.details}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              message('يلزم إنشاء حساب عامل قبل التقديم');
            },
            child: const Text('تقديم على الوظيفة'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Widget buildJobsPage() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'الوظائف المتاحة',
          style: TextStyle(
            color: FursaApp.gold,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: searchController,
          onChanged: (value) => setState(() => searchText = value),
          decoration: decoration('ابحث عن وظيفة', Icons.search),
        ),
        const SizedBox(height: 15),
        ...filteredJobs.map((index) => jobCard(index)),
        if (filteredJobs.isEmpty)
          const Center(child: Text('لا توجد وظائف مطابقة')),
      ],
    );
  }

  Widget buildFavoritesPage() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'الوظائف المحفوظة',
          style: TextStyle(
            color: FursaApp.gold,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        ...favorites.map((index) => jobCard(index)),
        if (favorites.isEmpty)
          const Center(child: Text('لم تحفظ أي وظيفة بعد')),
      ],
    );
  }

  Widget buildAccountPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Icon(
          Icons.account_circle,
          size: 85,
          color: FursaApp.gold,
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'حسابي',
            style: TextStyle(
              color: FursaApp.gold,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 25),
        ListTile(
          leading: const Icon(Icons.person, color: FursaApp.gold),
          title: Text(nameController.text.isEmpty
              ? 'الاسم: لم يتم التسجيل'
              : nameController.text),
        ),
        ListTile(
          leading: const Icon(Icons.phone, color: FursaApp.gold),
          title: Text(phoneController.text.isEmpty
              ? 'رقم الهاتف: غير مسجل'
              : phoneController.text),
        ),
        ListTile(
          leading: const Icon(Icons.work, color: FursaApp.gold),
          title: Text('نوع الحساب: ${accountType.isEmpty ? "غير محدد" : accountType}'),
        ),
        ListTile(
          leading: const Icon(Icons.location_on, color: FursaApp.gold),
          title: Text('المحافظة: ${cityController.text}'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.star, color: FursaApp.gold),
          title: const Text('التقييمات'),
          onTap: () => message('نظام التقييمات سيُفعّل لاحقاً'),
        ),
        ListTile(
          leading: const Icon(Icons.verified_user, color: FursaApp.gold),
          title: const Text('توثيق الهوية'),
          onTap: () => message('التوثيق سيُفعّل في المرحلة القادمة'),
        ),
        ListTile(
          leading: const Icon(Icons.info_outline, color: FursaApp.gold),
          title: const Text('عن منصة فُرصة'),
          onTap: () => message('منصة عراقية للتوظيف وربط العامل بصاحب العمل'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FursaApp.black,
        centerTitle: true,
        title: const Text(
          'فُرصة',
          style: TextStyle(
            color: FursaApp.gold,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => message('لا توجد إشعارات حالياً'),
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentTab,
        children: [
          buildHome(),
          buildJobsPage(),
          buildFavoritesPage(),
          buildAccountPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (index) => setState(() => currentTab = index),
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

  InputDecoration decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: FursaApp.gold),
      filled: true,
      fillColor: const Color(0xFF202020),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
  
