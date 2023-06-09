import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.backgroundColor,
    required this.actions,
    required this.title,
    required this.content,
    this.titleTextStyle,
    this.contentTextStyle,
    this.titleTextAlign,
    this.contentTextAlign,
  });

  final Color backgroundColor;

  final String title;

  final String content;

  final List<CleanDialogActionButtons> actions;

  final TextAlign? titleTextAlign;

  final TextAlign? contentTextAlign;

  final TextStyle? titleTextStyle;

  final TextStyle? contentTextStyle;

  List<CleanDialogActionButtons> _buildStyledActionButtons() => actions
      .map((e) => e.copyWith(textColor: e.textColor ?? backgroundColor))
      .toList();

  @override
  Widget build(BuildContext context) {
    final List<CleanDialogActionButtons> actions = _buildStyledActionButtons();

    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        textAlign: titleTextAlign ?? TextAlign.center,
                        style: titleTextStyle ??
                            const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                    ),
                    Text(
                      content,
                      textAlign: contentTextAlign ?? TextAlign.center,
                      style: contentTextStyle ?? const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => actions.elementAt(index),
              separatorBuilder: (context, _) => Divider(
                color: backgroundColor.withOpacity(.5),
                height: 1,
              ),
              itemCount: actions.length,
            )
          ],
        ),
      ),
    );
  }
}

class CleanDialogActionButtons extends StatelessWidget {
  const CleanDialogActionButtons(
      {super.key,
      required this.actionTitle,
      required this.onPressed,
      this.textColor});

  final String actionTitle;

  final VoidCallback onPressed;

  final Color? textColor;

  CleanDialogActionButtons copyWith({
    String? actionTitle,
    VoidCallback? onPressed,
    Color? textColor,
  }) =>
      CleanDialogActionButtons(
        actionTitle: actionTitle ?? this.actionTitle,
        onPressed: onPressed ?? this.onPressed,
        textColor: textColor ?? this.textColor,
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: textColor?.withOpacity(.1),
      highlightColor: textColor?.withOpacity(.2),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          actionTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: textColor ?? Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
