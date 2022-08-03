import 'package:flutter/material.dart';
import 'package:sppamaik/database/kediaman_database.dart';
import 'package:sppamaik/model/kediaman_model.dart';

class KediamanList extends StatefulWidget {
  @override
  State<KediamanList> createState() => _KediamanListState();
}

class _KediamanListState extends State<KediamanList> {
  late List<Kediaman> kediamans;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshKediaman();
  }

  @override
  void dispose() {
    KediamanDatabase.instance.close();
    super.dispose();
  }

  Future refreshKediaman() async {
    setState(() => isLoading = true);

    this.kediamans = await KediamanDatabase.instance.readAllKediaman();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Sistem SPPA - Senarai Tanggungan'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : kediamans.isEmpty
                ? Text('Tiada maklumat dalam database')
                : ListView.builder(
                    itemCount: kediamans.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        kediamans(
                                          kediamans: kediamans[index],
                                        )));*/
                          },
                        ),
                        title: Text(kediamans[index].alamat),
                        subtitle: Text(kediamans[index].poskod),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await KediamanDatabase.instance
                                .delete(kediamans[index].nokp!);

                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

/*
  List<Kediaman>? kediamans; //late initialize kemudian
  bool isLoading = false;

  @override
  void iniState() {
    super.initState();

    refreshKediamans();
  }

  @override
  void dispose() {
    KediamanDatabase.instance.close();
    super.dispose();
  } //navigate selepas keluar dari page

  //perlu dispose tuk save memory
  Future refreshKediamans() async {
    setState(() => isLoading = true);

    this.kediamans = await KediamanDatabase.instance.readAllKediaman();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistem SPPA'),
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : kediamans == null
                ? Text('Tiada rekod kediaman dalam database')
                : ListView.builder(
                    itemCount: kediamans?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(Icons.edit),
                      );
                    },
                  ),
      ),
    );
  }
}
*/
