import 'package:flutter/material.dart';
 
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Apps Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
 
// ─────────────────────────────────────────────
// HOME SCREEN
// ─────────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF16213E),
        title: const Text(
          '🚀 Mini Apps',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pilih Aplikasi',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 40),
            _MenuCard(
              icon: '🛒',
              number: '1',
              title: 'Shopping Cart Sederhana',
              subtitle: 'Tambahkan/hapus item dari cart,\nhitung total harga secara real-time',
              color: const Color(0xFF0F3460),
              accentColor: const Color(0xFF6C63FF),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ShoppingCartScreen()),
              ),
            ),
            const SizedBox(height: 20),
            _MenuCard(
              icon: '🧠',
              number: '2',
              title: 'Quiz App',
              subtitle: 'Buat app quiz dengan 5 pertanyaan,\nstate skor, nomor soal, dan jawaban',
              color: const Color(0xFF0F3460),
              accentColor: const Color(0xFFE94560),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuizScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
class _MenuCard extends StatelessWidget {
  final String icon;
  final String number;
  final String title;
  final String subtitle;
  final Color color;
  final Color accentColor;
  final VoidCallback onTap;
 
  const _MenuCard({
    required this.icon,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.accentColor,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accentColor.withOpacity(0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accentColor.withOpacity(0.5)),
              ),
              child: Center(
                child: Text(
                  number,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$icon $title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: accentColor, size: 16),
          ],
        ),
      ),
    );
  }
}
 
// ─────────────────────────────────────────────
// FITUR 2: SHOPPING CART
// ─────────────────────────────────────────────
class CartItem {
  final String id;
  final String name;
  final double price;
  final String emoji;
  int quantity;
 
  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.emoji,
    this.quantity = 0,
  });
}
 
class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});
 
  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}
 
class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final List<CartItem> _products = [
    CartItem(id: '1', name: 'Laptop Gaming', price: 12500000, emoji: '💻'),
    CartItem(id: '2', name: 'Headphone Bluetooth', price: 350000, emoji: '🎧'),
    CartItem(id: '3', name: 'Mouse Wireless', price: 175000, emoji: '🖱️'),
    CartItem(id: '4', name: 'Keyboard Mekanikal', price: 650000, emoji: '⌨️'),
    CartItem(id: '5', name: 'Monitor 24 inch', price: 2800000, emoji: '🖥️'),
    CartItem(id: '6', name: 'Webcam HD', price: 450000, emoji: '📷'),
  ];
 
  double get _totalHarga => _products.fold(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );
 
  int get _totalItem =>
      _products.fold(0, (sum, item) => sum + item.quantity);
 
  String _formatRupiah(double amount) {
    final str = amount.toStringAsFixed(0);
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
      count++;
    }
    return 'Rp ${buffer.toString().split('').reversed.join()}';
  }
 
  void _tambah(CartItem item) => setState(() => item.quantity++);
  void _kurang(CartItem item) =>
      setState(() => item.quantity = (item.quantity - 1).clamp(0, 99));
  void _hapus(CartItem item) => setState(() => item.quantity = 0);
  void _kosongkanCart() => setState(() {
        for (var item in _products) {
          item.quantity = 0;
        }
      });
 
  @override
  Widget build(BuildContext context) {
    final cartItems = _products.where((p) => p.quantity > 0).toList();
 
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF16213E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const Text(
              '🛒 Shopping Cart',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            if (_totalItem > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$_totalItem',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]
          ],
        ),
        actions: [
          if (_totalItem > 0)
            TextButton(
              onPressed: _kosongkanCart,
              child: const Text(
                'Kosongkan',
                style: TextStyle(color: Color(0xFFE94560)),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Product List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = _products[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F3460),
                    borderRadius: BorderRadius.circular(16),
                    border: item.quantity > 0
                        ? Border.all(
                            color: const Color(0xFF6C63FF).withOpacity(0.6),
                            width: 1.5,
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      // Emoji & Info
                      Text(item.emoji, style: const TextStyle(fontSize: 36)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatRupiah(item.price),
                              style: const TextStyle(
                                color: Color(0xFF6C63FF),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (item.quantity > 0)
                              Text(
                                'Subtotal: ${_formatRupiah(item.price * item.quantity)}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 11,
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Quantity Control
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.quantity > 0)
                            GestureDetector(
                              onLongPress: () => _hapus(item),
                              child: _QtyButton(
                                icon: item.quantity == 1
                                    ? Icons.delete_outline
                                    : Icons.remove,
                                color: item.quantity == 1
                                    ? const Color(0xFFE94560)
                                    : Colors.white60,
                                onTap: () => _kurang(item),
                              ),
                            ),
                          if (item.quantity > 0)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          _QtyButton(
                            icon: Icons.add,
                            color: const Color(0xFF6C63FF),
                            onTap: () => _tambah(item),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
 
          // Cart Summary
          if (_totalItem > 0)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF16213E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Item summary
                  ...cartItems.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${item.emoji} ${item.name} x${item.quantity}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            _formatRupiah(item.price * item.quantity),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white24, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total ($_totalItem item)',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _formatRupiah(_totalHarga),
                        style: const TextStyle(
                          color: Color(0xFF6C63FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: const Color(0xFF0F3460),
                            title: const Text(
                              '✅ Pesanan Dikonfirmasi!',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: Text(
                              'Total pembayaran: ${_formatRupiah(_totalHarga)}',
                              style:
                                  const TextStyle(color: Colors.white70),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _kosongkanCart();
                                },
                                child: const Text(
                                  'Selesai',
                                  style: TextStyle(color: Color(0xFF6C63FF)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Checkout Sekarang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF16213E),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined,
                      color: Colors.white38, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Cart masih kosong — tambahkan item!',
                    style: TextStyle(color: Colors.white.withOpacity(0.4)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
 
class _QtyButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
 
  const _QtyButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}
 
// ─────────────────────────────────────────────
// FITUR 3: QUIZ APP
// ─────────────────────────────────────────────
class QuizQuestion {
  final String pertanyaan;
  final List<String> pilihan;
  final int jawabanBenar;
 
  const QuizQuestion({
    required this.pertanyaan,
    required this.pilihan,
    required this.jawabanBenar,
  });
}
 
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
 
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}
 
class _QuizScreenState extends State<QuizScreen> {
  final List<QuizQuestion> _soal = [
    const QuizQuestion(
      pertanyaan: 'Apa kepanjangan dari "HTML"?',
      pilihan: [
        'HyperText Markup Language',
        'High Transfer Markup Language',
        'HyperText Modern Language',
        'Home Text Markup Language',
      ],
      jawabanBenar: 0,
    ),
    const QuizQuestion(
      pertanyaan: 'Bahasa pemrograman apa yang digunakan Flutter?',
      pilihan: ['JavaScript', 'Kotlin', 'Dart', 'Swift'],
      jawabanBenar: 2,
    ),
    const QuizQuestion(
      pertanyaan: 'Widget Flutter yang digunakan untuk menampilkan teks?',
      pilihan: ['Container', 'Text', 'Row', 'Column'],
      jawabanBenar: 1,
    ),
    const QuizQuestion(
      pertanyaan: 'Apa fungsi "setState()" dalam Flutter?',
      pilihan: [
        'Membuat widget baru',
        'Menghapus widget',
        'Memperbarui UI saat state berubah',
        'Menginisialisasi aplikasi',
      ],
      jawabanBenar: 2,
    ),
    const QuizQuestion(
      pertanyaan: 'Singkatan "SDK" dalam konteks Flutter adalah?',
      pilihan: [
        'Software Development Kit',
        'System Design Kit',
        'Standard Developer Keyboard',
        'Swift Development Kit',
      ],
      jawabanBenar: 0,
    ),
  ];
 
  int _soalSekarang = 0;
  int _skor = 0;
  int? _pilihanDipilih;
  bool _sudahJawab = false;
  bool _selesai = false;
 
  void _pilihJawaban(int index) {
    if (_sudahJawab) return;
    setState(() {
      _pilihanDipilih = index;
      _sudahJawab = true;
      if (index == _soal[_soalSekarang].jawabanBenar) {
        _skor++;
      }
    });
  }
 
  void _soalBerikutnya() {
    if (_soalSekarang < _soal.length - 1) {
      setState(() {
        _soalSekarang++;
        _pilihanDipilih = null;
        _sudahJawab = false;
      });
    } else {
      setState(() => _selesai = true);
    }
  }
 
  void _ulangiQuiz() {
    setState(() {
      _soalSekarang = 0;
      _skor = 0;
      _pilihanDipilih = null;
      _sudahJawab = false;
      _selesai = false;
    });
  }
 
  String get _emoji {
    final persen = (_skor / _soal.length) * 100;
    if (persen == 100) return '🏆';
    if (persen >= 80) return '🎉';
    if (persen >= 60) return '👍';
    if (persen >= 40) return '😅';
    return '😢';
  }
 
  String get _komentar {
    final persen = (_skor / _soal.length) * 100;
    if (persen == 100) return 'Sempurna! Kamu luar biasa!';
    if (persen >= 80) return 'Bagus sekali! Hampir sempurna!';
    if (persen >= 60) return 'Cukup baik! Terus belajar!';
    if (persen >= 40) return 'Lumayan, tapi masih bisa lebih baik!';
    return 'Jangan menyerah, coba lagi!';
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF16213E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '🧠 Quiz App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          if (!_selesai)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE94560).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFFE94560).withOpacity(0.5)),
                  ),
                  child: Text(
                    'Skor: $_skor',
                    style: const TextStyle(
                      color: Color(0xFFE94560),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _selesai ? _buildHasilQuiz() : _buildSoal(),
    );
  }
 
  Widget _buildSoal() {
    final soal = _soal[_soalSekarang];
 
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress bar
          Row(
            children: List.generate(
              _soal.length,
              (i) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: i <= _soalSekarang
                        ? const Color(0xFFE94560)
                        : Colors.white12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Soal ${_soalSekarang + 1} dari ${_soal.length}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),
 
          // Pertanyaan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF0F3460),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFE94560).withOpacity(0.3),
              ),
            ),
            child: Text(
              soal.pertanyaan,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 24),
 
          // Pilihan Jawaban
          ...List.generate(soal.pilihan.length, (index) {
            Color bgColor = const Color(0xFF0F3460);
            Color borderColor = Colors.white12;
            Color textColor = Colors.white;
            IconData? trailingIcon;
            Color? iconColor;
 
            if (_sudahJawab) {
              if (index == soal.jawabanBenar) {
                bgColor = Colors.green.withOpacity(0.2);
                borderColor = Colors.green;
                textColor = Colors.green.shade300;
                trailingIcon = Icons.check_circle;
                iconColor = Colors.green;
              } else if (index == _pilihanDipilih &&
                  index != soal.jawabanBenar) {
                bgColor = const Color(0xFFE94560).withOpacity(0.2);
                borderColor = const Color(0xFFE94560);
                textColor = const Color(0xFFE94560);
                trailingIcon = Icons.cancel;
                iconColor = const Color(0xFFE94560);
              }
            } else if (_pilihanDipilih == index) {
              bgColor = const Color(0xFF6C63FF).withOpacity(0.3);
              borderColor = const Color(0xFF6C63FF);
            }
 
            return GestureDetector(
              onTap: () => _pilihJawaban(index),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: borderColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: borderColor.withOpacity(0.5)),
                      ),
                      child: Center(
                        child: Text(
                          ['A', 'B', 'C', 'D'][index],
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        soal.pilihan[index],
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    if (trailingIcon != null)
                      Icon(trailingIcon, color: iconColor, size: 22),
                  ],
                ),
              ),
            );
          }),
 
          const Spacer(),
 
          // Tombol Lanjut
          if (_sudahJawab)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _soalBerikutnya,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE94560),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  _soalSekarang < _soal.length - 1
                      ? 'Soal Berikutnya →'
                      : 'Lihat Hasil',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
 
  Widget _buildHasilQuiz() {
    final persen = (_skor / _soal.length * 100).round();
 
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_emoji, style: const TextStyle(fontSize: 80)),
            const SizedBox(height: 24),
            const Text(
              'Quiz Selesai!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _komentar,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 48),
              decoration: BoxDecoration(
                color: const Color(0xFF0F3460),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFE94560).withOpacity(0.4),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '$_skor / ${_soal.length}',
                    style: const TextStyle(
                      color: Color(0xFFE94560),
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$persen% Benar',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _ulangiQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE94560),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  '🔄 Ulangi Quiz',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Kembali ke Menu',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}