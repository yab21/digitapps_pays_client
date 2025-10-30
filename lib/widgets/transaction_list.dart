import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final int? limit;
  
  const TransactionList({Key? key, this.limit}) : super(key: key);

  final List<Transaction> transactions = const [
    Transaction(
      title: 'Recharge Mobile',
      subtitle: '+225 07 XX XX XX XX',
      amount: -5000,
      date: '10 Oct 2024',
      icon: Icons.phone_android,
      color: Color(0xFF4CAF50),
    ),
    Transaction(
      title: 'Transfert reçu',
      subtitle: 'De: Jean Dupont',
      amount: 15000,
      date: '09 Oct 2024',
      icon: Icons.arrow_downward,
      color: Color(0xFF2196F3),
    ),
    Transaction(
      title: 'Paiement Électricité',
      subtitle: 'CIE - Facture Oct',
      amount: -12500,
      date: '08 Oct 2024',
      icon: Icons.flash_on,
      color: Color(0xFFFFC107),
    ),
    Transaction(
      title: 'Transfert envoyé',
      subtitle: 'À: Marie Konan',
      amount: -8000,
      date: '07 Oct 2024',
      icon: Icons.arrow_upward,
      color: Color(0xFFFF5722),
    ),
    Transaction(
      title: 'Dépôt',
      subtitle: 'Via Agent',
      amount: 50000,
      date: '06 Oct 2024',
      icon: Icons.add_circle,
      color: Color(0xFF4CAF50),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final displayTransactions = limit != null 
        ? transactions.take(limit!).toList() 
        : transactions;
    
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayTransactions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final transaction = displayTransactions[index];
        return _buildTransactionTile(context, transaction);
      },
    );
  }

  Widget _buildTransactionTile(BuildContext context, Transaction transaction) {
    final formatter = NumberFormat.currency(locale: 'fr_FR', symbol: 'FCFA ');
    final isIncome = transaction.amount > 0;
    
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: transaction.color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              transaction.icon,
              color: transaction.color,
              size: 24,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  transaction.subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isIncome ? '+' : ''}${formatter.format(transaction.amount.abs())}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isIncome ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                transaction.date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Transaction {
  final String title;
  final String subtitle;
  final double amount;
  final String date;
  final IconData icon;
  final Color color;

  const Transaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.icon,
    required this.color,
  });
}