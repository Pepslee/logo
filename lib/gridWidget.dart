import 'package:flutter/material.dart';
import 'package:logo/itemWidget.dart';

class GridWidget extends StatelessWidget {
  final List<String> items;

  const GridWidget({Key? key, required this.items}) : super(key: key);
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
                  constraints: BoxConstraints(minHeight: minHeight),
                  child: Container(
                      margin: const EdgeInsets.all(30),
                      child: const Image(image: AssetImage('assets/logo.png'))),
                ),
              ),
              items.isNotEmpty ? SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: gridMargin),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Item(itemName: items[index]);
                    },
                    childCount: items.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount.toInt(),
                      childAspectRatio: 2.0,
                      mainAxisSpacing: axisSpacing,
                      crossAxisSpacing: axisSpacing),
                ),
              ) : const SliverToBoxAdapter(
                child: SizedBox.shrink(),
              )
            ],
          ),
        );
      },
    );
  }

  double calcLogoHeight(double maxWidth, double maxHeight) {
    /// Calculation the grid cell with and height
    double itemWidth = (maxWidth -
        axisSpacing * (crossAxisCount - 1) -
        gridMargin * 2) / crossAxisCount;
    double itemHeight = itemWidth / 2;
    /// Calculation rows count
    int rowCount = (items.length / crossAxisCount).ceil();
    /// Calculation of one cell height to show from bottom
    double bottomShift = itemHeight * rowCount +
        axisSpacing * (rowCount - 1) + gridMargin;
    /// Calculation size of logo widget
    double minHeight = maxHeight - bottomShift;
    /// Avoid negative height if bottomShift is to big
    minHeight = minHeight < 0 ? 0: minHeight;
    return minHeight;
  }
}
