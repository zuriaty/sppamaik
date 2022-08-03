import 'package:flutter/material.dart';
import 'package:sppamaik/database/kediaman_database.dart';
import 'package:sppamaik/database/kir_database.dart';
import 'package:sppamaik/model/kediaman_model.dart';
import 'package:sppamaik/model/kir_model.dart';
import 'package:sppamaik/page/camera.dart';
import 'package:sppamaik/page/kediaman_list.dart';
import 'package:sppamaik/page/kir_form.dart';
import 'package:sppamaik/page/mainpage.dart';
import 'package:sppamaik/util/strings.dart';
import 'package:sppamaik/page/kediaman_form.dart';

class TabMenu extends StatefulWidget {
  final String? nokp_text;
  const TabMenu({Key? key, this.nokp_text}) : super(key: key);

  @override
  State<TabMenu> createState() => _TabMenuState();
}

class _TabMenuState extends State<TabMenu> {
  late TabController tabController;

  Kediaman? kediamans;
  Kir? kirs;
  bool isLoading = false;
  late String _nokp;

  @override
  void initState() {
    super.initState();
    _nokp = widget.nokp_text ?? '';
    if (_nokp.isNotEmpty) {
      refreshSearchTab();
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    KirDatabase.instance.close();
    KediamanDatabase.instance.close();
    super.dispose();
  } //navigate selepas keluar dari page

  Future refreshSearchTab() async {
    setState(() => isLoading = true);

    kirs = await KirDatabase.instance.readKir(_nokp);
    kediamans = await KediamanDatabase.instance.readKediaman(_nokp);

    print(kirs?.nokp);
    print(kirs?.nama);
    print(kirs?.notelefon);

    print(kediamans?.nokp);
    print(kediamans?.alamat);
    print(kediamans?.poskod);
    print(kediamans?.bandar);

    //return kediamans;
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    int x;
    return DefaultTabController(
        length: 9,
        child: Builder(builder: (BuildContext context) {
          final tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              refreshSearchTab();
              print(tabController.index);
            } else {
              /*KirDatabase.instance.close();
              KediamanDatabase.instance.close();*/
              //tab is finished animating you get the current index
              //here you can get your index or run some method once.
              print(tabController.index);
            }
          });
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red[900],
                title: Text(
                  Strings.appBarTitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                elevation: 0.0,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.home_outlined),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MainPage()));
                    },
                  ),
                ],
                bottom: TabBar(
                  isScrollable: true,
                  /**/
                  indicatorWeight: 2,
                  indicatorColor: Colors.white60,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                  tabs: const [
                    Tab(
                      text: 'Ketua Isi Rumah',
                    ),
                    Tab(
                      text: 'Pasangan',
                    ),
                    Tab(
                      text: 'Tanggungan',
                    ),
                    Tab(
                      text: 'Bukan Tanggungan',
                    ),
                    Tab(
                      text: 'Kediaman',
                    ),
                    Tab(
                      text: 'Bantuan',
                    ),
                    Tab(
                      text: 'Pembangunan',
                    ),
                    Tab(
                      text: 'Pengetahuan Am',
                    ),
                    Tab(
                      text: 'Lokasi & Gambar',
                    ),
                  ],
                ),
              ),
              body: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      child: TabBarView(
                        children: [
                          KirForm(kir: kirs, nokp_text: _nokp),
                          _buildListViewWithName('Pasangan'),
                          _buildListViewWithName('Tanggungan'),
                          KediamanList(),
                          KediamanForm(kir: kirs, kediaman: kediamans),
                          _buildListViewWithName('Tanggungan'),
                          _buildListViewWithName('Tanggungan'),
                          _buildListViewWithName('Tanggungan'),
                          ImageSave(),
                        ],
                      ),
                    ),
            ),
          );
        }));
  }

  ListView _buildListViewWithName(String s) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text('$s $index'),
      ),
    );
  }
}
