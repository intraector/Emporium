import 'package:flutter/material.dart';

class Unfolded extends StatefulWidget {
  Unfolded({@required this.height, @required this.path});
  final double height;
  final String path;
  @override
  _UnfoldedState createState() => _UnfoldedState();
}

class _UnfoldedState extends State<Unfolded> with TickerProviderStateMixin {
  double aspectRatio = 1.0;
  double _height;
  @override
  void initState() {
    _height = (widget.height * aspectRatio) - 40.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Colors.grey.shade300,
          child: Stack(
            children: [
              Column(
                children: [
                  AnimatedSize(
                    vsync: this,
                    duration: Duration(milliseconds: 2000),
                    child: SizedBox(height: _height),
                    curve: Curves.bounceOut,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0, bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Text(
                          'Back in 1960 a man in England put a plant in a huge bottle. \nIn 1972 he watered it for the last time, but it keeps on thriving. The sealed bottle works like a mini ecosystem that recycles its nutrients and water.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 18.0),
                        ))
                      ],
                    ),
                  ),
                  Divider(height: 25.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Text(
                          '#History #England #Nature #Content4app #Ecology #Men #Announcements',
                          // textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 17.0),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/avatar.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TheOffWhiteDealer',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                              ),
                              Text(
                                '32.4K Likes  3 min ago',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _height = _height == 0.0 ? ((widget.height * aspectRatio) - 40.0) : 0.0;
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: aspectRatio,
                        child: Image.asset(widget.path, fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
