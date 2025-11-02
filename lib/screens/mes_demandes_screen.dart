import 'package:flutter/material.dart';
import '../utils/app_themes.dart';
import 'package:intl/intl.dart';

class MesDemandesScreen extends StatefulWidget {
  const MesDemandesScreen({super.key});

  @override
  State<MesDemandesScreen> createState() => _MesDemandesScreenState();
}

class _MesDemandesScreenState extends State<MesDemandesScreen> {
  final List<DemandeModel> demandes = [
    DemandeModel(
      id: 'DEM-2024-001',
      type: 'Assistance médicale',
      statut: DemandeStatut.enCours,
      date: DateTime.now().subtract(const Duration(days: 2)),
      montant: 150000,
      description: 'Demande d\'assistance pour consultation spécialisée',
    ),
    DemandeModel(
      id: 'DEM-2024-002',
      type: 'Aide funéraire',
      statut: DemandeStatut.approuvee,
      date: DateTime.now().subtract(const Duration(days: 10)),
      montant: 500000,
      description: 'Demande d\'aide suite au décès d\'un membre',
    ),
    DemandeModel(
      id: 'DEM-2024-003',
      type: 'Assistance sociale',
      statut: DemandeStatut.rejetee,
      date: DateTime.now().subtract(const Duration(days: 15)),
      montant: 100000,
      description: 'Demande d\'aide pour frais scolaires',
      motifRejet: 'Documents incomplets',
    ),
    DemandeModel(
      id: 'DEM-2024-004',
      type: 'Prêt solidaire',
      statut: DemandeStatut.enAttente,
      date: DateTime.now().subtract(const Duration(days: 1)),
      montant: 300000,
      description: 'Demande de prêt pour activité génératrice de revenus',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: customColors.gradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
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
                      'Mes Demandes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Corps principal
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildStatistiques(),
                      Expanded(
                        child: _buildDemandesList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNouvelleDemande(context),
        backgroundColor: customColors.success,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatistiques() {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    
    int total = demandes.length;
    int enCours = demandes.where((d) => d.statut == DemandeStatut.enCours).length;
    int approuvees = demandes.where((d) => d.statut == DemandeStatut.approuvee).length;
    int rejetees = demandes.where((d) => d.statut == DemandeStatut.rejetee).length;
    
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          _buildStatCard('Total', total, Theme.of(context).primaryColor),
          const SizedBox(width: 12),
          _buildStatCard('En cours', enCours, Theme.of(context).primaryColor.withValues(alpha: 0.7)),
          const SizedBox(width: 12),
          _buildStatCard('Approuvées', approuvees, customColors.success),
          const SizedBox(width: 12),
          _buildStatCard('Rejetées', rejetees, customColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemandesList() {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: demandes.length,
      itemBuilder: (context, index) {
        final demande = demandes[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showDemandeDetails(demande),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                demande.type,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                demande.id,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: customColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildStatutChip(demande.statut),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      demande.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: customColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (demande.motifRejet != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: customColors.textSecondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 16,
                              color: customColors.textSecondary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Motif: ${demande.motifRejet}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: customColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(demande.date),
                          style: TextStyle(
                            fontSize: 14,
                            color: customColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${demande.montant.toStringAsFixed(0)} FCFA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatutChip(DemandeStatut statut) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    Color backgroundColor;
    Color textColor;
    String text;
    IconData icon;

    switch (statut) {
      case DemandeStatut.enAttente:
        backgroundColor = customColors.textSecondary.withValues(alpha: 0.2);
        textColor = customColors.textSecondary;
        text = 'En attente';
        icon = Icons.schedule;
        break;
      case DemandeStatut.enCours:
        backgroundColor = Theme.of(context).primaryColor.withValues(alpha: 0.2);
        textColor = Theme.of(context).primaryColor;
        text = 'En cours';
        icon = Icons.timelapse;
        break;
      case DemandeStatut.approuvee:
        backgroundColor = customColors.success.withValues(alpha: 0.2);
        textColor = customColors.success;
        text = 'Approuvée';
        icon = Icons.check_circle;
        break;
      case DemandeStatut.rejetee:
        backgroundColor = customColors.textSecondary.withValues(alpha: 0.3);
        textColor = customColors.textSecondary;
        text = 'Rejetée';
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showDemandeDetails(DemandeModel demande) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DemandeDetailsSheet(demande: demande),
    );
  }

  void _showNouvelleDemande(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const NouvelleDemandeSheet(),
    );
  }
}

class DemandeDetailsSheet extends StatelessWidget {
  final DemandeModel demande;

  const DemandeDetailsSheet({super.key, required this.demande});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              'Détails de la demande',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Numéro', demande.id),
            _buildDetailRow('Type', demande.type),
            _buildDetailRow('Date', DateFormat('dd MMMM yyyy').format(demande.date)),
            _buildDetailRow('Montant', '${demande.montant.toStringAsFixed(0)} FCFA'),
            const SizedBox(height: 16),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              demande.description,
              style: TextStyle(
                fontSize: 14,
                color: customColors.textSecondary,
              ),
            ),
            if (demande.motifRejet != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: customColors.textSecondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Motif du rejet',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: customColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      demande.motifRejet!,
                      style: TextStyle(
                        fontSize: 14,
                        color: customColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class NouvelleDemandeSheet extends StatefulWidget {
  const NouvelleDemandeSheet({super.key});

  @override
  State<NouvelleDemandeSheet> createState() => _NouvelleDemandeSheetState();
}

class _NouvelleDemandeSheetState extends State<NouvelleDemandeSheet> {
  final _formKey = GlobalKey<FormState>();
  String? _typeDemande;
  final _montantController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _typesDemande = [
    'Assistance médicale',
    'Aide funéraire',
    'Assistance sociale',
    'Prêt solidaire',
    'Autres',
  ];

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 25,
        right: 25,
        top: 25,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Nouvelle demande',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _typeDemande,
                decoration: InputDecoration(
                  labelText: 'Type de demande',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _typesDemande.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _typeDemande = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner un type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _montantController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Montant demandé (FCFA)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un montant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description de la demande',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez décrire votre demande';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitDemande,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColors.success,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Soumettre la demande',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _submitDemande() {
    if (_formKey.currentState!.validate()) {
      // Ici vous pourriez envoyer la demande au serveur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Demande envoyée avec succès'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _montantController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

// Modèle de données
enum DemandeStatut { enAttente, enCours, approuvee, rejetee }

class DemandeModel {
  final String id;
  final String type;
  final DemandeStatut statut;
  final DateTime date;
  final double montant;
  final String description;
  final String? motifRejet;

  DemandeModel({
    required this.id,
    required this.type,
    required this.statut,
    required this.date,
    required this.montant,
    required this.description,
    this.motifRejet,
  });
}