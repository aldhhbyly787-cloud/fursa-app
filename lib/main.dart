
import 'package:flutter/material.dart';

void main() {
  runApp(const FursaApp());
}

class FursaApp extends StatelessWidget {
  const FursaApp({super.key});

  static const gold = Color(0xFFD4AF37);
  static const black = Color(0xFF080808);
  static const surface = Color(0xFF191919);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'فُرصة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: black,
        colorScheme: const ColorScheme.dark(
          primary: gold,
          secondary: gold,
          surface: surface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: black,
          foregroundColor: gold,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surface,
          labelStyle: const TextStyle(color: gold),
          hintStyle: const TextStyle(color: Colors.white54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.white12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: gold),
          ),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MainPage(),
      ),
    );
  }
}

class Job {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;

  const Job({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
  });
}

const governorates = [
  'بغداد',
  'البصرة',
  'نينوى',
  'أربيل',
  'النجف',
  'كربلاء',
  'السليمانية',
  'دهوك',
  'الأنبار',
  'ديالى',
  'كركوك',
  'صلاح الدين',
  'بابل',
  'واسط',
  'ميسان',
  'ذي قار',
  'المثنى',
  'القادسية',
];

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int tab = 0;
  String city = 'بغداد';
  String search = '';

  final List<Job> jobs = [
    const Job(
      title: 'موظف مبيعات',
      company: 'شركة تجارية',
      location: 'بغداد',
      salary: 'يحدد عند المقابلة',
      type: 'دوام كامل',
    ),
    const Job(
      title: 'سائق توصيل',
      company: 'شركة توصيل',
      location: 'البصرة',
      salary: 'راتب شهري',
      type: 'دوام كامل',
    ),
    const Job(
      title: 'مصمم جرافيك',
      company: 'مكتب إعلاني',
      location: 'أربيل',
      salary: 'حسب الخبرة',
      type: 'دوام جزئي',
    ),
  ];

  final List<Job> saved = [];

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: FursaApp.surface,
      ),
    );
  }

  void toggleSave(Job job) {
    setState(() {
      if (saved.contains(job)) {
        saved.remove(job);
        message('حُذفت الوظيفة من المحفوظات');
      } else {
        saved.add(job);
        message('تم حفظ الوظيفة');
      }
    });
  }

  void addJob(Job job) {
    setState(() {
      jobs.insert(0, job);
      tab = 0;
    });
    message('تمت إضافة الوظيفة محلياً');
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      homePage(),
      searchPage(),
      AddJobPage(onPublish: addJob),
      savedPage(),
      accountPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const FursaLogo(),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => message('الإشعارات قريباً'),
          ),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
        onTap: (value) => setState(() => tab = value),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF111111),
        selectedItemColor: FursaApp.gold,
        unselectedItemColor: Colors.white54,
        selectedFontSize: 11,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'البحث',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'أضف وظيفة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'المحفوظات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }

  Widget homePage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const WelcomeCard(),
        const SizedBox(height: 18),
        locationSelector(),
        const SizedBox(height: 22),
        const SectionTitle('ماذا تريد أن تفعل؟'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ActionCard(
                icon: Icons.work_outline,
                title: 'أبحث عن عمل',
                subtitle: 'اكتشف فرص العمل',
                onTap: () => setState(() => tab = 1),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ActionCard(
                icon: Icons.business_center_outlined,
                title: 'أبحث عن موظف',
                subtitle: 'اعثر على الكفاءات',
                onTap: () => setState(() => tab = 2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionTitle('أحدث الوظائف'),
        const SizedBox(height: 12),
        ...jobs.map((job) => JobCard(
              job: job,
              isSaved: saved.contains(job),
              onSave: () => toggleSave(job),
              onApply: () => message(
                'اخترت التقديم على: ${job.title}',
              ),
            )),
        const SizedBox(height: 20),
        const SectionTitle('عن منصة فُرصة'),
        const Text(
          'منصة عراقية تجمع أصحاب العمل والباحثين عن فرص العمل في مكان واحد.',
          style: TextStyle(
            color: Colors.white70,
            height: 1.8,
          ),
        ),
      ],
    );
  }

  Widget locationSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FursaApp.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: FursaApp.gold.withOpacity(0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on, color: FursaApp.gold),
              SizedBox(width: 8),
              Text(
                'اختر محافظتك',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: city,
            dropdownColor: FursaApp.surface,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.map_outlined,
                color: FursaApp.gold,
              ),
            ),
            items: governorates.map((g) {
              return DropdownMenuItem(
                value: g,
                child: Text(g),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => city = value);
              }
            },
          ),
          const SizedBox(height: 8),
          const Text(
            'اختر محافظتك لعرض الوظائف المتاحة.',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchPage() {
    final results = jobs.where((job) {
      return job.location == city &&
          (job.title.contains(search) ||
              job.company.contains(search));
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('البحث عن الوظائف'),
        const SizedBox(height: 14),
        TextField(
          decoration: const InputDecoration(
            hintText: 'اكتب اسم الوظيفة أو المهنة',
            prefixIcon: Icon(
              Icons.search,
              color: FursaApp.gold,
            ),
          ),
          onChanged: (value) {
            setState(() => search = value);
          },
        ),
        const SizedBox(height: 14),
        locationSelector(),
        const SizedBox(height: 20),
        const SectionTitle('نتائج البحث'),
        const SizedBox(height: 12),
        if (results.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'لا توجد وظائف مطابقة حالياً.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ...results.map((job) => JobCard(
              job: job,
              isSaved: saved.contains(job),
              onSave: () => toggleSave(job),
              onApply: () => message(
                'اخترت التقديم على الوظيفة',
              ),
            )),
      ],
    );
  }

  Widget savedPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('الوظائف المحفوظة'),
        const SizedBox(height: 14),
        if (saved.isEmpty)
          const Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              'لا توجد وظائف محفوظة حالياً.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ...saved.map((job) => JobCard(
              job: job,
              isSaved: true,
              onSave: () => toggleSave(job),
              onApply: () => message(
                'اخترت التقديم على الوظيفة',
              ),
            )),
      ],
    );
  }

  Widget accountPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const WelcomeCard(),
        const SizedBox(height: 20),
        const SectionTitle('حسابك في فُرصة'),
        const SizedBox(height: 12),
        AccountOption(
          icon: Icons.person_outline,
          title: 'الملف الشخصي',
          onTap: () => message('الملف الشخصي قريباً'),
        ),
        AccountOption(
          icon: Icons.work_outline,
          title: 'طلباتي وتقديماتي',
          onTap: () => message('طلبات التقديم قريباً'),
        ),
        AccountOption(
          icon: Icons.chat_bubble_outline,
          title: 'المراسلات',
          onTap: () => message(
            'المراسلة متاحة بعد التقديم أو قبول الطلب',
          ),
        ),
        AccountOption(
          icon: Icons.verified_user_outlined,
          title: 'توثيق الحساب',
          onTap: () => message('توثيق الحساب قريباً'),
        ),
        AccountOption(
          icon: Icons.star_border,
          title: 'التقييمات',
          onTap: () => message('التقييمات قريباً'),
        ),
        AccountOption(
          icon: Icons.settings_outlined,
          title: 'الإعدادات',
          onTap: () => message('الإعدادات قريباً'),
        ),
        AccountOption(
          icon: Icons.help_outline,
          title: 'المساعدة والدعم',
          onTap: () => message('الدعم الفني قريباً'),
        ),
      ],
    );
  }
}

class AddJobPage extends StatefulWidget {
  final ValueChanged<Job> onPublish;

  const AddJobPage({
    super.key,
    required this.onPublish,
  });

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final salaryController = TextEditingController();

  String location = 'بغداد';
  String type = 'دوام كامل';

  @override
  void dispose() {
    titleController.dispose();
    companyController.dispose();
    salaryController.dispose();
    super.dispose();
  }

  void publish() {
    if (titleController.text.trim().isEmpty ||
        companyController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال عنوان الوظيفة واسم جهة العمل'),
        ),
      );
      return;
    }

    widget.onPublish(
      Job(
        title: titleController.text.trim(),
        company: companyController.text.trim(),
        location: location,
        salary: salaryController.text.trim().isEmpty
            ? 'يحدد عند المقابلة'
            : salaryController.text.trim(),
        type: type,
      ),
    );

    titleController.clear();
    companyController.clear();
    salaryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('إضافة إعلان وظيفة'),
        const SizedBox(height: 18),
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'عنوان الوظيفة',
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: companyController,
          decoration: const InputDecoration(
            labelText: 'اسم الشركة أو صاحب العمل',
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: salaryController,
          decoration: const InputDecoration(
            labelText: 'الراتب أو الأجر',
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: location,
          dropdownColor: FursaApp.surface,
          decoration: const InputDecoration(
            labelText: 'المحافظة',
          ),
          items: governorates.map((g) {
            return DropdownMenuItem(
              value: g,
              child: Text(g),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => location = value);
            }
          },
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: type,
          dropdownColor: FursaApp.surface,
          decoration: const InputDecoration(
            labelText: 'نوع العمل',
          ),
          items: const [
            DropdownMenuItem(
              value: 'دوام كامل',
              child: Text('دوام كامل'),
            ),
            DropdownMenuItem(
              value: 'دوام جزئي',
              child: Text('دوام جزئي'),
            ),
            DropdownMenuItem(
              value: 'عمل عن بعد',
              child: Text('عمل عن بعد'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() => type = value);
            }
          },
        ),
        const SizedBox(height: 22),
        GoldButton(
          text: 'نشر الوظيفة',
          onPressed: publish,
        ),
        const SizedBox(height: 14),
        const Text(
          'النشر الحالي تجريبي ومحلي. ربط قاعدة البيانات مطلوب حتى تظهر الوظيفة لجميع المستخدمين.',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class FursaLogo extends StatelessWidget {
  const FursaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: FursaApp.gold.withOpacity(0.6),
        ),
        boxShadow: [
          BoxShadow(
            color: FursaApp.gold.withOpacity(0.15),
            blurRadius: 12,
          ),
        ],
      ),
      child: const Text(
        'فُرصة',
        style: TextStyle(
          color: FursaApp.gold,
          fontSize: 28,
          fontWeight: FontWeight.w900,
          shadows: [
            Shadow(
              color: Color(0xFF8B6914),
              offset: Offset(2, 3),
              blurRadius: 3,
            ),
            Shadow(
              color: Color(0xFFFFE9A0),
              offset: Offset(-1, -1),
              blurRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF30240A),
            Color(0xFF151515),
            Color(0xFF080808),
          ],
        ),
        border: Border.all(
          color: FursaApp.gold.withOpacity(0.5),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'أهلاً بك في فُرصة',
            style: TextStyle(
              color: FursaApp.gold,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'منصتك للبحث عن العمل والعثور على الكفاءات في العراق.',
            style: TextStyle(
              color: Colors.white70,
              height: 1.7,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'فرصتك تبدأ هنا',
            style: TextStyle(
              color: FursaApp.gold,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: FursaApp.gold,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: FursaApp.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: FursaApp.gold.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: FursaApp.gold, size: 32),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
    
