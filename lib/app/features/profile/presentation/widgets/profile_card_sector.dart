import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_avatar/random_avatar.dart';

class ProfileCardSector extends StatelessWidget {
  const ProfileCardSector({
    super.key,
    this.profileUrl,
    this.userName,
    this.name,
  });

  final String? profileUrl;

  final String? userName;

  final String? name;

  @override
  Widget build(BuildContext context) {
    String svgCode = RandomAvatarString('Mr.Noy555', trBackground: false);
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                      Text(
                        userName ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
