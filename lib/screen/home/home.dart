import 'package:aniproject/screen/data/data.dart';
import 'package:aniproject/screen/detail/detail.dart';
import 'package:aniproject/screen/gallery/gallery.dart';
import 'package:flutter/material.dart';

class HomeClass extends StatefulWidget {
  const HomeClass({super.key});

  @override
  State<HomeClass> createState() => _HomeClassState();
}

class _HomeClassState extends State<HomeClass> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int _focusedIndex = 0; 
   final Data data = Data();
  // Tracks the currently focused container
  late TabController _tabController; // Declare TabController

  final List<String> images = [
    "assets/img/forest (1).jpg",
    "assets/img/forest (2).jpg",
    "assets/img/forest (3).jpg",
    "assets/img/forest (4).jpg",
  ]; // Add more image paths as needed

  final List<String> ocean = [
    "assets/img/ocean (1).jpg",
    "assets/img/ocean (2).jpg",
    "assets/img/ocean (3).jpg",
    "assets/img/ocean (4).jpg",
  ];

  // final List mountains = [

  //  {
  //   "name":"Mountain",

  //  },

  //   "assets/img/mountain (1).jpg",
  //   "assets/img/mountain (2).jpg",
  //   "assets/img/mountain (3).jpg",
  //   "assets/img/mountain (4).jpg",
  // ];

  final List<String> lake = [
    "assets/img/lake (1).jpg",
    "assets/img/lake (2).jpg",
    "assets/img/lake (3).jpg",
    "assets/img/lake (4).jpg",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Initialize TabController
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose(); // Dispose of TabController
    super.dispose();
  }

  void _onScroll() {
    const containerWidth = 258.0; // Approximate width of a container + spacing
    final currentIndex = (_scrollController.offset / containerWidth).round();

    if (currentIndex != _focusedIndex) {
      setState(() {
        _focusedIndex = currentIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Center(child: Text("Travel" , style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        )
        )
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              spacing: 8,
              children: [
                Container(
                  width: 400,
                  child: Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          controller: _tabController,
                          indicatorPadding: EdgeInsets.zero,
                          tabs: [
                            Tab(text: "Forest"),
                            Tab(text: "Ocean"),
                            Tab(text: "Mount"),
                            Tab(text: "Lake"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 360,
                  width: double.infinity,
                  child: TabBarView(
                    controller: _tabController, // Use the TabController here
                    children: [
                     buildForest (), // Pass the category dynamically
                   buildocean(),
                   buildMountain(),
                    buildLake(),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Text("Our Gallery",style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                )
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset("assets/img/gallery (1).jpg", height: 160, width: 160, fit: BoxFit.cover),
                        ),
                      ),
                      Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset("assets/img/gallery (2).jpg", height: 160, width: 160, fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset("assets/img/gallery (3).jpg", height: 160, width: 160, fit: BoxFit.cover),
                        ),
                      ),
                      Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset("assets/img/gallery (4).jpg", height: 160, width: 160, fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 180,
                  margin: EdgeInsets.only(left: 200),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return MyGallery(controller: _tabController); // Pass the TabController
                      }));
                    },
                    child: Text(
                      "See More",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
Widget buildMountain() {
  return SingleChildScrollView(
    controller: _scrollController,
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(data.mountain.length, (index) {
        final item = data.mountain[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            height: _focusedIndex == index ? 500 : 300,
            width: 250,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Detail(
                        index: index,
                        category: "mountain",
                      );
                    },
                  ),
                );
              },
              child: Hero(
                tag: "mountain-$index", // Unique tag
                child: Image.asset(
                   item.imagePath,
 fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }),
    ),
  );
}

// Generalized method to build images based on category data
 Widget buildForest(){
  return SingleChildScrollView(
    controller: _scrollController,
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(data.mountain.length, (index) {
                final item = data.forest[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            height: _focusedIndex == index ? 500 : 300,
            width: 250,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Detail(
                        index: index,
                        category: "forest"//s the category name
                      );
                    },
                  ),
                );
              },
             child: Hero(
                tag: "forest-$index", // Unique tag
                child: Image.asset(
item.imagePath,
       fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }),
    ),
  );
}
 Widget buildocean (){
  return SingleChildScrollView(
    controller: _scrollController,
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(data.mountain.length, (index) {
               final item = data.ocean[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            height: _focusedIndex == index ? 500 : 300,
            width: 250,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Detail(
                        index: index,
                        category: "ocean"// category name
                      );
                    },
                  ),
                );
              },
               child: Hero(
                tag: "ocean-$index", // Unique tag
                child: Image.asset(
  item.imagePath,
 fit: BoxFit.cover,
              ),
            ),
          ),
        )
        );
      }),
    ),
  );
}
 Widget buildLake(){
  return SingleChildScrollView(
    controller: _scrollController,
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(data.mountain.length, (index) {
                final item = data.lake[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            height: _focusedIndex == index ? 500 : 300,
            width: 250,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Detail(
                        index: index,
                        category: "lake"// category name
                      );
                    },
                  ),
                );
              },
              child: Hero(
                tag: "lake -$index", // Unique tag
                child: Image.asset(
                  item.imagePath,
 fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }),
    ),
  );
}

}

