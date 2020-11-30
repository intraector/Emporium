class Settings {
  Settings() {
    generateDefaults();
  }
  int currentPageParent = 0;
  int currentPage = 0;
  bool isShadowsOn = false;
  bool isRotationOn = true;
  bool isElasticOn = true;
  double rowHeight = 0.7;
  List<double> rowWidth;
  List<double> cardWidthRatio;
  List<double> cardHeightRatio;

  int rowsQty = 10;
  int cardsQty = 8;

  void generateDefaults() {
    rowWidth = List.generate(rowsQty, (index) => 1.0);
    cardWidthRatio = List.generate(rowsQty, (index) => 1.0);
    cardHeightRatio = List.generate(rowsQty, (index) => 1.479);
  }
}
