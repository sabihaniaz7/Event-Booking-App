import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/event_entity.dart';

class CategoryChipRow extends StatelessWidget {
  const CategoryChipRow({
    super.key,
    required this.selected,
    required this.onSelect,
  });
  final EventCategory? selected;
  final ValueChanged<EventCategory?> onSelect;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      height: AppSizes.xl40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: EventCategory.values.length + 1, // +1 for "All"
        separatorBuilder: (_, _) => const SizedBox(width: AppSizes.s8),
        itemBuilder: (_, i) {
          final isAll = i == 0;
          final category = isAll ? null : EventCategory.values[i - 1];
          final isSelected = selected == category;

          return ChoiceChip(
            label: Text(isAll ? 'All' : category!.label),
            selected: isSelected,
            onSelected: (_) => onSelect(category),
            backgroundColor: c.chipBg,
            selectedColor: c.primary,
            labelStyle: AppTextStyles.labelS13(
              isSelected ? c.onPrimary : c.textPrimary,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusFull999),
            ),
            side: BorderSide.none,
          );
        },
      ),
    );
  }
}
