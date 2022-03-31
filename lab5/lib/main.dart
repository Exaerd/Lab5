import 'package:flutter/material.dart';

void main() => runApp (
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Калькулятор площади'),
          ),
          body: const MyApp(),
        )
    )
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State {
  final _formKey = GlobalKey<FormState>();

  void findArea () {
    setState(() {
      area = width * height;
      if(_formKey.currentState!.validate()  ) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Форма успешно заполнена"),
                backgroundColor: Colors.indigo
            )
        );
      }
    });
  }

  double width = 0.0;
  double height = 0.0;
  double area = 0.0;

  _width (String text) {
    setState(() => width = double.tryParse(text) ?? 0.0);
  }

  _height(String text){
    setState(() => height = double.tryParse(text) ?? 0.0 );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child:
              Row(
                children: [
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 17, 0),
                    child:
                    Column(
                      children:  const <Widget>[
                        Text('Ширина (мм):', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),

                  Flexible(
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isEmpty) return 'Введите Ширину';
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      onChanged: _width,
                      style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)
                        ),
                      ),
                    ),
                  ),],
              ),
            ),

            Padding(padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child:
              Row(
                children: [
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 22, 0),
                    child:
                    Column(
                      children:  const <Widget>[
                        Text('Высота (мм):', style: TextStyle(fontSize: 18,)),
                      ],
                    ),
                  ),

                  Flexible(
                    child: TextFormField( validator: (value) {
                      if(value!.isEmpty)  return 'Введите Высоту';
                      return null;
                    },
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      onChanged: _height,
                      style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)
                        ),
                      ),
                    ),
                  ),],
              ),
            ),

            Padding(padding: const EdgeInsets.fromLTRB(10, 20, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: findArea,
                    child: const Text('Вычислить'),
                  ),],
              ),
            ),

            Padding(padding: const EdgeInsets.fromLTRB(10, 50, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  height > 0 && width > 0 && area > 0 && (width * height) == area  ? Text('S =  $width * $height = $area (мм^2)',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 23))
                      : height > 0 && width > 0 ? const Text('') : const Text('Задайте параметры', style: TextStyle(color: Colors.red,
                      fontWeight: FontWeight.w500, fontSize: 23))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}