import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sppamaik/database/kediaman_database.dart';
import 'package:sppamaik/database/kir_database.dart';
import 'package:sppamaik/model/kir_model.dart';
import 'package:sppamaik/util/widgets.dart';

class KirForm extends StatefulWidget {
  final Kir? kir;
  final String? nokp_text;
  const KirForm({Key? key, this.kir, this.nokp_text}) : super(key: key);

  @override
  State<KirForm> createState() => _KirFormState();
}

class _KirFormState extends State<KirForm> {
  Kir? kirs;
  bool isLoading = false;

  //save form dan check validation

  final _formKey = GlobalKey<FormState>();
  String? _nokp;
  String? _nama;
  String? _notelefon;

  @override
  void initState() {
    super.initState();
    _nokp = widget.kir?.nokp ?? widget.nokp_text;
    _nama = widget.kir?.nama ?? '';
    _notelefon = widget.kir?.notelefon ?? '';
  }

  @override
  void dispose() {
    KirDatabase.instance.close();
    KediamanDatabase.instance.close();
    super.dispose();
  } //navigate selepas keluar dari page

  Future refreshSearch(_nokp) async {
    setState(() => isLoading = true);

    kirs = await KirDatabase.instance.readKir(_nokp);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    //final _textcontroller = TextEditingController(text: _nokp);
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
                          'MAKLUMAT KETUA ISI RUMAH',
                          style: SubHeader(),
                        ),
                        buildSizedBox(),
                        buildSizedBox(),
                        builtText('No.Kad Pengenalan'),
                        TextFormField(
                          initialValue: _nokp,
                          //controller: _textcontroller,
                          decoration: buildInputDecoration(),
                          textCapitalization: TextCapitalization.characters,
                          style: textStyleInput(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(12),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Sila Masukkan No.Kad Pengenalan';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _nokp = value!;
                          },
                        ),
                        buildSizedBox(),
                        builtText('Nama'),
                        TextFormField(
                          initialValue: _nama,
                          decoration: buildInputDecoration(),
                          textCapitalization: TextCapitalization.characters,
                          style: textStyleInput(),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Sila Masukkan Nama';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _nama = value!;
                          },
                        ),
                        buildSizedBox(),
                        builtText('No.Telefon'),
                        TextFormField(
                          initialValue: _notelefon,
                          decoration: buildInputDecoration(),
                          textCapitalization: TextCapitalization.characters,
                          style: textStyleInput(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(12),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Sila Masukkan No.Telefon';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _notelefon = value!;
                          },
                        ),
                        buildSizedBox(),
                        buildSizedBox(),
                        ElevatedButton(
                          onPressed: buttonSavePressed,
                          child: widget.kir != null || kirs != null
                              ? Text('Kemaskini')
                              : Text('Simpan'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future addKirToDB() async {
    final kir = Kir(
      nokp: _nokp,
      nama: _nama.toString(),
      notelefon: _notelefon.toString(),
    );
    await KirDatabase.instance.create(kir);
  }

  Future updateKirToDB() async {
    if (widget.kir != null) {
      final kir = widget.kir!.copy(
        nokp: _nokp,
        nama: _nama.toString(),
        notelefon: _notelefon.toString(),
      );
      await KirDatabase.instance.update(kir);
    } else {
      final kir = kirs!.copy(
        nokp: _nokp,
        nama: _nama.toString(),
        notelefon: _notelefon.toString(),
      );
      await KirDatabase.instance.update(kir);
    }
  }

  void buttonSavePressed() async {
    if (!_formKey.currentState!.validate()) {
      print('Form not valid');
    } else {
      _formKey.currentState!.save();

      //save SQLite
      print(_nokp);
      print(_nama);
      print(_notelefon);

      final isUpdate;
      if (widget.kir != null || kirs != null) {
        isUpdate = true;
      } else {
        isUpdate = false;
      }
      print(isUpdate);

      if (isUpdate) {
        await updateKirToDB();
      } else {
        await addKirToDB();
        refreshSearch(_nokp);
      }

      final snackBar =
          SnackBar(content: Text('Maklumat telah berjaya disimpan'));
      //_scaffoldKey.currentState!.showSnackBar(snackBar);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
