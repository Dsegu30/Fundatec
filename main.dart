import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const TecApp());

class TecApp extends StatelessWidget {
  const TecApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TEC Móvil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF07172C),
          brightness: Brightness.light,
        ),
      ),
      home: const TecHomeScreen(),
    );
  }
}

class TecHomeScreen extends StatefulWidget {
  const TecHomeScreen({super.key});

  @override
  State<TecHomeScreen> createState() => _TecHomeScreenState();
}

class _TecHomeScreenState extends State<TecHomeScreen> {
  static const Color navy = Color(0xFF07172C);
  static const Color blue = Color(0xFF0A2342);
  static const Color purple = Color(0xFF2C285D);
  static const Color red = Color(0xFFD32F2F);
  static const Color page = Color(0xFFF4F6F9);

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: page,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            final isWide = width >= 760;
            final isLandscapePhone = width > height && width < 760;
            final contentMaxWidth = isWide ? 1100.0 : (isLandscapePhone ? 760.0 : 480.0);
            final sideBySideCards = width >= 600;

            return Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: math.min(width, contentMaxWidth),
                      child: CustomScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        slivers: [
                          SliverToBoxAdapter(
                            child: _buildHeader(
                              compact: isLandscapePhone,
                              wide: isWide,
                            ),
                          ),
                          SliverPadding(
                            padding: EdgeInsets.fromLTRB(
                              isWide ? 24 : 16,
                              16,
                              isWide ? 24 : 16,
                              20,
                            ),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  _buildMainCards(
                                    wide: sideBySideCards,
                                    compact: isLandscapePhone,
                                  ),
                                  const SizedBox(height: 18),
                                  _buildQuickAccess(wide: isWide),
                                  const SizedBox(height: 22),
                                  _buildQuickLinks(),
                                  const SizedBox(height: 18),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildBottomNavigation(
                  wide: isWide,
                  compact: isLandscapePhone,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader({required bool compact, required bool wide}) {
    final horizontal = wide ? 28.0 : 20.0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontal,
        compact ? 12 : 16,
        horizontal,
        compact ? 20 : 26,
      ),
      decoration: const BoxDecoration(
        color: navy,
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?auto=format&fit=crop&w=1400&q=85',
          ),
          fit: BoxFit.cover,
          opacity: 0.25,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu, color: Colors.white, size: 26),
              const Spacer(),
              const Text(
                'TEC',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Georgia',
                  fontSize: 30,
                  letterSpacing: 1.2,
                ),
              ),
              Container(
                width: 1.5,
                height: 28,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: red,
              ),
              const Text(
                'Tecnológico\nde Costa Rica',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Georgia',
                  fontSize: 11,
                  height: 1.05,
                ),
              ),
              const Spacer(),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 25,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: compact ? 18 : 26),
          Text(
            'Hola, Daniel',
            style: TextStyle(
              color: Colors.white,
              fontSize: wide ? 26 : 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tu formación, un mismo camino',
            style: TextStyle(color: Colors.white70, fontSize: 12.5),
          ),
          const SizedBox(height: 2),
          const Text(
            'Escuela de Ingeniería en Producción Industrial',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCards({required bool wide, required bool compact}) {
    final cards = [
      _MainCardData(
        color: blue,
        icon: Icons.verified_outlined,
        title: 'Técnico en\nCalidad',
        description:
            'Desarrolla tus habilidades en control, mejora y aseguramiento de la calidad.',
        imageUrl:
            'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&w=800&q=85',
      ),
      _MainCardData(
        color: purple,
        icon: Icons.school_outlined,
        title: 'Posgrados\nIndustrial',
        description:
            'Lleva tu conocimiento al siguiente nivel con programas de posgrado especializados.',
        imageUrl:
            'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=800&q=85',
      ),
    ];

    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            if (i > 0) const SizedBox(width: 16),
            Expanded(
              child: _buildProCard(
                data: cards[i],
                height: 150,
                wide: true,
              ),
            ),
          ],
        ],
      );
    }

    return Column(
      children: [
        _buildProCard(data: cards[0], height: compact ? 116 : 124),
        const SizedBox(height: 12),
        _buildProCard(data: cards[1], height: compact ? 116 : 124),
      ],
    );
  }

  Widget _buildProCard({
    required _MainCardData data,
    required double height,
    bool wide = false,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: data.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: wide ? 180 : 150,
                height: height,
                child: Image.network(
                  data.imageUrl,
                  fit: BoxFit.cover,
                  color: data.color.withOpacity(0.65),
                  colorBlendMode: BlendMode.hardLight,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 14, 28),
              child: Row(
                children: [
                  Icon(data.icon, color: Colors.white, size: wide ? 42 : 38),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 330),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            data.description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.86),
                              fontSize: 10.5,
                              height: 1.2,
                            ),
                            maxLines: wide ? 3 : 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 16,
              bottom: 10,
              child: Icon(Icons.arrow_forward, color: Colors.white, size: 17),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccess({required bool wide}) {
    const items = [
      _QuickItem(Icons.calendar_today_outlined, 'Calendario'),
      _QuickItem(Icons.article_outlined, 'Noticias'),
      _QuickItem(Icons.menu_book_outlined, 'Recursos'),
      _QuickItem(Icons.person_outline, 'Mi perfil'),
    ];

    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: wide ? 88 : 76,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(items[i].icon, color: navy, size: 24),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      items[i].label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildQuickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Enlaces rápidos',
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: navy,
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Row(
                children: [
                  Text('Ver todo', style: TextStyle(fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 13),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(9),
                  child: Icon(Icons.school, color: Colors.white, size: 20),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Conoce más sobre la Escuela\nde Ingeniería en Producción Industrial',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: navy,
                    height: 1.2,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward, color: navy, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation({
    required bool wide,
    required bool compact,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: wide ? 1100 : 480),
          child: NavigationBar(
            height: compact ? 58 : 68,
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              setState(() => selectedIndex = index);
            },
            backgroundColor: Colors.white,
            indicatorColor: const Color(0xFFE8EDF3),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Inicio',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Calendario',
              ),
              NavigationDestination(
                icon: Icon(Icons.notifications_none),
                label: 'Notificaciones',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainCardData {
  final Color color;
  final IconData icon;
  final String title;
  final String description;
  final String imageUrl;

  const _MainCardData({
    required this.color,
    required this.icon,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class _QuickItem {
  final IconData icon;
  final String label;

  const _QuickItem(this.icon, this.label);
}
