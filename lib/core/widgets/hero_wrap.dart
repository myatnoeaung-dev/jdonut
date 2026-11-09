import 'package:flutter/widgets.dart';

/// [child] inside a [Hero] with [tag], or unchanged when there's no tag.
Widget heroWrap(Object? tag, Widget child) => tag == null ? child : Hero(tag: tag, child: child);
