import 'package:flutter/material.dart';
import 'package:lushi_app/features/provider/data/model/counter_model.dart';
import 'package:provider/provider.dart';

class ProviderTest2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterModel>(
      builder: (context, counter, child) {
        return Text(counter.count.toString());
      },
    );
  }
}
