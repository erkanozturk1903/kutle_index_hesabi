import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController agirlikController = TextEditingController();
  TextEditingController boyController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _bilgiText = "Verilerinizi Giriniz";

  void _alanlariTemizle() {
    agirlikController.text = "";
    boyController.text = "";
    setState(() {
      _bilgiText = "Verilerinizi Giriniz";
    });
  }

  void _hesapla() {
    setState(() {
      double agirlik = double.parse(agirlikController.text);
      double boy = double.parse(boyController.text) / 100;
      double kih = agirlik / (boy * boy);
      if (kih < 18.6) {
        _bilgiText =
            "İdeal Kilonuzun Altındasınız (${kih.toStringAsPrecision(4)})";
      } else if (kih >= 18.6 && kih < 24.9) {
        _bilgiText = "İdeal Kilonuzdasınız (${kih.toStringAsPrecision(4)})";
      } else if (kih >= 24.6 && kih < 29.9) {
        _bilgiText =
            "İdeal Kilonuzun Üstündesiniz (${kih.toStringAsPrecision(4)})";
      } else if (kih >= 29.9 && kih < 34.9) {
        _bilgiText = "Obozite Seviye I (${kih.toStringAsPrecision(4)})";
      } else if (kih >= 34.9 && kih < 39.9) {
        _bilgiText = "Obozite Seviye II (${kih.toStringAsPrecision(4)})";
      } else if (kih >= 40) {
        _bilgiText = "Obozite Seviye III (${kih.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Kütle İndeks Hesaplama',
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: _alanlariTemizle,
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.green,
                ),
                TextFormField(
                  controller: agirlikController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Kilo (Kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25.0),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen Kilonuzu Giriniz";
                    }
                  },
                ),
                TextFormField(
                  controller: boyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Boy(cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25.0),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen Boyunuzu Giriniz";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _hesapla();
                      }
                    },
                    child: const Text(
                      'Hesapla',
                      style: TextStyle(fontSize: 25),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _bilgiText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
