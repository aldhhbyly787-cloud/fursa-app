
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
        colorScheme: ColorScheme.dark(
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: FursaApp.gold,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget actionCard(IconData icon, String title) {
    return Card(
      color: const Color(0xFF202020),
      child: Padding(
        padding: const EdgeInsets.all(18),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FursaApp.black,
        title: const Text(
          'فُرصة',
          style: TextStyle(
            color: FursaApp.gold,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'فرصتك للعمل تبدأ من هنا',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18),
          TextField(
            decoration: InputDecoration(
              hintText: 'ابحث عن وظيفة أو مهنة',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFF202020),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          sectionTitle('ماذا تريد أن تفعل؟'),
          Row(
            children: [
              Expanded(
                child: actionCard(Icons.work_outline, 'البحث عن عمل'),
              ),
              Expanded(
                child: actionCard(Icons.people_outline, 'البحث عن عمال'),
              ),
            ],
          ),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: FursaApp.gold,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('إضافة إعلان وظيفة'),
            ),
          ),
          sectionTitle('أحدث الوظائف'),
          const Card(
            color: Color(0xFF202020),
            child: ListTile(
              leading: Icon(Icons.work, color: FursaApp.gold),
              title: Text('ستظهر أحدث الوظائف هنا'),
              subtitle: Text('من جميع محافظات العراق'),
            ),
          ),
          sectionTitle('الوظائف المطلوبة'),
          const Card(
            color: Color(0xFF202020),
            child: ListTile(
              leading: Icon(Icons.trending_up, color: FursaApp.gold),
              title: Text('المهن الأكثر طلباً'),
              subtitle: Text('سيتم عرضها هنا'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'البحث',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'المفضلة',
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
