import 'package:asbeza_app/screens/profilePage/components/persistent_tabs_widget.dart';
import 'package:asbeza_app/screens/profilePage/profileHome.dart';
import 'package:flutter/material.dart';

import 'profile_header_widget.dart';

const double maxHeaderExtent = 400.0;
const double minHeaderExtent = 80.0;

const double avatarRadius = 30;
const double minAvatarRadius = 20;
const double maxAvatarRadius = 50;

const double minLeftOffset = 20;
const double maxleftOffset = 80;

const double minTopOffset = 8;
const double maxTopOffset = 50;

const double minFontSize = 16;
const double maxFontSize = 18;

class PersistentProfileHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final paddingTop = MediaQuery.of(context).padding.top;
    double percent = (shrinkOffset - initialScrollOffset) /
        (maxExtent - initialScrollOffset - paddingTop - 60);

    double radius = avatarRadius * (1 - percent);
    radius = radius.clamp(minAvatarRadius, maxAvatarRadius);

    double leftOffset = maxleftOffset * 1.3 * percent;
    leftOffset = leftOffset.clamp(minLeftOffset, maxleftOffset);

    double topOffset = maxTopOffset * (1 - percent);
    topOffset = topOffset.clamp(minTopOffset, maxTopOffset);

    double fontSize = maxFontSize * 3 * (1 - percent);
    fontSize = fontSize.clamp(minFontSize, maxFontSize);

    bool mustExpand = shrinkOffset < initialScrollOffset * scrollDesiredPercent;

    return Container(
      color: KappBarColor,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: duration,
            top: mustExpand ? 0 : paddingTop + topOffset,
            left: mustExpand ? 0 : leftOffset,
            child: AnimatedContainer(
              duration: duration,
              height: mustExpand ? maxExtent - shrinkOffset : 2 * radius,
              width:
                  mustExpand ? MediaQuery.of(context).size.width : 2 * radius,
              decoration: BoxDecoration(
                // color: Colors.red,
                shape:
                    shrinkOffset < 160 ? BoxShape.rectangle : BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/random_profile.jpg'),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: duration,
            top: mustExpand
                ? (maxExtent - shrinkOffset) - 60
                : percent > 0.9
                    ? paddingTop + 8
                    : paddingTop + topOffset + radius / 2 - 7,
            left: mustExpand ? 10 : leftOffset + 2 * radius + 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  style: TextStyle(
                    fontSize: mustExpand ? 24 : fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  child: const Text(
                    'Melat T.',
                  ),
                ),
                const SizedBox(height: 5),
                AnimatedDefaultTextStyle(
                  style: TextStyle(
                    color: mustExpand ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  child: const Text(
                    'Last seen recently',
                  ),
                ),
              ],
            ),
          ),
          ProfileHeaderWidget(paddingTop: paddingTop),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderExtent;

  @override
  double get minExtent => minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
