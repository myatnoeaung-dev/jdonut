import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// One highlighted (optionally tappable) part of a [HighlightedText].
class HighlightSpan {
  const HighlightSpan(this.text, {this.onTap});

  final String text;
  final VoidCallback? onTap;
}

/// Renders a localized message with some placeholders highlighted, e.g. the
/// "Terms of Use" links or the pink resend countdown.
///
/// Build [message] by passing [HighlightedText.token] for each placeholder, so
/// translations keep their own word order:
/// `l10n.termsNotice(HighlightedText.token(0), HighlightedText.token(1))`.
class HighlightedText extends StatefulWidget {
  const HighlightedText({
    super.key,
    required this.message,
    required this.highlights,
    this.style,
    this.highlightStyle,
    this.textAlign = TextAlign.start,
  });

  final String message;
  final List<HighlightSpan> highlights;
  final TextStyle? style;
  final TextStyle? highlightStyle;
  final TextAlign textAlign;

  static String token(int index) => '$_tokenStart$index$_tokenEnd';

  static const String _tokenStart = '\u{E000}';
  static const String _tokenEnd = '\u{E001}';
  static final RegExp _tokenPattern = RegExp('$_tokenStart(\\d+)$_tokenEnd');

  @override
  State<HighlightedText> createState() => _HighlightedTextState();
}

class _HighlightedTextState extends State<HighlightedText> {
  List<TapGestureRecognizer?> _recognizers = const [];

  @override
  void initState() {
    super.initState();
    _createRecognizers();
  }

  @override
  void didUpdateWidget(HighlightedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disposeRecognizers();
    _createRecognizers();
  }

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  void _createRecognizers() {
    _recognizers = [
      for (final highlight in widget.highlights)
        highlight.onTap == null ? null : (TapGestureRecognizer()..onTap = highlight.onTap),
    ];
  }

  void _disposeRecognizers() {
    for (final recognizer in _recognizers) {
      recognizer?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(style: widget.style, children: _buildSpans()),
      textAlign: widget.textAlign,
    );
  }

  List<InlineSpan> _buildSpans() {
    final spans = <InlineSpan>[];
    var cursor = 0;
    for (final match in HighlightedText._tokenPattern.allMatches(widget.message)) {
      spans.add(TextSpan(text: widget.message.substring(cursor, match.start)));
      spans.add(_highlightSpan(int.parse(match.group(1)!)));
      cursor = match.end;
    }
    spans.add(TextSpan(text: widget.message.substring(cursor)));
    return spans;
  }

  TextSpan _highlightSpan(int index) {
    if (index >= widget.highlights.length) return const TextSpan();
    return TextSpan(text: widget.highlights[index].text, style: widget.highlightStyle, recognizer: _recognizers[index]);
  }
}
