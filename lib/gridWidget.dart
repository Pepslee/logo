import 'package:flutter/material.dart';
import 'package:logo/itemWidget.dart';

class GridWidget extends StatelessWidget {
  final int count;

  const GridWidget({Key? key, required this.count}) : super(key: key);
  final double crossAxisCount = 2;
  final double axisSpacing = 10;
  final double gridMargin = 10;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        double maxHeight = constraints.maxHeight;
        double minHeight = calcLogoHeight(maxWidth, maxHeight);
        return Scrollbar(
          thickness: 8,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: minHeight, maxHeight: maxHeight),
                  child: Container(
                      margin: const EdgeInsets.all(30),
                      child: const Image(image: AssetImage('assets/logo.png'))),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                    left: gridMargin, right: gridMargin, bottom: gridMargin),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Item(itemName: 'Item${index + 1}');
                    },
                    childCount: count,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount.toInt(),
                      childAspectRatio: 2.0,
                      mainAxisSpacing: axisSpacing,
                      crossAxisSpacing: axisSpacing),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  double calcLogoHeight(double maxWidth, double maxHeight) {
    /// Calculation the grid cell with and height
    double itemWidth =
        (maxWidth - axisSpacing * (crossAxisCount - 1) - gridMargin * 2) /
            crossAxisCount;
    double itemHeight = itemWidth / 2;

    /// Calculation rows count
    int rowCount = (count / crossAxisCount).ceil();
    /// When count of rows is zero, however GridView has height of 1 row.
    rowCount = rowCount == 0 ? 1 : rowCount;

    /// Calculation of one cell height to show from bottom
    double bottomShift =
        itemHeight * rowCount + axisSpacing * (rowCount - 1) + gridMargin;

    /// Calculation size of logo widget
    double minHeight = maxHeight - bottomShift;

    /// Avoid negative height if bottomShift is to big
    minHeight = minHeight < 0 ? 0 : minHeight;
    return minHeight;
  }
}
