import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:rpod/app/shared/utils/username_color.dart';

class ProfileCardSector extends StatelessWidget {
  const ProfileCardSector({
    super.key,
    this.profileUrl,
    this.userName,
    this.name,
    this.onEdit,
  });

  final String? profileUrl;

  final String? userName;

  final String? name;

  final void Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    String svgCode =
        RandomAvatarString(userName ?? 'random.profile', trBackground: false);
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  child: profileUrl != null
                      ? ExtendedImage.network(
                          profileUrl ?? '',
                        )
                      : SvgPicture.string(svgCode),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: getUserNameColor(userName, colors),
                        ),
                        child: Text(
                          userName ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        name ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(
                    Icons.edit_outlined,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
