
import 'package:flutter/material.dart';

void main() {
  runApp(const FursaApp());
}

class FursaApp extends StatelessWidget {
  const FursaApp({super.key});

  static const gold = Color(0xFFD4AF37);
  static const black = Color(0xFF101010);
  static const panel = Color(0xFF1C1C1C);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'فُرصة',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: black,
        primaryColor: gold,
        colorScheme: const ColorScheme.dark(
          primary: gold,
          secondary: gold,
          surface: panel,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: black,
          foregroundColor: gold,
          centerTitle: true,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: panel,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MainScreen(),
      ),
    );
  }
}

class Job {
  final String title;
  final String company;
  final String city;
  final String salary;
  final IconData icon;

  const Job({
    required this.title,
    required this.company,
    required this.city,
    required this.salary,
    required this.icon,
  });
}

const jobs = [
  Job(
    title: 'موظف مبيعات',
    company: 'شركة النخبة',
    city: 'بغداد',
    salary: '600,000 د.ع',
    icon: Icons.storefront,
  ),
  Job(
    title: 'سائق',
    company: 'شركة التوصيل',
    city: 'البصرة',
    salary: '750,000 د.ع',
    icon: Icons.local_shipping,
  ),
  Job(
    title: 'محاسب',
    company: 'مجموعة الأعمال',
    city: 'أربيل',
    salary: '900,000 د.ع',
    icon: Icons.calculate,
  ),
  Job(
    title: 'عامل مطعم',
    company: 'مطعم الذوق',
    city: 'النجف',
    salary: '500,000 د.ع',
    icon: Icons.restaurant,
  ),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  String searchText = '';

  final pages = const [
    HomePage(),
    JobsPage(),
    PublishPage(),
    SavedPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF191919),
        indicatorColor: FursaApp.gold.withValues(alpha: 0.18),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: FursaApp.gold),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work, color: FursaApp.gold),
            label: 'الوظائف',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle, color: FursaApp.gold),
            label: 'أضف وظيفة',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark, color: FursaApp.gold),
            label: 'المحفوظات',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: FursaApp.gold),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 12),
        Center(
          child: Column(
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: FursaApp.gold, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: FursaApp.gold.withValues(alpha: 0.2),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.workspace_premium,
                  color: FursaApp.gold,
                  size: 42,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'فُرصة',
                style: TextStyle(
                  color: FursaApp.gold,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const Text(
                'طريقك إلى العمل يبدأ من هنا',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF292318), Color(0xFF171717)],
            ),
            border: Border.all(color: FursaApp.gold.withValues(alpha: 0.5)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مستقبلك المهني يبدأ الآن',
                style: TextStyle(
                  color: FursaApp.gold,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'اكتشف الوظائف المناسبة لك أو اعثر على الموظف المناسب لعملك.',
                style: TextStyle(color: Colors.white70, height: 1.6),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const SectionTitle(title: 'استكشف فُرصة'),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: FeatureCard(
                icon: Icons.search,
                title: 'ابحث عن عمل',
                subtitle: 'اكتشف الوظائف',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: FeatureCard(
                icon: Icons.business_center,
                title: 'وظّف الآن',
                subtitle: 'اعثر على عامل',
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        const SectionTitle(title: 'أحدث الوظائف'),
        const SizedBox(height: 10),
        ...jobs.take(3).map((job) => JobCard(job: job)),
      ],
    );
  }
}

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = jobs.where((job) {
      return job.title.contains(query) ||
          job.city.contains(query) ||
          job.company.contains(query);
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const PageTitle(title: 'الوظائف المتاحة'),
        const SizedBox(height: 18),
        TextField(
          onChanged: (value) => setState(() => query = value),
          decoration: const InputDecoration(
            hintText: 'ابحث عن وظيفة أو محافظة',
            prefixIcon: Icon(Icons.search, color: FursaApp.gold),
          ),
        ),
        const SizedBox(height: 18),
        ...filtered.map((job) => JobCard(job: job)),
        if (filtered.isEmpty)
          const Padding(
            padding: EdgeInsets.all(30),
            child: Center(child: Text('لا توجد نتائج مطابقة')),
          ),
      ],
    );
  }
}

class PublishPage extends StatelessWidget {
  const PublishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const PageTitle(title: 'نشر وظيفة'),
        const SizedBox(height: 10),
        const Text(
          'أضف تفاصيل الوظيفة حتى يتمكن الباحثون عن عمل من العثور عليها.',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 22),
        const InputField(label: 'عنوان الوظيفة'),
        const InputField(label: 'اسم الشركة'),
        const InputField(label: 'المحافظة'),
        const InputField(label: 'الراتب المتوقع'),
        const InputField(label: 'تفاصيل الوظيفة', maxLines: 4),
        const SizedBox(height: 15),
        GoldButton(
          text: 'نشر الوظيفة',
          onPressed: () {
            showMessage(context, 'هذه الواجهة تجريبية حالياً');
          },
        ),
      ],
    );
  }
}

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, color: FursaApp.gold, size: 65),
          SizedBox(height: 12),
          Text(
            'المحفوظات',
            style: TextStyle(
              color: FursaApp.gold,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text('ستظهر الوظائف التي تحفظها هنا'),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const PageTitle(title: 'حسابي'),
        const SizedBox(height: 25),
        const Center(
          child: CircleAvatar(
            radius: 48,
            backgroundColor: Color(0xFF292318),
            child: Icon(Icons.person, color: FursaApp.gold, size: 55),
          ),
        ),
        const SizedBox(height: 14),
        const Center(
          child: Text(
            'مرحباً بك في فُرصة',
            style: TextStyle(
              color: FursaApp.gold,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 25),
        const AccountOption(icon: Icons.person_outline, title: 'بيانات الحساب'),
        const AccountOption(icon: Icons.work_outline, title: 'طلباتي'),
        const AccountOption(icon: Icons.chat_bubble_outline, title: 'المراسلات'),
        const AccountOption(icon: Icons.verified_user_outlined, title: 'توثيق الحساب'),
        const AccountOption(icon: Icons.notifications_outlined, title: 'الإشعارات'),
        const AccountOption(icon: Icons.settings_outlined, title: 'الإعدادات'),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: FursaApp.gold,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class PageTitle extends StatelessWidget {
  final String title;

  const PageTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: FursaApp.gold,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: FursaApp.panel,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: FursaApp.gold.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: FursaApp.gold, size: 35),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: FursaApp.panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: FursaApp.gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(job.icon, color: FursaApp.gold, size: 27),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.title,
                  style: const TextStyle(
                    color: FursaApp.gold,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  job.company,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 5),
                Text(
                  '${job.city} • ${job.salary}',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              showMessage(context, 'تفاصيل الوظيفة قريباً');
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: FursaApp.gold),
          ),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final int maxLines;

  const InputField({
    super.key,
    required this.label,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}

class AccountOption extends StatelessWidget {
  final IconData icon;
  final String title;

  const AccountOption({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: FursaApp.panel,
        borderRadius: BorderRadius.circular(13),
      ),
      child: ListTile(
        leading: Icon(icon, color: FursaApp.gold),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_back_ios,
          color: FursaApp.gold,
          size: 16,
        ),
        onTap: () {
          showMessage(context, 'هذه الخاصية قيد التطوير');
        },
      ),
    );
  }
}

class GoldButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GoldButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: FursaApp.gold,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: const Color(0xFF292318),
    ),
  );
}
