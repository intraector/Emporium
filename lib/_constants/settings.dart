class Settings {
  Settings() {
    generateDefaults();
  }
  int currentPageParent = 0;
  int currentPage = 0;
  bool isShadowsOn = false;
  bool isRotationOn = true;
  bool isElasticOn = true;
  double cellHeightRatio = 0.7;
  Effect effect = Effect.none;
  List<double> cellWidth;
  List<double> cardWidthRatio;
  List<double> cardHeightRatio;

  int rowsQty = 10;
  int cardsQty = 8;

  void generateDefaults() {
    cellWidth = List.generate(rowsQty, (index) => 1.0);
    cardWidthRatio = List.generate(rowsQty, (index) => 1.0);
    cardHeightRatio = List.generate(rowsQty, (index) => 1.479);
  }
}

enum Effect { first, second, third, forth, none }
