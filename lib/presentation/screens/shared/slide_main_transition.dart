import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  const SlideInfo(
    this.title,
    this.caption,
    this.imageUrl,
  );
}

final slices = <SlideInfo>[
  const SlideInfo(
    'lorem10 ipsum dolor sit amet',
    'Dolor in commodo culpa magna laboris labore consequat. Sunt irure aliquip nulla ut amet duis voluptate deserunt. Incididunt elit veniam fugiat nulla occaecat magna pariatur. Officia minim elit pariatur veniam id dolor amet. Ea adipisicing aliquip excepteur occaecat dolore enim esse duis veniam. Aliqua et ea laboris voluptate ipsum aliquip adipisicing non non excepteur nisi.',
    'assets/images/slide1.jpg',
  ),
  const SlideInfo(
    'lorem ipsum dolor sit amet',
    'Laboris adipisicing aliquip amet aliqua laborum veniam commodo excepteur esse qui aliqua eiusmod. Ad in cupidatat proident id excepteur dolor in cillum sit laborum cillum incididunt id eiusmod. Sint proident laborum sint fugiat fugiat. Lorem duis eu sunt laborum esse quis in culpa pariatur veniam nostrud aliquip anim consectetur. Sint do adipisicing eu officia exercitation anim eu laborum.',
    'assets/images/slide2.jpg',
  ),
  const SlideInfo(
    'lorem ipsum dolor sit amet',
    'Eiusmod quis adipisicing elit officia adipisicing consequat fugiat. Do velit tempor incididunt ea adipisicing mollit. Qui dolore ex tempor eiusmod incididunt pariatur incididunt est aute ex cillum deserunt. Non elit ullamco ad nulla. Ex ipsum reprehenderit excepteur irure consectetur velit minim sint mollit sint laborum qui. Nisi esse laboris dolor magna consequat quis eiusmod dolore et duis aliqua. Proident Lorem aliqua pariatur id culpa.',
    'assets/images/slide3.jpg',
  ),
];

class SlideMainTransition extends StatefulWidget {
  static const String name = 'slide_transition';
  const SlideMainTransition({super.key});

  @override
  State<SlideMainTransition> createState() => _SlideMainTransitionState();
}

class _SlideMainTransitionState extends State<SlideMainTransition> {
  final PageController pageViewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      final page = pageViewController.page ?? 0;
      if (!endReached && page >= slices.length - 1.5) {
        setState(() {
          endReached = true;
        });
      }
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageViewController,
            physics: const BouncingScrollPhysics(),
            children: slices
                .map(
                  (e) => _Slide(
                    title: e.title,
                    caption: e.caption,
                    imageUrl: e.imageUrl,
                  ),
                )
                .toList(),
          ),
          endReached
              ? Positioned(
                  bottom: 30,
                  right: 30,
                  child: FadeInRight(
                    from: 15,
                    delay: const Duration(seconds: 1),
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text('Lets LogIn'),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;
  const _Slide({
    required this.title,
    required this.caption,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
            height: 300,
            width: 180,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: titleStyle,
          ),
          const SizedBox(height: 10),
          Text(
            caption,
            style: captionStyle,
          ),
        ],
      ),
    );
  }
}
