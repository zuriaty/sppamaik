import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sppamaik/database/kediaman_database.dart';
import 'package:sppamaik/database/kir_database.dart';
import 'package:sppamaik/model/kediaman_model.dart';
import 'package:sppamaik/model/kir_model.dart';
import 'package:sppamaik/util/widgets.dart';

class KediamanForm extends StatefulWidget {
  final Kediaman? kediaman;
  final Kir? kir;
  const KediamanForm({Key? key, this.kediaman, this.kir}) : super(key: key);

  @override
  State<KediamanForm> createState() => _KediamanFormState();
}

class _KediamanFormState extends State<KediamanForm> {
  bool isLoading = false;

  //save form dan check validation
  final _formKey = GlobalKey<FormState>();

  String? _nokp;
  String? _nama;
  String? _alamat;
  String? _alamat2;
  String? _alamat3;
  String? _poskod;
  String? _bandar;
  String? _negeri;

  @override
  void initState() {
    super.initState();
    _nokp = widget.kir?.nokp ?? '';
    _nama = widget.kir?.nama ?? '';
    _alamat = widget.kediaman?.alamat ?? '';
    _poskod = widget.kediaman?.poskod ?? '';
    _bandar = widget.kediaman?.bandar ?? '';
  }

  @override
  void dispose() {
    KirDatabase.instance.close();
    KediamanDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
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
                        buildSizedBox(),
                        builtText('No.Kad Pengenalan'),
                        TextFormField(
                          initialValue: _nokp,
                          readOnly: true,
                          decoration: buildInputDecoration(),
                          textCapitalization: TextCapitalization.characters,
                          style: textStyleInput(),
                        ),
                        buildSizedBox(),
                        builtText('Nama'),
                        TextFormField(
                          initialValue: _nama,
                          readOnly: true,
                          decoration: buildInputDecoration(),
                          textCapitalization: TextCapitalization.characters,
                          style: textStyleInput(),
                        ),
                        buildSizedBox(),
                        builtText('Alamat'),
                        TextFormField(
                          initialValue: _alamat,
                          decoration: buildInputDecoration(),
                          textCapitalization: TextCapitalization.characters,
                          style: textStyleInput(),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Sila Masukkan Alamat';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _alamat = value!;
                          },
                        ),
                        buildSizedBox(),
                        TextFormField(
                          initialValue: _alamat2,
                          decoration: buildInputDecoration(),
                          textCapitalization: TextCapitalization.characters,
                          style: textStyleInput(),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          onSaved: (value) {
                            _alamat2 = value!;
                          },
                        ),
                        buildSizedBox(),
                        TextFormField(
                          initialValue: _alamat3,
                          decoration: buildInputDecoration(),
                          textCapitalization: TextCapitalization.characters,
                          style: textStyleInput(),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          onSaved: (value) {
                            _alamat3 = value!;
                          },
                        ),
                        buildSizedBox(),
                        builtText('Poskod'),
                        TextFormField(
                          initialValue: _poskod,
                          decoration: buildInputDecoration(),
                          textCapitalization: TextCapitalization.characters,
                          style: textStyleInput(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(5),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Sila Masukkan Poskod';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _poskod = value!;
                          },
                        ),
                        buildSizedBox(),
                        builtText('Bandar'),
                        TextFormField(
                          initialValue: _bandar,
                          decoration: buildInputDecoration(),
                          textCapitalization: TextCapitalization.characters,
                          style: textStyleInput(),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Sila Masukkan Bandar';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _bandar = value!;
                          },
                        ),
                        buildSizedBox(),
                        builtText('Negeri'),
                        TextFormField(
                          initialValue: _negeri,
                          decoration: buildInputDecoration(),
                          textCapitalization: TextCapitalization.characters,
                          style: textStyleInput(),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Sila Masukkan Negeri';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _negeri = value!;
                          },
                        ),
                        buildSizedBox(),
                        buildSizedBox(),
                        ElevatedButton(
                          onPressed: _nokp == null ? null : buttonSavePressed,
                          child: widget.kediaman == null
                              ? Text('Simpan')
                              : Text('Kemaskini'),
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
      nokp: _nokp,
      alamat: _alamat.toString(),
      poskod: _poskod.toString(),
      bandar: _bandar.toString(),
    );
    await KediamanDatabase.instance.create(kediaman);
  }

  Future updateKediamanToDB() async {
    final kediaman = widget.kediaman!.copy(
      nokp: _nokp,
      alamat: _alamat.toString(),
      poskod: _poskod.toString(),
      bandar: _bandar.toString(),
    );
    await KediamanDatabase.instance.update(kediaman);
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

      final isUpdate = widget.kediaman != null;
      print(isUpdate);

      if (isUpdate) {
        await updateKediamanToDB();
      } else {
        await addKediamanToDB();
      }
      final snackBar =
          SnackBar(content: Text('Maklumat telah berjaya disimpan'));
      //_scaffoldKey.currentState!.showSnackBar(snackBar);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
