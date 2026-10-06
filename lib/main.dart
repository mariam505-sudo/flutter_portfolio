import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'data/portfolio_data.dart';
import 'screens/portfolio_screen.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool _isDark = true; // الثيم الداكن هو الافتراضي

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${PortfolioData.name} — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: PortfolioScreen(isDark: _isDark, onToggleTheme: _toggleTheme),
    );
  }
}
