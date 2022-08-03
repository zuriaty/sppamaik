import 'package:flutter/material.dart';
import 'package:sppamaik/database/kediaman_database.dart';
import 'package:sppamaik/model/kediaman_model.dart';
import 'package:sppamaik/util/widgets.dart';

class KediamanTest extends StatefulWidget {
  final Kediaman? kediaman;
  final String? nokp_text;
  const KediamanTest({Key? key, required this.kediaman, this.nokp_text})
      : super(key: key);

  @override
  State<KediamanTest> createState() => _KediamanTestState();
}

class _KediamanTestState extends State<KediamanTest> {
  //List<Kediaman>? kediamans; //late initialize kemudian
  //String<Kediaman>? kediamans;
  Kediaman? kediamans;
  bool isLoading = false;

  //save form dan check validation
  final _formKey = GlobalKey<FormState>();

/**/
  late String _nokp;
  late String _alamat;
  late String _poskod;
  late String _bandar;

/*  late TextEditingController _nokp = TextEditingController();
  late TextEditingController _alamat = TextEditingController();
  late TextEditingController _alamat2 = TextEditingController();
  late TextEditingController _alamat3 = TextEditingController();
  late TextEditingController _poskod = TextEditingController();
  late TextEditingController _bandar = TextEditingController();
  late TextEditingController _negeri = TextEditingController();*/

  @override
  void initState() {
    super.initState();
    _nokp = widget.nokp_text ?? '';
    refreshBlog();
  }

  @override
  void dispose() {
    KediamanDatabase.instance.close();
    super.dispose();
  } //navigate selepas keluar dari page

  //perlu dispose tuk save memory

  Future refreshBlog() async {
    setState(() => isLoading = true);

    kediamans = await KediamanDatabase.instance.readKediaman(_nokp);

    _nokp = kediamans?.nokp ?? '';
    _alamat = kediamans?.alamat ?? '';
    _poskod = kediamans?.poskod ?? '';
    _bandar = kediamans?.bandar ?? '';

    print(kediamans?.nokp);
    print(kediamans?.alamat);
    print(kediamans?.poskod);
    print(kediamans?.bandar);

    setState(() => isLoading = false);
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
                  buildSizedBox(),
                  TextFormField(
                    initialValue: _nokp,
                    decoration: buildInputDecoration(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _nokp = value!;
                    },
                  ),
                  /*
                  SizedBox(height: 15.0),
                  TextFormField(
                    initialValue: _alamat,
                    decoration: buildInputDecoration(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone is required';
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
                    initialValue: kediamans?.poskod,
                    decoration: buildInputDecoration(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
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
                    initialValue: kediamans?.bandar,
                    decoration: buildInputDecoration(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone is required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _bandar = value!;
                    },
                  ),

                  */
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
                  ),*/ /*buildSizedBox(),
                  buildSizedBox(),
                  builtText('No.Kad Pengenalan'),
                  buildTextFormFieldUpperCase(100, _nokp, 'no.kad pengenalan',kediamans?.bandar),
                  buildSizedBox(),
                  builtText('Alamat'),
                  buildTextFormFieldUpperCase(
                      100, _alamat, 'alamat', _alamat.text),
                  buildSizedBox(),
                  */

                  /*buildTextFormFieldUpperCase(100, _alamat2, '', _alamat.text),
                  buildSizedBox(),
                  buildTextFormFieldUpperCase(100, _alamat3, '', _alamat.text),
                  buildSizedBox(),
                  builtText('Poskod'),
                  buildTextFormFieldNumber(5, _poskod, 'poskod', _alamat.text),
                  buildSizedBox(),
                  builtText('Bandar'),
                  buildTextFormFieldUpperCase(50, _bandar, 'bandar', _alamat.text),
                  buildSizedBox(),
                  builtText('Negeri'),
                  buildTextFormFieldUpperCase(50, _negeri, 'negeri', _alamat.text),*/ /**/ /*
                  buildSizedBox(),*/
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

  /*Future addKediamanToDB() async {
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
}*/

  Future addKediamanToDB() async {
    final kediaman = Kediaman(
      nokp: _nokp,
      alamat: _alamat,
      poskod: _poskod,
      bandar: _bandar,
    );
    await KediamanDatabase.instance.create(kediaman);
  }

  void buttonSavePressed() async {
    if (!_formKey.currentState!.validate()) {
      print('Form not valid');
    } else {
      _formKey.currentState!.save();

      //save SQLite
      print(_nokp);
      print(_alamat);
      print(_poskod);
      print(_bandar);

      await addKediamanToDB();
      final snackBar = SnackBar(content: Text('Form submited'));
      //_scaffoldKey.currentState!.showSnackBar(snackBar);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
