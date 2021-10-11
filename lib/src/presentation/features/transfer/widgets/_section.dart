part of '../transfer.dart';

class TransferSection extends StatelessWidget {
  const TransferSection({
    Key? key,
    required this.content,
    required this.action,
  }) : super(key: key);

  final Widget content;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: AppBorderRadius.all,
        border: Border.fromBorderSide(
          BorderSide(
            color: AppColors.primaryLight,
            width: 1.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppInsets.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            content,
            const SizedBox(height: AppInsets.medium),
            action,
          ],
        ),
      ),
    );
  }
}
