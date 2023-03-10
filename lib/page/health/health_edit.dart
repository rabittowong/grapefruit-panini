import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../component/dialog/dialog_confirm_delete.dart';
import '../../component/form/form_date_picker.dart';
import '../../component/form/form_elevated_button.dart';
import '../../component/form/form_input.dart';
import '../../component/form/form_select.dart';
import '../../enum/time_period.dart';
import '../../model/health_model.dart';

class HealthEdit extends StatefulWidget {
  const HealthEdit({Key? key, required this.health}) : super(key: key);

  final HealthModel health;

  @override
  HealthEditState createState() => HealthEditState();
}

class HealthEditState extends State<HealthEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _recordedAt = TextEditingController();
  final TextEditingController _timePeriod = TextEditingController();
  final TextEditingController _systolicPressure = TextEditingController();
  final TextEditingController _diastolicPressure = TextEditingController();
  final TextEditingController _heartRate = TextEditingController();
  final TextEditingController _stepCount = TextEditingController();
  final TextEditingController _remark = TextEditingController();

  @override
  void initState() {
    super.initState();

    _recordedAt.text =
        DateFormat('yyyy-MM-dd').format(widget.health.recordedAt);
    _timePeriod.text = widget.health.recordedAt.hour <= 12
        ? TimePeriod.am.toLabel()
        : TimePeriod.pm.toLabel();
    _systolicPressure.text = widget.health.systolicPressure.toString();
    _diastolicPressure.text = widget.health.diastolicPressure.toString();
    _heartRate.text = widget.health.heartRate.toString();
    _stepCount.text = widget.health.stepCount?.toString() ?? '';
    _remark.text = widget.health.remark ?? '';
  }

  void _onChangedTimePeriod(String? value) {
    if (value == null) {
      return;
    }

    setState(() {
      _timePeriod.text = value;
    });
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final HealthModel health = HealthModel(
        id: widget.health.id,
        systolicPressure: int.parse(_systolicPressure.text),
        diastolicPressure: int.parse(_diastolicPressure.text),
        heartRate: int.parse(_heartRate.text),
        stepCount:
            _stepCount.text.isNotEmpty ? int.parse(_stepCount.text) : null,
        remark: _remark.text.isNotEmpty ? _remark.text : null,
        recordedAt: DateTime.parse(_recordedAt.text).add(Duration(
            hours: _timePeriod.text == TimePeriod.am.toLabel() ? 6 : 18)),
        uid: 'uid',
        updatedAt: DateTime.now(),
        updatedBy: 'updatedBy',
      );

      debugPrint('updated $health');
    }
  }

  void _onRemove() {
    showDialog(
        context: context,
        builder: (context) => const DialogConfirmDelete()).then((value) {
      if (value != null && value) {
        debugPrint('deleted ${widget.health.id}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('??????????????????'),
        actions: [
          PopupMenuButton(
            onSelected: (result) {
              if (result == 0) {
                _onRemove();
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(value: 0, child: Text('??????')),
              ];
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            GFCard(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '??????????????????',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2)),
                  FormDatePicker(
                    inputController: _recordedAt,
                    label: '??????',
                    icon: const Icon(Icons.calendar_month_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '??????????????????';
                      } else if (DateTime.tryParse(value) == null) {
                        return '?????????????????????';
                      }
                      return null;
                    },
                  ),
                  FormSelect(
                    inputController: _timePeriod,
                    label: '??????',
                    icon: const Icon(Icons.access_time_outlined),
                    items: [TimePeriod.am.toLabel(), TimePeriod.pm.toLabel()],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '??????????????????';
                      }
                      return null;
                    },
                    onChanged: _onChangedTimePeriod,
                  ),
                  FormInput(
                    inputController: _systolicPressure,
                    label: '??????',
                    icon: const Icon(Icons.upload_outlined),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '??????????????????';
                      } else if (int.tryParse(value) == null) {
                        return '?????????????????????';
                      }
                      return null;
                    },
                  ),
                  FormInput(
                    inputController: _diastolicPressure,
                    label: '??????',
                    icon: const Icon(Icons.download_outlined),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '??????????????????';
                      } else if (int.tryParse(value) == null) {
                        return '?????????????????????';
                      }
                      return null;
                    },
                  ),
                  FormInput(
                    inputController: _heartRate,
                    label: '??????',
                    icon: const Icon(Icons.monitor_heart_outlined),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '??????????????????';
                      } else if (int.tryParse(value) == null) {
                        return '?????????????????????';
                      }
                      return null;
                    },
                  ),
                  if (_timePeriod.text == TimePeriod.pm.toLabel())
                    FormInput(
                      inputController: _stepCount,
                      label: '??????',
                      icon: const Icon(Icons.directions_walk_outlined),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        } else if (double.tryParse(value) == null) {
                          return '?????????????????????';
                        }
                        return null;
                      },
                    ),
                  FormInput(
                    inputController: _remark,
                    label: '??????',
                    icon: const Icon(Icons.tag_outlined),
                    validator: (value) {
                      return null;
                    },
                  ),
                  FormElevatedButton(
                    text: '??????',
                    onPressed: _onSubmit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
