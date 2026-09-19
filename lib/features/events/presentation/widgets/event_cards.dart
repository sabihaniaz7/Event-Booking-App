import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/event_entity.dart';

/// Horizontal layout — image left, details right. Used in list contexts
/// (Home "Upcoming", Browse results, Search results).
class EventListCard extends StatelessWidget {
  const EventListCard({super.key, required this.event, required this.onTap});
  final EventEntity event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusM16),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.s8),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM16),
          border: Border.all(color: c.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusM12),
              child: Image.network(
                event.imageUrl,
                width: AppSizes.xl64 + AppSizes.m16,
                height: AppSizes.xl64 + AppSizes.m16,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: AppSizes.xl64 + AppSizes.m16,
                  height: AppSizes.xl64 + AppSizes.m16,
                  color: c.chipBg,
                  child: Icon(Icons.event_rounded, color: c.textSecondary),
                ),
              ),
            ),
            const SizedBox(width: AppSizes.m12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: AppTextStyles.labelM16(c.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.xs4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: AppSizes.iconS16,
                        color: c.textSecondary,
                      ),
                      const SizedBox(width: AppSizes.xs4),
                      Text(
                        DateFormat('MMM d, h:mm a').format(event.date),
                        style: AppTextStyles.bodyS13(c.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.xs4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: AppSizes.iconS16,
                        color: c.textSecondary,
                      ),
                      const SizedBox(width: AppSizes.xs4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: AppTextStyles.bodyS13(c.textSecondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.s8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event.ticketPrice == 0
                            ? 'Free'
                            : '\$${event.ticketPrice.toStringAsFixed(0)}',
                        style: AppTextStyles.priceL20(c.primary),
                      ),
                      if (event.isSoldOut)
                        _StatusPill(label: 'Sold out', color: c.error)
                      else
                        _StatusPill(
                          label: '${event.seatsAvailable} left',
                          color: c.success,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Large hero card — used for "Featured" carousel on Home.
class FeaturedEventCard extends StatelessWidget {
  const FeaturedEventCard({
    super.key,
    required this.event,
    required this.onTap,
  });
  final EventEntity event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusL24),
          image: DecorationImage(
            image: NetworkImage(event.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.m16),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusL24),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.75),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.s8,
                  vertical: AppSizes.xs4,
                ),
                decoration: BoxDecoration(
                  color: c.accent,
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull999),
                ),
                child: Text(
                  event.category.label,
                  style: AppTextStyles.captionXs11(c.onAccent),
                ),
              ),
              const SizedBox(height: AppSizes.s8),
              Text(
                event.title,
                style: AppTextStyles.titleL20(Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSizes.xs4),
              Text(
                DateFormat('MMM d, yyyy').format(event.date),
                style: AppTextStyles.bodyS13(Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.s8,
        vertical: AppSizes.xs4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSizes.radiusFull999),
      ),
      child: Text(label, style: AppTextStyles.captionXs11(color)),
    );
  }
}
