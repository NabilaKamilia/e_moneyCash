import 'package:e_money/database/db_instance.dart';
import 'package:e_money/database/format.dart';
import 'package:e_money/shared/theme.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<Map<String, dynamic>> _transactions = [];

  void _loadPageTransaction() async {
    final data = await DbInstance.fetchTransactions();
    setState(() {
      _transactions = data;
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
      backgroundColor: primary200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .14,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          "Detail Cashflow",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, top: 56),
                        child: IconButton(
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(right: 25.0),
                    width: 370,
                    height: 110,
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: black),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Icon(
                            _transactions[index]['category'] == 'pemasukan'
                                ? Icons.add
                                : Icons.minimize,
                            color:
                                _transactions[index]['category'] == 'pemasukan'
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Rp",
                                      style: TextStyle(
                                        color: _transactions[index]
                                                    ['category'] ==
                                                'pemasukan'
                                            ? successColor
                                            : errorColor,
                                        fontSize: 20,
                                        fontWeight: bold,
                                      ),
                                    ),
                                    Text(
                                      Format.convertToIdr(
                                          _transactions[index]['nominal'], 0),
                                      style: TextStyle(
                                        color: _transactions[index]
                                                    ['category'] ==
                                                'pemasukan'
                                            ? successColor
                                            : errorColor,
                                        fontSize: 20,
                                        fontWeight: bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  _transactions[index]['description'],
                                  style: TextStyle(
                                      fontSize: 18, color: primary600),
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Text(_transactions[index]['date'],
                                    style: TextStyle(
                                        fontSize: 18, color: primary800)),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              _transactions[index]['category'] == 'pemasukan'
                                  ? Icons.arrow_back
                                  : Icons.arrow_forward,
                              color: _transactions[index]['category'] ==
                                      'pemasukan'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: _transactions.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
