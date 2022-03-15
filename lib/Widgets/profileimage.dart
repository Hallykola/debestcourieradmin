import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    required this.press, required this.image,
  }) : super(key: key);
  final Function() press;
  final image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: size.shortestSide * 0.2),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            margin: const EdgeInsets.all(6),
            height: size.shortestSide * 0.4,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor, // Colors.green,
            ),
            child: Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  margin: const EdgeInsets.all(6),
                  height: size.shortestSide * 0.4 - 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: image,
                      )),
                ),
                //   Positioned(
                // bottom: 0,
                // right: 0,
                // child: IconButton(
                //   onPressed: () {},
                //   icon: SvgPicture.asset('assets/icons/edit.svg'),
                // )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: press,
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black)]),
                      child: SvgPicture.asset(
                        'assets/images/camera.svg',
                        height: 50,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
