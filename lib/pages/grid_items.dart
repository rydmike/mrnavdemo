import 'package:flutter/material.dart';

const double kEdgePadding = 16.0;
const int kMaxCards = 200;
const double kMinCardWidth = 200;

class GridItems extends StatelessWidget {
  const GridItems({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraint) {
        final int nrOfColumns =
            (constraint.maxWidth.toInt()) ~/ kMinCardWidth.toInt();
        return GridView.builder(
          padding: const EdgeInsets.all(kEdgePadding),
          shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: nrOfColumns == 0 ? 1 : nrOfColumns,
            mainAxisSpacing: kEdgePadding,
            crossAxisSpacing: kEdgePadding,
            childAspectRatio: 1.4,
          ),
          itemCount: kMaxCards,
          itemBuilder: (_, int index) => Card(
            elevation: 3,
            child: GridItem(
              title: 'Card ${index + 1}',
              color: (Colors.primaries[index % Colors.primaries.length][
                  Theme.of(context).brightness == Brightness.light
                      ? 600
                      : 300])!,
            ),
          ),
        );
      },
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.light
            ? Colors.black87
            : Colors.white70;
    return Container(
      color: color,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
          Icon(Icons.apps, color: textColor),
        ],
      ),
    );
  }
}
