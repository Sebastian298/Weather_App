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
    'Ut officia velit nisi sint non cupidatat non.',
    'assets/images/slide/slide1.jpg',
  ),
  const SlideInfo(
    'lorem ipsum dolor sit amet',
    'Et reprehenderit ipsum excepteur ea nisi consequat est labore.',
    'assets/images/slide/slide1.jpg',
  ),
  const SlideInfo(
    'lorem ipsum dolor sit amet',
    'Laborum amet elit occaecat proident in eiusmod elit do aliqua id Lorem nostrud aliqua labore.',
    'assets/images/slide/slide1.jpg',
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
