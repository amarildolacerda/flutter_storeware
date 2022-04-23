// @dart=2.12

import 'package:console/config/config.dart';
import 'package:controls_web/controls/color_picker.dart';
import 'package:controls_web/controls/data_viewer.dart';
import 'package:console/comum/controls.dart';
import 'package:console/views/agenda/models/agenda_recurso_model.dart';
import 'package:flutter/material.dart';

class CadastroAgendaRecursosPage extends StatefulWidget {
  static final route = '/estados';
  CadastroAgendaRecursosPage({Key? key}) : super(key: key);

  @override
  _CadastroEstadosPedidoViewState createState() =>
      _CadastroEstadosPedidoViewState();
}

class _CadastroEstadosPedidoViewState
    extends State<CadastroAgendaRecursosPage> {
  @override
  void dispose() {
    super.dispose();
  }

  DataViewerController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Cadastro de Recursos')),
      bottomNavigationBar: SizedBox(
        height: 50,
      ),
      body: DataViewer(
          showPageNavigatorButtons: false,
          canSearch: false,
          crossAxisAlignment: CrossAxisAlignment.center,
          onSaved: (x) {
            AgendaReloadNotifier().notify('alterado cadastro de recursos');
          },
          controller: controller ??= DataViewerController(
            keyName: 'gid',
            dataSource: AgendaRecursoItemModel(),
            future: () =>
                AgendaRecursoItemModel().listNoCached(orderBy: 'ordem'),
            onValidate: (row) {
              return AgendaRecursoItem.fromJson(row).toJson();
            },
          ),
          canEdit: true,
          canDelete: true,
          canInsert: true,
          columns: [
            DataViewerColumn(
              name: 'nome',
            ),
            DataViewerColumn(
              name: 'ordem',
            ),
            DataViewerColumn(
              tooltip: 'Duração padrão da agenda (minutos)',
              name: 'intervalo',
              label: 'Duração(min)',
            ),
            DataViewerColumn(
              name: 'inativo',
              onGetValue: (x) {
                return (x == 'S') ? 'Sim' : 'Não';
              },
              editBuilder: (a, b, item, row) {
                return FormComponents.createSwitchFormField(
                    value: item == 'S',
                    label: 'Inativo',
                    onChanged: (b) {
                      row['inativo'] = (b) ? 'S' : "N";
                    });
              },
            ),
            DataViewerColumn(
              name: 'cor',
              builder: (idx, Map<String, dynamic> row) {
                Color cor = ColorExtension.intRGBToColor(row['cor']);
                row['cor'] ??= cor.toRGB();

                return ColorPickerField(
                  color: cor,
                );
              },
              editBuilder: (a, b, item, row) {
                Color cor = ColorExtension.intRGBToColor(row['cor']);
                row['cor'] ??= cor.toRGB();
                return ColorPickerField(
                  color: cor,
                  onChanged: (c) {
                    // print(c.toRGBInt());
                    row['cor'] = c.toRGBInt();
                  },
                );
              },
            ),
          ]),
    );
  }
}
