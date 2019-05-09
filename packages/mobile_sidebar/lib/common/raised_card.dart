import 'package:flutter/material.dart';

class RaisedCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap, onDelete, onLongPressed;
  final bool isEditing;
  final bool canRemove;

  RaisedCard(
    this.child, {
    this.onTap,
    this.onDelete,
    this.onLongPressed,
    this.isEditing = false,
    this.canRemove = true,
  });

  @override
  Widget build(BuildContext context) {
    final _brightness = Theme.of(context).brightness;
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            top: 0.0,
            child: _brightness == Brightness.dark
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey)),
                    child: InkWell(
                      onTap: isEditing
                          ? null
                          : onTap != null ? () => onTap() : () {},
                      onLongPress: isEditing ? null : onLongPressed,
                      child: child,
                    ),
                  )
                : Material(
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(12.0),
                    shadowColor: Color(0x802196F3),
                    child: InkWell(
                      onTap: isEditing
                          ? null
                          : onTap != null ? () => onTap() : () {},
                      onLongPress: isEditing ? null : onLongPressed,
                      child: child,
                    ),
                  ),
          ),
          Container(
            child: isEditing
                ? Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.redAccent,
                        ),
                        onPressed: canRemove ? onDelete : null,
                        iconSize: 50.0,
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class RaisedChild extends StatelessWidget {
  RaisedChild(this.child);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey)),
        child: child,
      );
    }
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: child,
    );
  }
}
