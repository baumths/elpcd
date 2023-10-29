import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '/localizations.dart';
import 'schemes_list_controller.dart';

class SchemeTile extends StatelessWidget {
  const SchemeTile({super.key, required this.scheme, this.onTap});

  final Scheme scheme;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
      contentPadding: const EdgeInsetsDirectional.only(start: 16, end: 8),
      leading: InitialsAvatar(name: scheme.name),
      title: Text(scheme.name ?? context.l10n.untitled),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClassCount(
            schemeId: scheme.id,
            controller: context.read(),
          ),
          const Icon(Icons.arrow_right_rounded, size: 32),
        ],
      ),
    );
  }
}

class InitialsAvatar extends StatefulWidget {
  const InitialsAvatar({super.key, required this.name});

  final String? name;

  @override
  State<InitialsAvatar> createState() => _InitialsAvatarState();
}

class _InitialsAvatarState extends State<InitialsAvatar> {
  String? initials;

  void updateInitials() {
    if (widget.name case final String name when name.isNotEmpty) {
      final extractedInitials = name //
          .split(' ')
          .take(2)
          .map((word) => word[0])
          .join('')
          .toUpperCase();
      initials = extractedInitials.isEmpty ? null : extractedInitials;
    }
  }

  @override
  void initState() {
    super.initState();
    updateInitials();
  }

  @override
  void didUpdateWidget(covariant InitialsAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {
      updateInitials();
    }
  }

  @override
  void dispose() {
    initials = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.secondaryContainer,
      ),
      child: SizedBox.square(
        dimension: 40,
        child: Center(
          child: initials == null
              ? const Icon(Icons.question_mark_rounded)
              : MediaQuery.withNoTextScaling(
                  child: Text(
                    initials!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class ClassCount extends StatefulWidget {
  const ClassCount({
    super.key,
    required this.schemeId,
    required this.controller,
  });

  final int schemeId;
  final SchemesListController controller;

  @override
  State<ClassCount> createState() => _ClassCountState();
}

class _ClassCountState extends State<ClassCount> {
  static const maxCount = 99;

  int classCount = 0;
  bool isLoading = false;

  void updateClassCount() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    classCount = await widget.controller.getClassCount(widget.schemeId);
    isLoading = false;

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    updateClassCount();
  }

  @override
  void didUpdateWidget(covariant ClassCount oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.schemeId != widget.schemeId) {
      updateClassCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.medium1,
      switchInCurve: Easing.emphasizedAccelerate,
      switchOutCurve: Easing.emphasizedDecelerate,
      child: KeyedSubtree(
        key: Key('$classCount$isLoading'),
        child: classCount == 0
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Skeletonizer(
                  enabled: isLoading,
                  child: Text(
                    classCount > maxCount ? '$classCount+' : '$classCount',
                  ),
                ),
              ),
      ),
    );
  }
}
