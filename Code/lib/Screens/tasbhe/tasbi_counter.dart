import 'package:flutter/material.dart';

void main() {
  runApp(const TasbeehApp());
}

class TasbeehApp extends StatelessWidget {
  const TasbeehApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto', brightness: Brightness.light, primarySwatch: Colors.green),
      home: const TasbeehScreen(),
    );
  }
}

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({Key? key}) : super(key: key);

  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _tasbeehList = [
    {
      "title": "حمد و ثنا اور توبہ و استغفار",
      "zikr": "سُبْحَانَ اللّٰهِ وَبِحَمْدِهِ",
      "translation": "پاک ہے اللّٰہ اپنی خوبیوں سمیت۔",
      "count": 0
    },
    {
      "title": "حمد و ثنا اور توبہ و استغفار",
      "zikr": "سُبْحَانَ اللّٰهِ وَبِحَمْدِهِ سُبْحَانَ اللّٰهِ الْعَظِيمِ",
      "translation": "پاک ہے اللّٰہ اپنی خوبیوں سمیت، پاک ہے اللّٰہ بہت عظمت والا۔",
      "count": 0
    },
    {
      "title": "کلمہ توحید",
      "zikr": "لَا اِلٰهَ اِلَّا اللّٰهُ",
      "translation": "اللّٰہ کے سوا کوئی عبادت کے لائق نہیں۔",
      "count": 0
    },
    {
      "title": "کلمہ استغفار",
      "zikr": "اَسْتَغْفِرُ اللّٰهَ رَبِّيْ مِنْ كُلِّ ذَنْبٍ وَاَتُوْبُ اِلَيْهِ",
      "translation": "میں اللّٰہ سے اپنے تمام گناہوں کی معافی مانگتا ہوں اور اسی کی طرف رجوع کرتا ہوں۔",
      "count": 0
    },
    {
      "title": "کلمہ تمجید",
      "zikr": "لَا حَوْلَ وَلَا قُوَّةَ اِلَّا بِاللّٰهِ",
      "translation": "اللّٰہ کے سوا کسی میں طاقت اور قدرت نہیں۔",
      "count": 0
    },
    {
      "title": "دعا",
      "zikr": "رَبِّ زِدْنِي عِلْمًا",
      "translation": "اے میرے رب! میرے علم میں اضافہ فرما۔",
      "count": 0
    },
    {
      "title": "تعریف",
      "zikr": "اَلْحَمْدُ لِلّٰهِ",
      "translation": "تمام تعریف اللّٰہ کے لئے ہے۔",
      "count": 0
    },
    {
      "title": "استغفار",
      "zikr": "اَسْتَغْفِرُ اللّٰهَ",
      "translation": "میں اللّٰہ سے معافی مانگتا ہوں۔",
      "count": 0
    },
    {
      "title": "حمد",
      "zikr": "اَللّٰهُ اَكْبَرُ",
      "translation": "اللّٰہ سب سے بڑا ہے۔",
      "count": 0
    },
    {
      "title": "درود پاک",
      "zikr": "اَللّٰهُمَّ صَلِّ عَلٰى مُحَمَّدٍ",
      "translation": "اللّٰہ پاک محمدﷺ پر رحمت نازل فرما۔",
      "count": 0
    },
    {
      "title": "سلامتی کی دعا",
      "zikr": "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً",
      "translation": "اے رب! ہمیں دنیا میں بھلائی عطا فرما۔",
      "count": 0
    },
  ];

  final List<Map<String, dynamic>> _myTasbeehList = [];

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _addTasbeeh(String title, String zikr, String translation) {
    setState(() {
      _myTasbeehList.add({
        "title": title,
        "zikr": zikr,
        "translation": translation,
        "count": 0
      });
    });
  }

  void _incrementCounter(Map<String, dynamic> tasbeeh) {
    setState(() {
      tasbeeh['count'] += 1;
    });
  }

  void _resetCounter(Map<String, dynamic> tasbeeh) {
    setState(() {
      tasbeeh['count'] = 0;
    });
  }

  void _removeTasbeeh(Map<String, dynamic> tasbeeh) {
    setState(() {
      _myTasbeehList.remove(tasbeeh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.lightGreen,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
          title: const Text(
            'Tasbeeh',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[300],
            tabs: const [
              Tab(text: 'POPULAR TASBEEH'),
              Tab(text: 'MY TASBEEH'),
            ],
          ),
        ),
        body: Container(
          color: Colors.lime[50],
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTasbeehList(_tasbeehList),
              _buildMyTasbeehList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTasbeehList(List<Map<String, dynamic>> tasbeehList) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: tasbeehList.length,
      itemBuilder: (context, index) {
        final tasbeeh = tasbeehList[index];
        return tasbeehCard(tasbeeh);
      },
    );
  }

  Widget _buildMyTasbeehList() {
    return Stack(
      children: [
        // Display the list of Tasbeehs
        if (_myTasbeehList.isNotEmpty)
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _myTasbeehList.length,
            itemBuilder: (context, index) {
              final tasbeeh = _myTasbeehList[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  _removeTasbeeh(tasbeeh);
                },
                background: Container(color: Colors.red, alignment: Alignment.centerLeft, child: const Icon(Icons.delete, color: Colors.white)),
                child: tasbeehCard(tasbeeh),
              );
            },
          ),
        // Show message if list is empty
        if (_myTasbeehList.isEmpty)
          const Center(
            child: Text('My Tasbeeh List is empty for now.'),
          ),

        // Floating Action Button remains visible for adding new Tasbeehs
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => _showCreateTasbeehDialog(context),
            child: const Icon(Icons.add),
            backgroundColor: Colors.green[200],
          ),
        ),
      ],
    );
  }

  Widget tasbeehCard(Map<String, dynamic> tasbeeh) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tasbeeh['title'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tasbeeh['zikr'],
              style: const TextStyle(
                fontSize: 20,
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tasbeeh['translation'],
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Count: ${tasbeeh['count']}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _incrementCounter(tasbeeh),
                      child: const Text('+1'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[100],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _resetCounter(tasbeeh),
                      child: const Text('Reset',style: TextStyle(color: Colors.black87),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[100],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showCreateTasbeehDialog(BuildContext context) {
    final titleController = TextEditingController();
    final zikrController = TextEditingController();
    final translationController = TextEditingController();

    showDialog(
      barrierColor: Colors.lightGreen[50],
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('Create Tasbeeh',style: TextStyle(color: Colors.lightGreen),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Zikr Title',),
                style: TextStyle(color: Colors.black87),
              ),
              TextField(
                controller: zikrController,
                decoration: const InputDecoration(labelText: 'Zikr'),
                style: TextStyle(color: Colors.black87),

              ),
              TextField(
                controller: translationController,
                decoration: const InputDecoration(labelText: 'Zikr Translation'),
                style: TextStyle(color: Colors.black87),

              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',style: TextStyle(color: Colors.black87),),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text.trim();
                final zikr = zikrController.text.trim();
                final translation = translationController.text.trim();

                if (title.isNotEmpty && zikr.isNotEmpty && translation.isNotEmpty) {
                  _addTasbeeh(title, zikr, translation);
                  Navigator.pop(context);
                }
              },
              child: const Text('Done',style: TextStyle(color: Colors.green),),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
