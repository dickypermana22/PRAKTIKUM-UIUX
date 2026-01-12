import 'package:flutter/material.dart';
import 'package:praktikumuiux_7020230073/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:praktikumuiux_7020230073/providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Dicky Permana';
  String userEmail = 'dickypermana@email.com';
  bool notificationsEnabled = true;
  String selectedLanguage = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Color(0xFF000000) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Color(0xFF000000) : Colors.white,
        elevation: 0,
        title: Text(
          'Profil',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_rounded,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              _showSettingsBottomSheet(context, isDark);
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 100,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? Color(0xFF1C1C1E) : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFF0095F6), Color(0xFF00D4FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Color(0xFF0095F6).withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            _showImagePickerDialog(context, isDark);
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Color(0xFF0095F6),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark ? Color(0xFF1C1C1E) : Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    userEmail,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('12', 'Pesanan', isDark),
                      Container(
                        height: 40,
                        width: 1,
                        color: isDark ? Colors.grey[800] : Colors.grey[300],
                      ),
                      _buildStatItem('5', 'Wishlist', isDark),
                      Container(
                        height: 40,
                        width: 1,
                        color: isDark ? Colors.grey[800] : Colors.grey[300],
                      ),
                      _buildStatItem('8', 'Review', isDark),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),
            _buildMenuSection(
              'Akun',
              [
                _buildMenuItem(
                  icon: Icons.person_outline_rounded,
                  title: 'Edit Profil',
                  isDark: isDark,
                  onTap: () {
                    _showEditProfileDialog(context, isDark);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.location_on_outlined,
                  title: 'Alamat',
                  isDark: isDark,
                  onTap: () {
                    _showAddressDialog(context, isDark);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.payment_rounded,
                  title: 'Metode Pembayaran',
                  isDark: isDark,
                  onTap: () {
                    _showPaymentMethodDialog(context, isDark);
                  },
                ),
              ],
              isDark,
            ),

            SizedBox(height: 16),

            _buildMenuSection(
              'Pesanan',
              [
                _buildMenuItem(
                  icon: Icons.shopping_bag_outlined,
                  title: 'Riwayat Pesanan',
                  isDark: isDark,
                  badge: '3',
                  onTap: () {
                    _showOrderHistoryDialog(context, isDark);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.local_shipping_outlined,
                  title: 'Lacak Pesanan',
                  isDark: isDark,
                  onTap: () {
                    _showTrackOrderDialog(context, isDark);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.star_outline_rounded,
                  title: 'Review Produk',
                  isDark: isDark,
                  onTap: () {
                    _showReviewDialog(context, isDark);
                  },
                ),
              ],
              isDark,
            ),

            SizedBox(height: 16),

            _buildMenuSection(
              'Pengaturan',
              [
                _buildMenuItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifikasi',
                  isDark: isDark,
                  trailing: Switch(
                    value: notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                      _showSnackBar(
                        context,
                        value ? 'Notifikasi diaktifkan' : 'Notifikasi dinonaktifkan',
                        isDark,
                      );
                    },
                    activeColor: Color(0xFF0095F6),
                  ),
                  onTap: null,
                ),
                _buildMenuItem(
                  icon: Icons.language_rounded,
                  title: 'Bahasa',
                  subtitle: selectedLanguage,
                  isDark: isDark,
                  onTap: () {
                    _showLanguageDialog(context, isDark);
                  },
                ),
                _buildMenuItem(
                  icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  title: 'Tema',
                  subtitle: isDark ? 'Dark Mode' : 'Light Mode',
                  isDark: isDark,
                  trailing: Switch(
                    value: isDark,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                    activeColor: Color(0xFF0095F6),
                  ),
                  onTap: null,
                ),
              ],
              isDark,
            ),

            SizedBox(height: 16),

            _buildMenuSection(
              'Lainnya',
              [
                _buildMenuItem(
                  icon: Icons.help_outline_rounded,
                  title: 'Bantuan & Dukungan',
                  isDark: isDark,
                  onTap: () {
                    _showHelpDialog(context, isDark);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.info_outline_rounded,
                  title: 'Tentang Aplikasi',
                  subtitle: 'Versi 1.0.0',
                  isDark: isDark,
                  onTap: () {
                    _showAboutDialog(context, isDark);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.logout_rounded,
                  title: 'Keluar',
                  isDark: isDark,
                  textColor: Colors.red,
                  onTap: () {
                    _showLogoutDialog(context, isDark);
                  },
                ),
              ],
              isDark,
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, bool isDark) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF1C1C1E) : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                letterSpacing: 0.5,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    String? badge,
    required bool isDark,
    Color? textColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: textColor ?? (isDark ? Colors.white : Colors.black),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor ?? (isDark ? Colors.white : Colors.black),
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (badge != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF0095F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (trailing != null)
                trailing
              else if (onTap != null)
                Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                ),
            ],
          ),
        ),
      ),
    );
  }


  void _showEditProfileDialog(BuildContext context, bool isDark) {
    final nameController = TextEditingController(text: userName);
    final emailController = TextEditingController(text: userEmail);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Edit Profil',
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
              decoration: InputDecoration(
                labelText: 'Nama',
                labelStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF0095F6)),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF0095F6)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = nameController.text;
                userEmail = emailController.text;
              });
              Navigator.pop(ctx);
              _showSnackBar(context, 'Profil berhasil diperbarui', isDark);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0095F6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

 
  void _showImagePickerDialog(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ubah Foto Profil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.camera_alt, color: Color(0xFF0095F6)),
              title: Text('Kamera', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
              onTap: () {
                Navigator.pop(ctx);
                _showSnackBar(context, 'Fitur kamera akan segera tersedia', isDark);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Color(0xFF0095F6)),
              title: Text('Galeri', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
              onTap: () {
                Navigator.pop(ctx);
                _showSnackBar(context, 'Fitur galeri akan segera tersedia', isDark);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Alamat Saya', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAddressItem('Rumah', 'Jl. Contoh No. 123, Jakarta', true, isDark),
            SizedBox(height: 12),
            _buildAddressItem('Kantor', 'Jl. Sudirman No. 456, Jakarta', false, isDark),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showSnackBar(context, 'Fitur tambah alamat akan segera tersedia', isDark);
            },
            child: Text('Tambah Alamat', style: TextStyle(color: Color(0xFF0095F6))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Tutup', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressItem(String title, String address, bool isDefault, bool isDark) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: isDefault ? Border.all(color: Color(0xFF0095F6), width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              if (isDefault) ...[
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFF0095F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Utama',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 4),
          Text(
            address,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  
  void _showPaymentMethodDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Metode Pembayaran', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPaymentItem('💳 Kartu Kredit', '**** 1234', isDark),
            SizedBox(height: 12),
            _buildPaymentItem('🏦 Transfer Bank', 'BCA - 1234567890', isDark),
            SizedBox(height: 12),
            _buildPaymentItem('💰 E-Wallet', 'GoPay, OVO, Dana', isDark),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showSnackBar(context, 'Fitur tambah pembayaran akan segera tersedia', isDark);
            },
            child: Text('Tambah Metode', style: TextStyle(color: Color(0xFF0095F6))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Tutup', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(String title, String subtitle, bool isDark) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  
  void _showOrderHistoryDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Riwayat Pesanan', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildOrderItem('ORD-001', 'Selesai', 'Rp 250.000', '10 Jan 2026', isDark),
              _buildOrderItem('ORD-002', 'Dikirim', 'Rp 180.000', '08 Jan 2026', isDark),
              _buildOrderItem('ORD-003', 'Diproses', 'Rp 320.000', '05 Jan 2026', isDark),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Tutup', style: TextStyle(color: Color(0xFF0095F6))),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String orderId, String status, String amount, String date, bool isDark) {
    Color statusColor;
    if (status == 'Selesai') {
      statusColor = Colors.green;
    // ignore: curly_braces_in_flow_control_structures
    } else if (status == 'Dikirim') statusColor = Colors.blue;
    // ignore: curly_braces_in_flow_control_structures
    else statusColor = Colors.orange;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor, fontSize: 12),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: Color(0xFF0095F6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 
  void _showTrackOrderDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Lacak Pesanan', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_shipping, size: 80, color: Color(0xFF0095F6)),
            SizedBox(height: 16),
            Text(
              'Pesanan Anda sedang dalam perjalanan',
              textAlign: TextAlign.center,
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              'Estimasi tiba: Besok, 11 Jan 2026',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Tutup', style: TextStyle(color: Color(0xFF0095F6))),
          ),
        ],
      ),
    );
  }

 
  void _showReviewDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Review Produk', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Anda memiliki 3 produk yang menunggu review',
              textAlign: TextAlign.center,
              style: TextStyle(color: isDark ? Colors.grey[300] : Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Icon(Icons.rate_review, size: 60, color: Color(0xFF0095F6)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Nanti', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showSnackBar(context, 'Fitur review akan segera tersedia', isDark);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0095F6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Review Sekarang', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

 
  void _showLanguageDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Pilih Bahasa', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('Indonesia', isDark, ctx),
            _buildLanguageOption('English', isDark, ctx),
            _buildLanguageOption('日本語 (Japanese)', isDark, ctx),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language, bool isDark, BuildContext ctx) {
    bool isSelected = selectedLanguage == language;
    return ListTile(
      title: Text(
        language,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: Color(0xFF0095F6))
          : Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
        Navigator.pop(ctx);
        _showSnackBar(context, 'Bahasa diubah ke $language', isDark);
      },
    );
  }


  void _showHelpDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Bantuan & Dukungan', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.phone, color: Color(0xFF0095F6)),
              title: Text('Telepon', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
              subtitle: Text('0800-123-4567', style: TextStyle(color: Colors.grey)),
              contentPadding: EdgeInsets.zero,
            ),
            ListTile(
              leading: Icon(Icons.email, color: Color(0xFF0095F6)),
              title: Text('Email', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
              subtitle: Text('support@shoppractices.com', style: TextStyle(color: Colors.grey)),
              contentPadding: EdgeInsets.zero,
            ),
            ListTile(
              leading: Icon(Icons.chat, color: Color(0xFF0095F6)),
              title: Text('Live Chat', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
              subtitle: Text('Online 24/7', style: TextStyle(color: Colors.grey)),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Tutup', style: TextStyle(color: Color(0xFF0095F6))),
          ),
        ],
      ),
    );
  }

 
  void _showAboutDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Tentang ShopPractices', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_bag, size: 80, color: Color(0xFF0095F6)),
            SizedBox(height: 16),
            Text(
              'ShopPractices',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Versi 1.0.0',
              style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Text(
              'Platform belanja modern dengan berbagai pilihan produk berkualitas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Tutup', style: TextStyle(color: Color(0xFF0095F6))),
          ),
        ],
      ),
    );
  }

  void _showSettingsBottomSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengaturan Cepat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Notifikasi', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
                Navigator.pop(ctx);
                _showSnackBar(context, value ? 'Notifikasi diaktifkan' : 'Notifikasi dinonaktifkan', isDark);
              },
              activeColor: Color(0xFF0095F6),
            ),
            SwitchListTile(
              title: Text('Dark Mode', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
              value: isDark,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              },
              activeColor: Color(0xFF0095F6),
            ),
          ],
        ),
      ),
    );
  }


  void _showLogoutDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? Color(0xFF1C1C1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.logout_rounded, color: Colors.red, size: 28),
            SizedBox(width: 10),
            Text('Keluar', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
          ],
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar dari akun?',
          style: TextStyle(color: isDark ? Colors.grey[300] : Colors.grey[800]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Batal', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600])),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _showSnackBar(context, 'Berhasil keluar', isDark);
              
       
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> const LoginPage()));
            },
            child: Text('Keluar', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, bool isDark) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: Color(0xFF0095F6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.only(bottom: 100, left: 16, right: 16),
      ),
    );
  }
}