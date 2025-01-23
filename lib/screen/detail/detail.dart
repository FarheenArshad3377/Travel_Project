import 'package:aniproject/screen/data/data.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final int index;
  final String category;

  Detail({super.key, required this.index, required this.category});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Data data = Data();
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _visible = true;
      });
    });
  }

  String getName() {
    switch (widget.category) {
      case 'mountain':
        return data.mountain[widget.index].name;
      case 'ocean':
        return data.ocean[widget.index].name;
      case 'forest':
        return data.forest[widget.index].name;
      case 'lake':
        return data.lake[widget.index].name;
      default:
        return data.mountain[widget.index].name;
    }
  }

  String getDescription() {
    switch (widget.category) {
      case 'mountain':
        return data.mountain[widget.index].description;
      case 'ocean':
        return data.ocean[widget.index].description;
      case 'forest':
        return data.forest[widget.index].description;
      case 'lake':
        return data.lake[widget.index].description;
      default:
        return data.mountain[widget.index].description;
    }
  }

  String getImage() {
    switch (widget.category) {
      case 'mountain':
        return data.mountain[widget.index].imagePath;
      case 'ocean':
        return data.ocean[widget.index].imagePath;
      case 'forest':
        return data.forest[widget.index].imagePath;
      case 'lake':
        return data.lake[widget.index].imagePath;
      default:
        return data.mountain[widget.index].imagePath;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(getName(),style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        )
        )
        ),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: "${widget.category}-${widget.index}",
                  flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
                    return RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(animation),
                      child: fromContext.widget,
                    );
                  },
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 600),
                    opacity: _visible ? 1.0 : 0.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        getImage(),
                        fit: BoxFit.cover,
                        height: 300,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                getName(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                getDescription(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Back",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

