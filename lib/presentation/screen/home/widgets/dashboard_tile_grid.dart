import 'package:flutter/material.dart';

class DashboardTileGrid extends StatelessWidget {
  const DashboardTileGrid({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
