import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import '../utils/app_themes.dart';

class DocumentsFACScreen extends StatefulWidget {
  const DocumentsFACScreen({super.key});

  @override
  State<DocumentsFACScreen> createState() => _DocumentsFACScreenState();
}

class _DocumentsFACScreenState extends State<DocumentsFACScreen> {
  final List<DocumentModel> documents = [
    DocumentModel(
      title: 'Règlement intérieur',
      description: 'Règlement intérieur de l\'APELMAFAC',
      fileName: 'reglement_interieur.pdf',
      icon: Icons.gavel,
    ),
    DocumentModel(
      title: 'Statuts de l\'association',
      description: 'Statuts officiels de l\'APELMAFAC',
      fileName: 'statuts.pdf',
      icon: Icons.description,
    ),
    DocumentModel(
      title: 'Guide du bénéficiaire',
      description: 'Guide pratique pour les bénéficiaires',
      fileName: 'guide_beneficiaire.pdf',
      icon: Icons.menu_book,
    ),
    DocumentModel(
      title: 'Formulaire d\'adhésion',
      description: 'Formulaire à remplir pour l\'adhésion',
      fileName: 'formulaire_adhesion.pdf',
      icon: Icons.assignment,
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
                      'Documents FAC',
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
                  child: _buildDocumentsList(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentsList(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];
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
              onTap: () => _openPDF(context, document),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        document.icon,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            document.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: customColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: customColors.textSecondary,
                      size: 20,
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

  void _openPDF(BuildContext context, DocumentModel document) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerScreen(
          title: document.title,
          fileName: document.fileName,
        ),
      ),
    );
  }
}

class PDFViewerScreen extends StatefulWidget {
  final String title;
  final String fileName;

  const PDFViewerScreen({
    super.key,
    required this.title,
    required this.fileName,
  });

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? localPath;
  bool isLoading = true;
  int totalPages = 0;
  int currentPage = 0;
  PDFViewController? pdfController;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      // Pour cette démo, nous allons créer un fichier PDF de test
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/${widget.fileName}');
      
      // Si le fichier n'existe pas, créer un PDF de démonstration
      if (!await file.exists()) {
        // Pour une vraie app, vous chargeriez le PDF depuis assets ou un serveur
        final data = await rootBundle.load('assets/documents/sample.pdf');
        await file.writeAsBytes(data.buffer.asUint8List());
      }
      
      setState(() {
        localPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      // En cas d'erreur, afficher un message
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors du chargement du document: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          if (totalPages > 0)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Page ${currentPage + 1} / $totalPages',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : localPath == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: customColors.textSecondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Document non disponible',
                        style: TextStyle(
                          fontSize: 18,
                          color: customColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Le document demandé n\'est pas disponible actuellement',
                        style: TextStyle(
                          fontSize: 14,
                          color: customColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : PDFView(
                  filePath: localPath!,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: false,
                  pageFling: true,
                  pageSnap: true,
                  defaultPage: 0,
                  fitPolicy: FitPolicy.BOTH,
                  preventLinkNavigation: false,
                  onRender: (pages) {
                    setState(() {
                      totalPages = pages ?? 0;
                    });
                  },
                  onError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erreur: $error'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  onPageError: (page, error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erreur page $page: $error'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  onViewCreated: (PDFViewController controller) {
                    setState(() {
                      pdfController = controller;
                    });
                  },
                  onPageChanged: (int? page, int? total) {
                    setState(() {
                      currentPage = page ?? 0;
                      totalPages = total ?? 0;
                    });
                  },
                ),
      floatingActionButton: localPath != null && totalPages > 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    pdfController?.setPage(0);
                  },
                  mini: true,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.first_page),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: () {
                    if (currentPage > 0) {
                      pdfController?.setPage(currentPage - 1);
                    }
                  },
                  mini: true,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.navigate_before),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: () {
                    if (currentPage < totalPages - 1) {
                      pdfController?.setPage(currentPage + 1);
                    }
                  },
                  mini: true,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.navigate_next),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: () {
                    pdfController?.setPage(totalPages - 1);
                  },
                  mini: true,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.last_page),
                ),
              ],
            )
          : null,
    );
  }
}

class DocumentModel {
  final String title;
  final String description;
  final String fileName;
  final IconData icon;

  DocumentModel({
    required this.title,
    required this.description,
    required this.fileName,
    required this.icon,
  });
}