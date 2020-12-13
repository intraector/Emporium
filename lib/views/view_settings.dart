import 'package:Emporium/_constants/routes.dart';
import 'package:Emporium/_constants/settings.dart';
import 'package:Emporium/common_components/bottom_tab_bar_material.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ViewSettings extends StatefulWidget {
  @override
  _ViewSettingsState createState() => _ViewSettingsState();
}

class _ViewSettingsState extends State<ViewSettings> {
  var settings = GetIt.I<Settings>();
  double rowWidth = 0.6;
  double cardWidth = 0.6;
  double cardHeight = 0.6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), backgroundColor: Colors.brown),
      bottomNavigationBar: BottomTabBarMaterial(Paths.settings),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Elastic', style: TextStyle(color: Colors.brown)),
                  Switch(
                    onChanged: (isChecked) => setState(() => settings.isElasticOn = isChecked),
                    value: settings.isElasticOn,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Rotation', style: TextStyle(color: Colors.brown)),
                  Switch(
                    onChanged: (isChecked) => setState(() => settings.isRotationOn = isChecked),
                    value: settings.isRotationOn,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Shadows', style: TextStyle(color: Colors.brown)),
                  Switch(
                    onChanged: (isChecked) => setState(() => settings.isShadowsOn = isChecked),
                    value: settings.isShadowsOn,
                  ),
                ],
              ),
              // Divider(),
              SizedBox(height: 20.0),
              // Card(
              // margin: EdgeInsets.all(8.0),
              // child: Column(
              // children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Flexible(
              //             child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Text('Grid', style: TextStyle(color: Colors.brown)),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text('Rows: ${settings.rowsQty}',
              //                 style: TextStyle(color: Colors.brown)),
              //           ),
              //           Expanded(
              //             child: Slider(
              //               label: settings.rowsQty.toString(),
              //               min: 1.0,
              //               max: 20.0,
              //               divisions: 20,
              //               onChanged: (value) => setState(() {
              //                 settings.rowsQty = value.toInt();
              //                 settings.generateDefaults();
              //               }),
              //               value: settings.rowsQty.toDouble(),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text('Cards: ${settings.cardsQty}',
              //                 style: TextStyle(color: Colors.brown)),
              //           ),
              //           Expanded(
              //             child: Slider(
              //               label: settings.cardsQty.toString(),
              //               min: 1.0,
              //               max: 20.0,
              //               divisions: 20,
              //               onChanged: (value) => setState(() {
              //                 settings.cardsQty = value.toInt();
              //                 settings.generateDefaults();
              //               }),
              //               value: settings.cardsQty.toDouble(),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 20.0),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Flexible(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text('General', style: TextStyle(color: Colors.brown)),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 8.0),
              //       child: Text('Cell Height', style: TextStyle(color: Colors.brown)),
              //     ),
              //     Expanded(
              //       child: Slider(
              //         label: (double.parse(settings.cellHeightRatio.toStringAsPrecision(2)) * 100)
              //                 .toStringAsFixed(0) +
              //             '% of screen\'s width',
              //         min: 0.4,
              //         max: 2.0,
              //         divisions: 16,
              //         onChanged: (value) => setState(() => settings.cellHeightRatio = value),
              //         value: settings.cellHeightRatio,
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 8.0),
              //       child: Text('H. padding', style: TextStyle(color: Colors.brown)),
              //     ),
              //     Expanded(
              //       child: Slider(
              //         label: (double.parse(settings.cardPaddingRatioH.toStringAsPrecision(3)) * 100)
              //                 .toStringAsFixed(1) +
              //             '% of cards\'s width',
              //         min: 0.01,
              //         max: 0.05,
              //         divisions: 4,
              //         onChanged: (value) => setState(() => settings.cardPaddingRatioH = value),
              //         value: settings.cardPaddingRatioH,
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 8.0),
              //       child: Text('V. padding', style: TextStyle(color: Colors.brown)),
              //     ),
              //     Expanded(
              //       child: Slider(
              //         label: (double.parse(settings.cardPaddingRatioV.toStringAsPrecision(3)) * 100)
              //                 .toStringAsFixed(1) +
              //             '% of cards\'s height',
              //         min: 0.005,
              //         max: 0.025,
              //         divisions: 4,
              //         onChanged: (value) => setState(() => settings.cardPaddingRatioV = value),
              //         value: settings.cardPaddingRatioV,
              //       ),
              //     ),
              //   ],
              // ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text('Effect', style: TextStyle(color: Colors.brown)),
                      )
                    ],
                  ),
                  Wrap(
                    children: [
                      Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('None', style: TextStyle(color: Colors.brown)),
                            ),
                            Radio(
                              groupValue: true,
                              onChanged: (isChecked) =>
                                  setState(() => settings.effect = Effect.none),
                              value: settings.effect == Effect.none,
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('First', style: TextStyle(color: Colors.brown)),
                            ),
                            Radio(
                              groupValue: true,
                              onChanged: (isChecked) =>
                                  setState(() => settings.effect = Effect.first),
                              value: settings.effect == Effect.first,
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Second', style: TextStyle(color: Colors.brown)),
                              Radio(
                                groupValue: true,
                                onChanged: (isChecked) =>
                                    setState(() => settings.effect = Effect.second),
                                value: settings.effect == Effect.second,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Third', style: TextStyle(color: Colors.brown)),
                            ),
                            Radio(
                              groupValue: true,
                              onChanged: (isChecked) =>
                                  setState(() => settings.effect = Effect.third),
                              value: settings.effect == Effect.third,
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Forth', style: TextStyle(color: Colors.brown)),
                            ),
                            Radio(
                              groupValue: true,
                              onChanged: (isChecked) =>
                                  setState(() => settings.effect = Effect.forth),
                              value: settings.effect == Effect.forth,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 20.0),
              GenerateRows(),
            ],
          ))
        ],
      )),
    );
  }
}

class GenerateRows extends StatefulWidget {
  @override
  _GenerateRowsState createState() => _GenerateRowsState();
}

class _GenerateRowsState extends State<GenerateRows> {
  var settings = GetIt.I<Settings>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: generate(),
    );
  }

  List<Widget> generate() {
    var output = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text('Individual', style: TextStyle(color: Colors.brown)),
          ),
        ],
      ),
      SizedBox(height: 20.0),
    ];
    for (int index = 0; index < settings.cells.list.length; index++) {
      output.add(Card(
        child: Row(
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Row ${index + 1}', style: TextStyle(color: Colors.brown)),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 8.0),
                  //       child: Text('Cell Width', style: TextStyle(color: Colors.brown)),
                  //     ),
                  //     Expanded(
                  //       child: Slider(
                  //         label:
                  //             (double.parse(settings.cellWidth[index].toStringAsPrecision(2)) * 100)
                  //                     .toStringAsFixed(0) +
                  //                 '% of screen\'s width',
                  //         min: 0.2,
                  //         max: 1.0,
                  //         divisions: 8,
                  //         onChanged: (value) => setState(() => settings.cellWidth[index] = value),
                  //         value: settings.cellWidth[index],
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Card Width', style: TextStyle(color: Colors.brown)),
                      ),
                      Expanded(
                        child: Slider(
                          label: (double.parse((settings.cells.list[index].widthRatio)
                                          .toStringAsPrecision(2)) *
                                      100)
                                  .toStringAsFixed(0) +
                              '% of screen\'s width',
                          min: 0.4,
                          max: 1.0,
                          divisions: 6,
                          onChanged: (value) =>
                              setState(() => settings.cells.list[index].widthRatio = value),
                          value: settings.cells.list[index].widthRatio,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Card Height', style: TextStyle(color: Colors.brown)),
                      ),
                      Expanded(
                        child: Slider(
                          label: (double.parse(settings.cells.list[index].heightRatio
                                          .toStringAsPrecision(2)) *
                                      100)
                                  .toStringAsFixed(0) +
                              '% of card\'s width',
                          min: 0.2,
                          max: 2.0,
                          divisions: 18,
                          onChanged: (value) =>
                              setState(() => settings.cells.list[index].heightRatio = value),
                          value: settings.cells.list[index].heightRatio,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return output;
  }
}
