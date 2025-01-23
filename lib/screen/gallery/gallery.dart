import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_hero_transform/local_hero_transform.dart';

class MyGallery extends StatefulWidget {
  final TabController controller;

  MyGallery({super.key, required this.controller});

  @override
  State<MyGallery> createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> with TickerProviderStateMixin {
  final List<String> images = [
    "assets/img/gallery (1).jpg",
    "assets/img/gallery (2).jpg",
    "assets/img/gallery (3).jpg",
    "assets/img/gallery (4).jpg",
  ];

 late TabController _tabController;
  late ValueNotifier<FavoriteShape> _switchNotifier;
  late ValueNotifier<TextDirection> _changeLanguage;

  @override
  void initState() {
    super.initState();
    _switchNotifier = ValueNotifier(FavoriteShape.gird);
    _changeLanguage = ValueNotifier(TextDirection.rtl);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _switchNotifier.dispose();
    _changeLanguage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appBar(),
      body: ValueListenableBuilder(
        valueListenable: _changeLanguage,
        builder: (context, textDirection, child) {
          return Directionality(
            textDirection: textDirection,
            child: LocalHero(
              controller: _tabController,
              pages: [
                ListViewContent(textDirection: textDirection),
                GridViewContent(textDirection: textDirection),
              ],
            ),
          );
        },
      ),
    );
  }
   AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor:  Colors.teal,
      surfaceTintColor: backgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    const Color.fromARGB(255, 255, 254, 254).withValues(alpha: 0.3),
                  ),
                ),
                onPressed: () => _changeLanguage.value = TextDirection.rtl,
                icon: Text('🇸🇦'),
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0.3),
                  ),
                ),
                onPressed: () => _changeLanguage.value = TextDirection.ltr,
                icon: Text('🇺🇸'),
              )
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildSwitchGridAndListButton(),
        ),
      ],
    );
  }

  Widget _buildSwitchGridAndListButton() {
    return ValueListenableBuilder(
      valueListenable: _switchNotifier,
      builder: (context, value, child) {
        return ConstrainedBox(
          constraints: BoxConstraints.tight(Size(35, 35)),
          child: AspectRatio(
            aspectRatio: 1.9 / 2,
            child: RawMaterialButton(
              onPressed: () => _switchBetweenGridAndList(),
              elevation: 0,
              visualDensity: const VisualDensity(
                vertical: -4,
                horizontal: -4,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              fillColor:Colors.white,
              child: Icon(
                _tabController.index == 0
                    ? Icons.grid_view_rounded
                    : Icons.view_agenda_outlined,
                size: 20 - 4,
                color: Colors.teal,
              ),
            ),
          ),
        );
      },
    );
  }

  void _switchBetweenGridAndList() {
    if (_switchNotifier.value == FavoriteShape.gird) {
      _tabController.animateTo(1);
      _switchNotifier.value = FavoriteShape.list;
    } else {
      _tabController.animateTo(0);
      _switchNotifier.value = FavoriteShape.gird;
    }
  }
}

class GridViewContent extends StatelessWidget {
  const GridViewContent({super.key, required this.textDirection});
  final TextDirection textDirection;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 16 / 21.5,
      padding: const EdgeInsets.all(8.0),
      children: List.generate(
        locations.length,
        (index) {
          return CardGridView(
            index: index,
            textDirection: textDirection,
            cardModel: HeroCardModel(
              name: locations[index].name,
              title: locations[index].place,
              imageUrl: locations[index].imageUrl,
              subTitle: locations[index].place,
            ),
            optionalParameters: BaseHeroCardOptionalParameters(
              // onPressedFavoriteIcon: () => log('favorite'),
            ),
          );
        },
      ),
    );
  }
}

class ListViewContent extends StatelessWidget {
  const ListViewContent({super.key, required this.textDirection});
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: locations.length,
      itemBuilder: (context, index) {
        return CardListView(
          index: index,
          textDirection: textDirection,
          cardModel: HeroCardModel(
            name: locations[index].name,
            title: locations[index].place,
            imageUrl: locations[index].imageUrl,
            subTitle: locations[index].place,
          ),
        );
      },
    );
  }
}

class Location {
  const Location(
      {required this.name, required this.place, required this.imageUrl});
  final String name;
  final String place;
  final String imageUrl;
}

const urlPrefix =
    'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
const locations = [
  Location(
      name: 'Mount ',
      place: 'U.S.A',
      imageUrl: '$urlPrefix/01-mount-rushmore.jpg'),
  Location(
      name: 'Gardens ',
      place: 'Singapore',
      imageUrl: '$urlPrefix/02-singapore.jpg'),
  Location(
      name: 'Machu Picchu',
      place: 'Peru',
      imageUrl: '$urlPrefix/03-machu-picchu.jpg'),
  Location(
      name: 'Vitznau',
      place: 'Switzerland',
      imageUrl: '$urlPrefix/04-vitznau.jpg'),
  Location(
      name: 'Bali', place: 'Indonesia', imageUrl: '$urlPrefix/05-bali.jpg'),
  Location(
      name: 'Mexico City',
      place: 'Mexico',
      imageUrl: '$urlPrefix/06-mexico-city.jpg'),
  Location(name: 'Cairo', place: 'Egypt', imageUrl: '$urlPrefix/07-cairo.jpg'),
  Location(name: 'Yemen', place: "Sana'a", imageUrl: '$urlPrefix/07-cairo.jpg'),
];

const backgroundColor = Color(0xFFF2F3F8);

enum FavoriteShape { gird, list }

