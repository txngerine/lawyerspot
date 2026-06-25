import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A soft, shadowed card matching the "ambient-shadow" cards in the design.
class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.color,
    this.borderColor,
    this.onTap,
    this.borderRadius = 18,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? AppColors.cardLowest,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? AppColors.outlineVariant.withOpacity(0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) return card;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: card,
    );
  }
}

/// The gold pill-shaped primary CTA button used throughout the app.
class GoldButton extends StatelessWidget {
  const GoldButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = true,
    this.background,
    this.foreground,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: background ?? AppColors.goldDark,
        foregroundColor: foreground ?? Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          if (icon != null) ...[
            const SizedBox(width: 8),
            Icon(icon, size: 18),
          ],
        ],
      ),
    );
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Small uppercase label, e.g. "STEP 1 OF 4".
class CapsLabel extends StatelessWidget {
  const CapsLabel(this.text, {super.key, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppText.labelCaps.copyWith(color: color ?? AppColors.navy),
    );
  }
}

/// A selectable chip used for practice areas / filters.
class SelectableChip extends StatelessWidget {
  const SelectableChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: selected ? AppColors.goldDark.withOpacity(0.1) : AppColors.cardLowest,
          border: Border.all(
            color: selected ? AppColors.goldDark : AppColors.outlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppText.bodySm.copyWith(
                color: selected ? AppColors.goldDark : AppColors.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 4),
              const Icon(Icons.check, size: 14, color: AppColors.goldDark),
            ],
          ],
        ),
      ),
    );
  }
}

/// Round avatar with a small navy/gold "verified" check badge.
class VerifiedAvatar extends StatelessWidget {
  const VerifiedAvatar({
    super.key,
    this.size = 40,
    this.initials,
    this.imageUrl,
  });

  final double size;
  final String? initials;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: size / 2,
            backgroundColor: AppColors.surfaceContainerHigh,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            child: imageUrl == null
                ? Text(
                    initials ?? '',
                    style: AppText.titleLg.copyWith(
                      color: AppColors.navy.withOpacity(0.6),
                    ),
                  )
                : null,
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: size * 0.32,
              height: size * 0.32,
              decoration: BoxDecoration(
                color: AppColors.navy,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
              child: Icon(Icons.check, size: size * 0.18, color: AppColors.gold),
            ),
          ),
        ],
      ),
    );
  }
}

/// Standard top app bar with the LawyerSpot brand mark + notification bell.
class BrandAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BrandAppBar({
    super.key,
    this.onNotificationsTap,
    this.showBack = false,
    this.title,
  });

  final VoidCallback? onNotificationsTap;
  final bool showBack;
  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).maybePop(),
            )
          : null,
      title: title != null
          ? Text(title!, style: AppText.titleLg)
          : Row(
              children: [
                const VerifiedAvatar(size: 36, initials: 'AR'),
                const SizedBox(width: 10),
                Text('LawyerSpot', style: AppText.displayLgMobile.copyWith(fontSize: 20)),
              ],
            ),
      actions: [
        IconButton(
          icon: Badge(
            smallSize: 8,
            backgroundColor: AppColors.goldDark,
            child: const Icon(Icons.notifications_outlined),
          ),
          onPressed: onNotificationsTap,
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

/// Small stat card used on dashboards (number + label + icon).
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.caption,
  });

  final String label;
  final String value;
  final IconData icon;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CapsLabel(label),
                    const SizedBox(height: 6),
                    Text(value, style: AppText.displayLgMobile),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.navy, size: 20),
              ),
            ],
          ),
          if (caption != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(caption!, style: AppText.bodySm.copyWith(color: AppColors.outline)),
            ),
          ],
        ],
      ),
    );
  }
}
