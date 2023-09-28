import 'package:e_money/database/db_instance.dart';
import 'package:e_money/database/format.dart';
import 'package:e_money/pages/setting_page.dart';
import 'package:e_money/shared/routes.dart';
import 'package:e_money/shared/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  final int? userId;
  const Main({Key? key, this.userId}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _pemasukan = 0;
  int _pengeluaran = 0;
  List<Map<String, dynamic>> _user = [];

  void _loadPageTransaction() async {
    final pemasukan = await DbInstance.calculateTransaction('pemasukan');
    final pengeluaran = await DbInstance.calculateTransaction('pengeluaran');
    final user = await DbInstance.userLoggedIn(widget.userId);

    setState(() {
      _pemasukan = pemasukan[0]['total'] ?? 0;
      _pengeluaran = pengeluaran[0]['total'] ?? 0;
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPageTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            // height: 500,
            child: Column(
              children: [
                Text(
                  "Rangkuman Bulan Ini",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: bold,
                    color: Colors.red,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 7.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Text(
                        'Pemasukan: Rp',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      Format.convertToIdr(_pemasukan, 0),
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Text(
                        'Pengeluaran: Rp',
                        style: TextStyle(
                          color: Colors.red[700],
                          fontWeight: bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      Format.convertToIdr(_pengeluaran, 0),
                      style: TextStyle(
                        color: Colors.red[700],
                        fontWeight: bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 30,
                        color: primary900.withOpacity(0.2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'images/chart.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 5),
                                child: Card(
                                  color: primary500,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 150.0,
                                        child: InkWell(
                                          onTap: () => {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.routePemasukan,
                                              arguments: <String, int>{
                                                'userId': widget.userId ?? 0,
                                              },
                                            ),
                                          },
                                          child: Ink.image(
                                            image: const AssetImage(
                                              'images/pemasukkan.png',
                                            ),
                                            fit: BoxFit.contain,
                                            width: 137,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: white,
                                          border: Border.all(color: white),
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20.0),
                                              bottomRight:
                                                  Radius.circular(20.0)),
                                        ),
                                        padding: const EdgeInsets.all(10.0),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Tambah Pemasukan",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Card(
                                  color: primary500,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 150.0,
                                        child: InkWell(
                                          onTap: () => {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.routePengeluaran,
                                              arguments: <String, int>{
                                                'userId': widget.userId ?? 0,
                                              },
                                            )
                                          },
                                          child: Ink.image(
                                            image: const AssetImage(
                                              'images/pengeluaran.png',
                                            ),
                                            fit: BoxFit.contain,
                                            width: 135,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: white,
                                          border: Border.all(color: white),
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20.0),
                                              bottomRight:
                                                  Radius.circular(20.0)),
                                        ),
                                        padding: const EdgeInsets.all(10.0),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Tambah Pengeluaran",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Card(
                            color: primary500,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 150.0,
                                  child: InkWell(
                                    onTap: () => {
                                      Navigator.pushNamed(
                                          context, Routes.routeDetail)
                                    },
                                    child: Ink.image(
                                      image: const AssetImage(
                                        'images/detail.png',
                                      ),
                                      fit: BoxFit.contain,
                                      width: 128,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(color: white),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0)),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Detail Cashflow",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Card(
                            color: primary500,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 150.0,
                                  child: InkWell(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Setting(
                                            userId: widget.userId,
                                          ),
                                        ),
                                      )
                                    },
                                    child: Ink.image(
                                      image: const AssetImage(
                                        'images/setting.png',
                                      ),
                                      fit: BoxFit.contain,
                                      width: 135,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(color: white),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0)),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Pengaturan",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
