import 'package:flutter/material.dart';

class ServiceGrid extends StatelessWidget {
  final bool showAll;
  
  const ServiceGrid({Key? key, this.showAll = false}) : super(key: key);

  final List<ServiceItem> services = const [
    ServiceItem(
      icon: Icons.phone_android,
      title: 'Recharge',
      color: Color(0xFF4CAF50),
    ),
    ServiceItem(
      icon: Icons.flash_on,
      title: 'Electricité',
      color: Color(0xFFFFC107),
    ),
    ServiceItem(
      icon: Icons.water_drop,
      title: 'Eau',
      color: Color(0xFF2196F3),
    ),
    ServiceItem(
      icon: Icons.tv,
      title: 'TV',
      color: Color(0xFF9C27B0),
    ),
    ServiceItem(
      icon: Icons.wifi,
      title: 'Internet',
      color: Color(0xFFFF5722),
    ),
    ServiceItem(
      icon: Icons.school,
      title: 'École',
      color: Color(0xFF795548),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final displayServices = showAll ? services : services.take(4).toList();
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: displayServices.length,
      itemBuilder: (context, index) {
        final service = displayServices[index];
        return _buildServiceCard(context, service);
      },
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceItem service) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Service ${service.title} sélectionné'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: service.color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                service.icon,
                color: service.color,
                size: 28,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              service.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceItem {
  final IconData icon;
  final String title;
  final Color color;

  const ServiceItem({
    required this.icon,
    required this.title,
    required this.color,
  });
}