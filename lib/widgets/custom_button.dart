import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';
import 'package:eventora/styles/app_spacing.dart';

class EventoraButton extends StatefulWidget {
  final String? label;
  final String? text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool loading;
  final bool isOutlined;
  final bool outlined;
  final bool fullWidth;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;

  const EventoraButton({
    Key? key,
    this.label,
    this.text,
    this.onPressed,
    this.isLoading = false,
    this.loading = false,
    this.isOutlined = false,
    this.outlined = false,
    this.fullWidth = true,
    this.isFullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.height = 52.0,
  }) : super(key: key);

  @override
  State<EventoraButton> createState() => _EventoraButtonState();
}

class _EventoraButtonState extends State<EventoraButton> with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final effectiveLabel = widget.text ?? widget.label ?? '';
    final effectiveIsLoading = widget.isLoading || widget.loading;
    final effectiveIsOutlined = widget.isOutlined || widget.outlined;
    final effectiveFullWidth = widget.isFullWidth || widget.fullWidth;
    final isDisabled = widget.onPressed == null || effectiveIsLoading;
    final defaultBgColor = widget.backgroundColor ?? AppColors.deepOnyx;
    final defaultTextColor = widget.textColor ?? Colors.white;

    Widget child = Container(
      height: widget.height,
      width: effectiveFullWidth ? double.infinity : null,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: effectiveIsOutlined ? Colors.transparent : defaultBgColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: effectiveIsOutlined
            ? Border.all(color: widget.backgroundColor ?? AppColors.outline, width: 1.5)
            : null,
      ),
      child: Center(
        child: effectiveIsLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                effectiveLabel,
                style: AppTypography.labelLG.copyWith(
                  color: effectiveIsOutlined ? AppColors.primary : defaultTextColor,
                ),
              ),
      ),
    );

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: isDisabled ? 0.5 : (_isPressed ? 0.9 : 1.0),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: _isPressed ? 0.98 : 1.0,
        curve: Curves.easeOut,
        child: GestureDetector(
          onTapDown: isDisabled ? null : (_) => setState(() => _isPressed = true),
          onTapUp: isDisabled ? null : (_) => setState(() => _isPressed = false),
          onTapCancel: isDisabled ? null : () => setState(() => _isPressed = false),
          onTap: isDisabled ? null : widget.onPressed,
          child: child,
        ),
      ),
    );
  }
}
