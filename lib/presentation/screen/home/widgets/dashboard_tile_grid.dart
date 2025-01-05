import 'package:flutter/material.dart';

import '../../../widgets/styling/bordered_container.dart';

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
        child: BorderedContainer(
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
