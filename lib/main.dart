import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("CALCULATOR APP"),
        ),
        body: const Caculator(),
      ),
    );
  }
}

class Caculator extends StatefulWidget {
  const Caculator({Key? key}) : super(key: key);

  @override
  State<Caculator> createState() => _CaculatorState();
}

class _CaculatorState extends State<Caculator> {
  String bieuThuc = '';
  String ketQua = "";
  String message = "";

  tach() async {
    print("----");
    print(bieuThuc);
    if(bieuThuc.contains(new RegExp(r'[a-z]'))){
      setState(() {
        message = "lỗi nhập chữ";
      });
      throw "lỗi nhập chữ";
    }

    List<String> s1 = ["+", "-", "*", "/"];
    List<String> a = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    for (int i = 1; i < bieuThuc.length; i++) {
      if (s1.contains(bieuThuc[i]) && s1.contains(bieuThuc[i - 1])) {
        setState(() {
          message = "ThuaThieutoantu";
        });
        throw "ThuaThieutoantu";
      }
    }
    List<String> k = [];
    for (int i = 0; i < bieuThuc.length; i++) {
      if (bieuThuc[i] == '(') {
        k.add(bieuThuc[i]);
        if (i > 0 &&
            !s1.contains(bieuThuc[i - 1]) &&
            a.contains(bieuThuc[i - 1])) {
          setState(() {
            message = "ThuaThieutoantu";
          });
          throw "ThuaThieutoantu";
        }
        if (i < bieuThuc.length - 1 && s1.contains(bieuThuc[i + 1])) {
          setState(() {
            message = "ThuaThieutoantu";
          });
          throw "ThuaThieutoantu";
        }
      } else if (bieuThuc[i] == ')') {
        if (k.isNotEmpty) {
          k.removeAt(k.length - 1);
          if (i < bieuThuc.length - 1 &&
              !s1.contains(bieuThuc[i + 1]) &&
              a.contains(bieuThuc[i + 1])) {
            setState(() {
              message = "ThuaThieutoantu";
            });
            throw "ThuaThieutoantu";
          }
          if (i > 0 && s1.contains(bieuThuc[i - 1])) {
            setState(() {
              message = "ThuaThieutoantu";
            });
            throw "ThuaThieutoantu";
          }
        } else {
          setState(() {
            message = "ThuaThieutoantu";
          });
          throw "ThuaThieutoantu";
        }
      }
    }
    if (k.isNotEmpty) {
      setState(() {
        message = "ThuaThieutoantu";
      });
      throw "ThuaThieutoantu";
    }
    k.clear();
    int i = 0;
    while (i < bieuThuc.length) {
      if (s1.contains(bieuThuc[i]) ||
          bieuThuc[i] == '(' ||
          bieuThuc[i] == ')') {
        bieuThuc = bieuThuc.substring(0, i) +
            " " +
            bieuThuc[i] +
            " " +
            bieuThuc.substring(i + 1, bieuThuc.length);
        i += 3;
      } else {
        i++;
      }
    }
    if (s1.contains(bieuThuc) || s1.contains(bieuThuc[bieuThuc.length - 1])) {
      message = "lỗi bt";
      throw "lỗi bt";
    }
    String kq = chuyenVeHauToVaTinh(bieuThuc);
    if (kq == "erorr") {
      setState(() {
        message = "loichia0";
      });
      throw "loichia0";
    }
    if (bieuThuc.length == 1) {
      setState(() {
        ketQua = double.parse(bieuThuc).toString();
      });
    } else {
      setState(() {
        ketQua = kq;
      });
    }
  }

  String tinh(double a, double b, String method) {
    if (method == "*") {
      return (a * b).toString();
    } else if (method == "/") {
      if (b != 0)
        return (a / b).toString();
      else
        return ("erorr");
    } else if (method == "-") {
      return (a - b).toString();
    } else {
      return (a + b).toString();
    }
  }

  int doUuTien(String s1) {
    if (s1 == "*" || s1 == "/")
      return 3;
    else if (s1 == "+" || s1 == "-") return 2;
    return 1;
  }

  String chuyenVeHauToVaTinh(String bt) {
    print(bt);
    List<String> st = [];
    List<String> s1 = [];
    List<String> s4 = ["+", "-", "*", "/"];
    List<String> a = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    List<String> tempBt = bt.split(" ");
    for(int i =0; i< tempBt.length; i++){
      tempBt[i] = tempBt[i].trim();
    }
    print(tempBt);
    for (int i = 0; i < tempBt.length; i++) {
      if(tempBt[i].isEmpty) continue;
      // print("-------------------------------------");
      // print(tempBt[i]);
      // print("s1 ---------------:" + s1.toString());
      // print("st-----------------:" + st.toString());
      if (a.contains(tempBt[i][0])) {
        s1.add(tempBt[i]);
      } else if (tempBt[i] == "(")
        st.add("(");
      else if (tempBt[i] == ")") {
        while (st.isNotEmpty && st[st.length - 1] != "(") {
          s1.add(st[st.length - 1]);
          st.removeAt(st.length - 1);
        }
        st.removeAt(st.length - 1);
      } else if (s4.contains(tempBt[i])) {
        while (
            st.isNotEmpty && doUuTien(tempBt[i]) <= doUuTien(st[st.length - 1])) {
          s1.add(st[st.length - 1]);
          st.removeAt(st.length - 1);
        }
        st.add(tempBt[i]);
      }
    }
    while (st.isNotEmpty) {
      s1.add(st[st.length - 1]);
      st.removeAt(st.length - 1);
    }
    int i = 0;
    String t = "";
    if (s1.length == 1) return double.parse(s1[0]).toString();
    while (s1.length > 1) {
      if (s4.contains(s1[i])) {
        t = tinh(double.parse(s1[i - 2]), double.parse(s1[i - 1]), s1[i]);
        if (t == "erorr") return t;
        s1[i - 2] = t.toString();
        s1.removeAt(i - 1);
        s1.removeAt(i - 1);
        i = 0;
      } else
        i++;
    }
    return t;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 30,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text(ketQua))),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                onChanged: (value) {
                  bieuThuc = value;
                  setState(() {
                    message = "";
                  });
                },
              ),
            ),
            InkWell(
              onTap: () {
                tach();
              },
              child: Container(
                height: 30,
                width: 100,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text("kết quả")),
              ),
            )
          ],
        ),
        message.isEmpty ? SizedBox() : Text("Lỗi:   ${message}")
      ],
    ));
  }
}
