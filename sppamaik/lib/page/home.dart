import 'package:flutter/material.dart';
import 'package:sppamaik/page/tabmenu.dart';

import '../util/router.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Scaffold(
        body: Stack(
          children: [
            backgroud(context),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    header(),
                    search(context),
                    GridView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(16),
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.89,
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          /*return GestureDetector(
                            child: Text('Do not have Account ?'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          add_main()));
                            },
                          );*/
                          if (index == 0) {
                            return itemGrid('assets/images/frontend.jpg',
                                'Daftar Baru', '', context, '/daftar');
                          } else if (index == 1) {
                            return itemGrid('assets/images/edit.jpg',
                                'Senarai KIR', '', context, '/');
                          } else if (index == 2) {
                            return itemGrid('assets/images/backend.jpg',
                                'Muat Naik', '', context, '/');
                          } else {
                            return itemGrid('assets/images/download.jpg',
                                'Muat Turun', '', context, '/');
                          }
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemGrid(String image, String title, String link, BuildContext context,
      String Route) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Route);
          /* Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => TabMenu())
          );*/
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 6,
                color: Colors.black38,
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      letterSpacing: 1),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ));
  }

  Widget search(context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Carian No.Kad Pengenalan',
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.red[900],
                ),
                isDense: true,
                contentPadding: EdgeInsets.all(0),
              ),
              textAlignVertical: TextAlignVertical.center,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Sila masukkan no.kad pengenalan';
                }
                return null;
              },
            ),
          ),
          Container(
            width: 1,
            height: 30,
            color: Colors.red[900],
          ),
          IconButton(
              onPressed: () async {
                /* if (_formKey.currentState!.validate()) {
                  String currentText = _controller.text;
                  // ...do something with currentText
                }*/
                /*await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => KediamanForm(
                      kediaman: '8',
                    ),
                  ),
                );*/
              },
              icon: Icon(Icons.accessibility_rounded))
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Selamat Datang",
                  style: TextStyle(
                      color: Colors.white, fontSize: 24, fontFamily: 'Roboto'),
                ),
                Text(
                  "Sistem SPPA",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/logomaik.png',
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  Widget backgroud(context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.red[900],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        /* image: DecorationImage(
            image: AssetImage('assets/images/bg4.png'), fit: BoxFit.cover),*/
      ),
    );
  }
}

/*
Container(
decoration: BoxDecoration(
image: DecorationImage(image: AssetImage('assets/images/bg.jpg')),
),
),*/
