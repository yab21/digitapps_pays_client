import 'package:flutter/material.dart';

class BeneficiairesScreen extends StatefulWidget {
  const BeneficiairesScreen({super.key});

  @override
  State<BeneficiairesScreen> createState() => _BeneficiairesScreenState();
}

class _BeneficiairesScreenState extends State<BeneficiairesScreen> {
  final List<Map<String, dynamic>> _beneficiaires = [
    {
      'nom': 'KONE BINTA EPSE ZOUEDET',
      'code': '0304FA0076',
      'dateNaissance': '28-08-1961',
    },
    {
      'nom': 'KONE RAMATOU',
      'code': '0304FA0079',
      'dateNaissance': '22-08-1971',
    },
    {
      'nom': 'ZOUEDET AMY ESTELLE EPSE DOUMBIA',
      'code': '0304FA0075',
      'dateNaissance': '16-07-1984',
    },
    {
      'nom': 'DIOROU LOU VORENAN JEANNE',
      'code': '0304FA0078',
      'dateNaissance': '09-05-1954',
    },
    {
      'nom': 'DOUMBIA MORY FERE',
      'code': '1203FA0006',
      'dateNaissance': '26-10-1976',
    },
    {
      'nom': 'MAMADOU DOUMBIA',
      'code': '0304FA0077',
      'dateNaissance': '09-08-1952',
    },
    {
      'nom': 'BOUBAKARY DOUMBIA',
      'code': '0106FA0345',
      'dateNaissance': '01-01-1960',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF006BA6),
              Color(0xFF004A7C),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header avec bouton retour
              Container(
                padding: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 22,
                        ),
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Mes bénéficiaires',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Corps principal avec fond blanc
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Message d'information
                      Container(
                        margin: const EdgeInsets.all(25),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xFF006BA6).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xFF006BA6).withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          'Pour déclarer un décès veuillez cliquer sur le nom du bénéficiaire.',
                          style: TextStyle(
                            color: Color(0xFF006BA6),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      
                      // Liste des bénéficiaires
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          itemCount: _beneficiaires.length,
                          itemBuilder: (context, index) {
                            final beneficiaire = _beneficiaires[index];
                            return _buildBeneficiaireItem(
                              beneficiaire['nom'],
                              beneficiaire['code'],
                              beneficiaire['dateNaissance'],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBeneficiaireItem(String nom, String code, String dateNaissance) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BeneficiaireDetailsScreen(
                  nom: nom,
                  code: code,
                  dateNaissance: dateNaissance,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.05),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF006BA6).withValues(alpha: 0.2),
                        const Color(0xFF006BA6).withValues(alpha: 0.1),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF006BA6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nom,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        code,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF006BA6),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  dateNaissance,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF006BA6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BeneficiaireDetailsScreen extends StatelessWidget {
  final String nom;
  final String code;
  final String dateNaissance;

  const BeneficiaireDetailsScreen({
    super.key,
    required this.nom,
    required this.code,
    required this.dateNaissance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF006BA6),
              Color(0xFF004A7C),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header avec bouton retour
              Container(
                padding: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 22,
                        ),
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Informations bénéficiaire',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Corps principal avec fond blanc
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(25),
                    children: [
                      // Profil du bénéficiaire
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF006BA6).withValues(alpha: 0.05),
                              const Color(0xFF006BA6).withValues(alpha: 0.02),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF006BA6).withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF006BA6).withValues(alpha: 0.2),
                                    const Color(0xFF006BA6).withValues(alpha: 0.1),
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Color(0xFF006BA6),
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nom,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    code,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF006BA6),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Informations détaillées
                      _buildInfoItem('Ville de résidence :', 'Bouaké'),
                      _buildInfoItem('Lieu de naissance :', 'Toumodi'),
                      _buildInfoItem('Option :', 'Sérénité Plus'),
                      _buildInfoItem('Date de naissance :', dateNaissance),
                      _buildInfoItem('Sexe :', 'F'),
                      _buildInfoItem('Date de fin de carence :', '29-10-2025'),
                      
                      const SizedBox(height: 20),
                      
                      // Statut
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Statut :',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF4CAF50),
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              'Actif',
                              style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF006BA6),
            ),
          ),
        ],
      ),
    );
  }
}

class DeclarationDecesScreen extends StatefulWidget {
  const DeclarationDecesScreen({super.key});

  @override
  State<DeclarationDecesScreen> createState() => _DeclarationDecesScreenState();
}

class _DeclarationDecesScreenState extends State<DeclarationDecesScreen> {
  int _currentStep = 0;
  
  final _nomController = TextEditingController(text: 'DOUMBIA');
  final _prenomsController = TextEditingController(text: 'MORY FERE');
  final _contactController = TextEditingController(text: '0707367790');
  final _codeFamilleController = TextEditingController(text: 'C000');

  @override
  void dispose() {
    _nomController.dispose();
    _prenomsController.dispose();
    _contactController.dispose();
    _codeFamilleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF006BA6),
              Color(0xFF004A7C),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header avec bouton retour
              Container(
                padding: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 22,
                        ),
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Déclaration des décès',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Corps principal avec fond blanc
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Color(0xFF006BA6),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stepper(
                            currentStep: _currentStep,
                            onStepTapped: (step) {
                              setState(() {
                                _currentStep = step;
                              });
                            },
                            controlsBuilder: (context, details) {
                              if (details.stepIndex == 0) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: ElevatedButton(
                                    onPressed: details.onStepContinue,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4CAF50),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                    ),
                                    child: const Text(
                                      'SUIVANT',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                      steps: [
                        Step(
                          title: const Text(
                            'Souscripteur',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF006BA6),
                            ),
                          ),
                          content: Column(
                            children: [
                              _buildTextField('Nom', _nomController),
                              const SizedBox(height: 15),
                              _buildTextField('Prénoms', _prenomsController),
                              const SizedBox(height: 15),
                              _buildTextField('Contact', _contactController),
                              const SizedBox(height: 15),
                              _buildTextField('Code famille', _codeFamilleController),
                            ],
                          ),
                          isActive: _currentStep >= 0,
                        ),
                        Step(
                          title: const Text(
                            'Défunt',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                          ),
                          content: const Text('Étape 2 - Informations du défunt'),
                          isActive: _currentStep >= 1,
                        ),
                        Step(
                          title: const Text(
                            'Morgue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                          ),
                          content: const Text('Étape 3 - Informations de la morgue'),
                          isActive: _currentStep >= 2,
                        ),
                        Step(
                          title: const Text(
                            'Funérailles',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                          ),
                          content: const Text('Étape 4 - Informations des funérailles'),
                          isActive: _currentStep >= 3,
                        ),
                        Step(
                          title: const Text(
                            'Pièces jointes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                          ),
                          content: const Text('Étape 5 - Documents à joindre'),
                          isActive: _currentStep >= 4,
                        ),
                            ],
                          ),
                        ),
                        
                        // Bouton Je déclare un décès
                        Container(
                          margin: const EdgeInsets.all(25),
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF4CAF50),
                                Color(0xFF45A049),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Action pour déclarer un décès
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Déclaration de décès en cours...'),
                                  backgroundColor: Color(0xFF4CAF50),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'JE DÉCLARE UN DÉCÈS',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF006BA6), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}