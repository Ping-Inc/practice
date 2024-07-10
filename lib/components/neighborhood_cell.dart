import 'package:flutter/material.dart';
import 'package:practice/components/meta_data_text.dart';

class NeighborhoodCell extends StatelessWidget {
  const NeighborhoodCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetaDataText(text: "neighborhood");
  }
}
