import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/support_provider.dart';
import '../../widgets/custom_app_bar.dart';

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({super.key});

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<String> _suggestedPrompts = [
    'Check booking status',
    'How does Escrow refund work?',
    'Request custom tasting session',
    'Need drone permits for venue',
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage([String? textToSend]) {
    final text = textToSend ?? _messageController.text;
    if (text.trim().isEmpty) return;

    context.read<SupportProvider>().sendChatMessage(text);
    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final support = context.watch<SupportProvider>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: CustomAppBar(
        title: 'VIP Concierge Dispatch',
        subtitleWidget: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.emeraldSage,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'Online • Clara (Senior Host)',
              style: AppTypography.bodySmall
                  .copyWith(fontSize: 11, color: AppColors.emeraldSage),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: support.chatMessages.length,
              itemBuilder: (context, index) {
                final msg = support.chatMessages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    mainAxisAlignment: msg.isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!msg.isUser) ...[
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.deepAmber,
                          child: Icon(Icons.support_agent,
                              size: 18, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: msg.isUser
                                ? AppColors.deepAmber
                                : AppColors.surfaceContainerLowest,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(msg.isUser ? 16 : 4),
                              bottomRight: Radius.circular(msg.isUser ? 4 : 16),
                            ),
                            border: msg.isUser
                                ? null
                                : Border.all(color: AppColors.warmLinen),
                            boxShadow: const [AppColors.cardRestShadow],
                          ),
                          child: Column(
                            crossAxisAlignment: msg.isUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              if (!msg.isUser && msg.senderName != null) ...[
                                Text(
                                  msg.senderName!,
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.deepAmber,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                              ],
                              Text(
                                msg.text,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: msg.isUser
                                      ? Colors.white
                                      : AppColors.obsidianCharcoal,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('hh:mm a').format(msg.timestamp),
                                style: AppTypography.bodySmall.copyWith(
                                  color: msg.isUser
                                      ? Colors.white.withValues(alpha: 0.7)
                                      : AppColors.mutedStone,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Typing Indicator
          if (support.isTyping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: [
                  const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: AppColors.deepAmber),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Clara is composing a response...',
                    style: AppTypography.bodySmall
                        .copyWith(fontSize: 11, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

          // Suggested Prompts Carousel
          Container(
            height: 38,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _suggestedPrompts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final prompt = _suggestedPrompts[index];
                return GestureDetector(
                  onTap: () => _sendMessage(prompt),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.alabasterVeil,
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: AppColors.warmLinen),
                    ),
                    child: Text(
                      prompt,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.obsidianCharcoal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Message Input Field
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: MediaQuery.of(context).padding.bottom + 10,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              border: Border(top: BorderSide(color: AppColors.warmLinen)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: 'Type your message or inquiry...',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send_rounded,
                      color: AppColors.deepAmber),
                  onPressed: () => _sendMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
