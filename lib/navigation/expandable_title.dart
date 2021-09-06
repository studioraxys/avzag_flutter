import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableTitle extends StatelessWidget {
  final Widget child;
  const ExpandableTitle(this.child);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.5,
              child: CircleAvatar(
                backgroundImage: AssetImage('icon.png'),
                radius: 12,
              ),
            ),
            SizedBox(width: 32),
            Text(
              'Ævzag',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      theme: ExpandableThemeData(
        expandIcon: Icons.expand_more_outlined,
        collapseIcon: Icons.expand_more_outlined,
        iconPadding: const EdgeInsets.only(
          right: 20,
          top: 16,
        ),
        iconColor: Theme.of(context).iconTheme.color,
      ),
      collapsed: Offstage(),
      expanded: child,
    );
  }
}
