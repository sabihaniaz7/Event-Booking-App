import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/booking_entity.dart';

/// Styled like a real event ticket — notch cut on the sides, dashed
/// tear-line, QR + code at the bottom. This is the "unique premium"
/// piece the brief asked for.
class QrTicketCard extends StatelessWidget {
  const QrTicketCard({super.key, required this.booking});
  final BookingEntity booking;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusL24),
        boxShadow: [
          BoxShadow(
            color: c.shadow,
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.l24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.s8,
                        vertical: AppSizes.xs4,
                      ),
                      decoration: BoxDecoration(
                        color: booking.status == BookingStatus.confirmed
                            ? c.success.withValues(alpha: 0.12)
                            : c.chipBg,
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusFull999,
                        ),
                      ),
                      child: Text(
                        booking.status.label,
                        style: AppTextStyles.captionXs11(
                          booking.status == BookingStatus.confirmed
                              ? c.success
                              : c.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.m12),
                Text(
                  booking.event.title,
                  style: AppTextStyles.titleL20(c.textPrimary),
                ),
                const SizedBox(height: AppSizes.s8),
                _TicketRow(
                  icon: Icons.calendar_today_rounded,
                  text: DateFormat('EEE, MMM d · h:mm a')
                      .format(booking.event.date),
                ),
                const SizedBox(height: AppSizes.xs4),
                _TicketRow(
                  icon: Icons.location_on_rounded,
                  text: booking.event.location,
                ),
                const SizedBox(height: AppSizes.xs4),
                _TicketRow(
                  icon: Icons.confirmation_num_rounded,
                  text:
                      '${booking.quantity} ticket${booking.quantity > 1 ? 's' : ''}',
                ),
              ],
            ),
          ),
          // Perforation line
          SizedBox(
            height: 1,
            child: CustomPaint(painter: _DashedLinePainter(color: c.border)),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.l24),
            child: Column(
              children: [
                QrImageView(
                  data: booking.bookingCode,
                  size: 160,
                  backgroundColor: Colors.white,
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: c.primaryVariant,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: c.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.m12),
                Text(
                  booking.bookingCode,
                  style: AppTextStyles.labelM16(c.textPrimary),
                ),
                Text(
                  'Show this at the entrance',
                  style: AppTextStyles.bodyS13(c.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketRow extends StatelessWidget {
  const _TicketRow({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      children: [
        Icon(icon, size: AppSizes.iconS16, color: c.textSecondary),
        const SizedBox(width: AppSizes.xs4),
        Text(text, style: AppTextStyles.bodyS13(c.textSecondary)),
      ],
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({required this.color});
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const dashWidth = 6.0, dashSpace = 4.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dashWidth, 0), paint);
      x += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
