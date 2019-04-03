

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SizableDrawer extends StatelessWidget{

  final double elevation;
  final double widthPercent;
  final Widget child;
  final String semanticLabel;

  const SizableDrawer(
      {Key key,
        this.elevation = 16.0,
        this.child,
        this.semanticLabel,
        this.widthPercent = 0.7})
      : assert(elevation != null && elevation >= 0.0),
        assert(
        widthPercent != null && widthPercent < 1.0 && widthPercent > 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String label = semanticLabel;
//    switch(defaultTargetPlatform){
//      case TargetPlatform.android:
//    }
    label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;

    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(
          width:MediaQuery.of(context).size.width * widthPercent),
        child: Material(
          elevation: elevation,
          child: child,
        ),
      ),

    );
  }

}


