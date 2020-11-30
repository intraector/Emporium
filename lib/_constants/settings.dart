class Settings {
  int currentPageParent = 0;
  int currentPage = 0;
  bool isShadowsOn = false;
  bool isRotationOn = true;
  bool isElasticOn = true;
  double rowHeight = 0.7;
  List<double> rowWidth = List.generate(8, (index) => 1.0);
  List<double> cardWidthRatio = List.generate(8, (index) => 1.0);
  List<double> cardHeightRatio = List.generate(8, (index) => 1.479);

  int rowsQty = 10;

  void generateDefaults() {
    rowWidth = List.generate(rowsQty, (index) => 1.0);
    cardWidthRatio = List.generate(rowsQty, (index) => 1.0);
    cardHeightRatio = List.generate(rowsQty, (index) => 1.479);
  }
}
