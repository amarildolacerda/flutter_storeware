import 'package:flutter/material.dart';
import 'package:flutter_storeware/index.dart';

import '../../controls_web/lib/controls/list_box.dart';

class Mix3View extends StatelessWidget {
  const Mix3View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const GradientBox(
            colors: [Colors.red, Colors.yellow, Colors.indigo, Colors.green],
            child: Center(child: Text('  GradientBox  ')),
            height: 40,
          ),
          const Divider(),
          const Text('SwitchButton'),
          SwitchButton(
            //width: 120,
            //height: 30,
            onChanged: (value) {},
            value: true,
            activeColor: Colors.red,
            activeTextColor: Colors.green,
            //activeText: 'Ligado',
            //inactiveText: 'Desligado',
          ),
          const Divider(),
          SlideTile(
            color: Colors.white,
            //img: img,
            child: const Text('child'),
            title: 'SlideTile.title',
            subTitle: 'subTitle',
            rating: '1',
          ),
          const CardPanel(
            title: Text('CardPanel.title'),
            bottom: Text('bottom'),
          ),
          ListBox(
              title: const Text('ListBox'),
              children: const ['amarelo', 'verde', 'azul'],
              values: const [true, false, false],
              onChanged: (
                index,
                value,
              ) {})
        ],
      ).singleChildScrollView(),
    );
  }
}
