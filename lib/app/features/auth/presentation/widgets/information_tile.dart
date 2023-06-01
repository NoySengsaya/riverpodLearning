import 'package:flutter/material.dart';

class InformationTile extends StatelessWidget {
  const InformationTile({
    super.key,
    this.label,
    this.labelStyle,
    this.title,
    this.titleStyle,
    this.verified,
  });

  final String? label;

  final TextStyle? labelStyle;

  final String? title;

  final TextStyle? titleStyle;

  final bool? verified;

  @override
  Widget build(BuildContext context) {
    const TextStyle leadingTextStyle = TextStyle(
      fontSize: 18,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0.1)
          // color: Colors.teal,
          ),
      child: Row(
        children: [
          Text(
            '$label' ':',
            style: labelStyle ??
                leadingTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title ?? '',
              style: titleStyle ?? leadingTextStyle.copyWith(fontSize: 16),
            ),
          ),
          if (verified != null) ...[
            Icon(
              verified != null && verified == true
                  ? Icons.done_all_outlined
                  : Icons.done_outline,
              color: verified != null && verified == true
                  ? Colors.blueAccent
                  : Colors.grey,
            ),
          ],
        ],
      ),
    );
  }
}
