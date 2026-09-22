import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';

class EventoraSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const EventoraSearchBar({
    Key? key,
    this.controller,
    this.hint = 'Search services...',
    this.onChanged,
    this.onTap,
  }) : super(key: key);

  @override
  State<EventoraSearchBar> createState() => _EventoraSearchBarState();
}

class _EventoraSearchBarState extends State<EventoraSearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isFocused ? AppColors.amberAccent : AppColors.warmLinenBorder,
          width: _isFocused ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search, color: AppColors.mutedText),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              style: AppTypography.bodyMD,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: AppTypography.bodyMD.copyWith(color: AppColors.mutedText),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.mutedText),
            onPressed: () {
              // Action for filter
            },
          ),
        ],
      ),
    );
  }
}
