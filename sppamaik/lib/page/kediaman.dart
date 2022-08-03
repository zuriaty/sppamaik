import 'package:flutter/material.dart';
import 'package:sppamaik/database/kediaman_database.dart';
import 'package:sppamaik/model/kediaman_model.dart';
import 'package:sppamaik/util/widgets.dart';
import 'package:flutter/services.dart';

class KediamanForm extends StatefulWidget {
  final Kediaman? kediaman;

  const KediamanForm({Key? key, this.kediaman, required String nokp_text})
      : super(key: key);
  @override
  State<KediamanForm> createState() => _KediamanFormState();
}

class _KediamanFormState extends State<KediamanForm> {
  //save form dan check validation
  final _formKey = GlobalKey<FormState>();

  /*final amountcontroller=TextEditingController();
  final titlecontroller=TextEditingController();*/

  late TextEditingController _nokp = TextEditingController();
  late TextEditingController _alamat = TextEditingController();
  late TextEditingController _alamat2 = TextEditingController();
  late TextEditingController _alamat3 = TextEditingController();
  late TextEditingController _poskod = TextEditingController();
  late TextEditingController _bandar = TextEditingController();
  late TextEditingController _negeri = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nokp.text = widget.kediaman?.nokp ?? '';
    _alamat.text = widget.kediaman?.nokp ?? '';
    _poskod.text = widget.kediaman?.poskod ?? '';
    _bandar.text = widget.kediaman?.bandar ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MAKLUMAT KEDIAMAN',
                    style: SubHeader(),
                  ),
                  /*        TextFormField(
                    decoration: buildInputDecoration(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _alamat = value!;
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    decoration: buildInputDecoration(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone is required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _poskod = value!;
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    decoration: buildInputDecoration(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _bandar = value!;
                    },
                  ),*/
                  /*  buildSizedBox(),
                  buildSizedBox(),
                  builtText('Alamat'),
                  TextFormField(
                    style: textStyleInput(),
                    decoration: buildInputDecoration(),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: (value) {
                      if (value != '') {
                        if (value!.isEmpty) {
                          return 'Maklumat diperlukan';
                        } else {
                          return null;
                        }
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _alamat = value!;
                    },
                  ),
                  buildSizedBox(),
                  builtText('Poskod'),
                  TextFormField(
                    style: textStyleInput(),
                    decoration: buildInputDecoration(),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: (value) {
                      if (value != '') {
                        if (value!.isEmpty) {
                          return 'Maklumat diperlukan';
                        } else {
                          return null;
                        }
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _poskod = value!;
                    },
                  ),
                  buildSizedBox(),
                  builtText('Bandar'),
                  TextFormField(
                    style: textStyleInput(),
                    decoration: buildInputDecoration(),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    validator: (value) {
                      if (value != '') {
                        if (value!.isEmpty) {
                          return 'Maklumat  diperlukan';
                        } else {
                          return null;
                        }
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _bandar = value!;
                    },
                  ),*/
                  buildSizedBox(),
                  buildSizedBox(),
                  /*builtText('No.Kad Pengenalan'),
                  buildTextFormFieldUpperCase(100, _nokp, 'no.kad pengenalan'),
                  buildSizedBox(),
                  builtText('Alamat'),
                  buildTextFormFieldUpperCase(100, _alamat, 'alamat'),
                  buildSizedBox(),
                  buildTextFormFieldUpperCase(100, _alamat2, ''),
                  buildSizedBox(),
                  buildTextFormFieldUpperCase(100, _alamat3, ''),
                  buildSizedBox(),
                  builtText('Poskod'),
                  buildTextFormFieldNumber(5, _poskod, 'poskod'),
                  buildSizedBox(),
                  builtText('Bandar'),
                  buildTextFormFieldUpperCase(50, _bandar, 'bandar'),
                  buildSizedBox(),
                  builtText('Negeri'),
                  buildTextFormFieldUpperCase(50, _negeri, 'negeri'),*/
                  buildSizedBox(),
                  /**/
                  ElevatedButton(
                    onPressed: buttonSavePressed,
                    child: Text('Save'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future addKediamanToDB() async {
    final kediaman = Kediaman(
      nokp: _nokp.text,
      alamat: _alamat.text,
      poskod: _poskod.text,
      bandar: _bandar.text,
    );
    await KediamanDatabase.instance.create(kediaman);
  }

  void buttonSavePressed() async {
    if (!_formKey.currentState!.validate()) {
      print('Form not valid');
    } else {
      _formKey.currentState!.save();

      //save SQLite
      print(_nokp.text);
      print(_alamat.text);
      print(_poskod.text);
      print(_bandar.text);

      await addKediamanToDB();
      final snackBar = SnackBar(content: Text('Form submited'));
      //_scaffoldKey.currentState!.showSnackBar(snackBar);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
