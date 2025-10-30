import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/service_grid.dart';
import '../widgets/transaction_list.dart';
import '../widgets/theme_toggle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const TransactionsTab(),
    const ServicesTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1E88E5),
                      Color(0xFF1565C0),
                      Color(0xFF0D47A1),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bienvenue,',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Consumer<AppProvider>(
                        builder: (context, provider, child) {
                          return Text(
                            provider.userName.isEmpty ? 'Utilisateur' : provider.userName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BalanceCard(),
                  SizedBox(height: 30),
                  Text(
                    'Services rapides',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ServiceGrid(),
                  SizedBox(height: 30),
                  Text(
                    'Transactions récentes',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TransactionList(limit: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionsTab extends StatelessWidget {
  const TransactionsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: TransactionList(),
      ),
    );
  }
}

class ServicesTab extends StatelessWidget {
  const ServicesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: ServiceGrid(showAll: true),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            
            // Photo de profil et nom
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Consumer<AppProvider>(
              builder: (context, provider, child) {
                return Text(
                  provider.userName.isEmpty ? 'Utilisateur' : provider.userName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              '+225 XX XX XX XX',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Toggle de thème
            const ThemeToggle(),
            
            // Autres options du profil
            ThemeCard(
              title: 'Informations personnelles',
              subtitle: 'Gérer vos informations',
              icon: Icons.person_outline,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fonctionnalité bientôt disponible'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
            
            ThemeCard(
              title: 'Sécurité',
              subtitle: 'PIN et paramètres de sécurité',
              icon: Icons.security,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fonctionnalité bientôt disponible'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
            
            ThemeCard(
              title: 'Notifications',
              subtitle: 'Gérer les notifications',
              icon: Icons.notifications_outline,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fonctionnalité bientôt disponible'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
            
            ThemeCard(
              title: 'Aide et support',
              subtitle: 'Contactez notre équipe',
              icon: Icons.help_outline,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fonctionnalité bientôt disponible'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
            
            const SizedBox(height: 30),
            
            // Bouton de déconnexion
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Déconnexion'),
                      content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annuler'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Déconnexion réussie'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: const Text('Déconnecter'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Se déconnecter'),
              ),
            ),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}