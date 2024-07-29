import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String ilkEkran = "0"; // Ekranda görünen metin
  String islemText = ""; // İşlem göstergesi (örn. "7 + 3")
  double ilkIslem = 0;
  double ikinciIslem = 0;
  String Islem = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CALCULATOR", style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.orange),
        ),
        centerTitle: true,backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // işlem  göstermek için
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Text(
                  islemText,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
               ),
              ),
              // sonuç göstermek için
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    ilkEkran,
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                ),
              ),
              // Butonlar
              Column(
                children: [
                  _buildButtonRow(["AC", "+", "-", "÷"], Colors.white60, Colors.orange),
                  _buildButtonRow(["7", "8", "9", "×"], Colors.white24, Colors.orange),
                  _buildButtonRow(["4", "5", "6", "-"], Colors.white24, Colors.orange),
                  _buildButtonRow(["1", "2", "3", "+"], Colors.white24, Colors.orange),
                  _buildButtonRow(["0", "÷", "×", "="], Colors.white24, Colors.orange),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black54,
    );
  }

  // Yardımcı fonksiyon: Tek bir buton oluşturur
  Widget _buildButton(String text, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {
        _onButtonPressed(text);
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 30, color: textColor),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: Size(75, 75), // Butonların minimum boyutu
        padding: EdgeInsets.all(16.0), // İç boşluk (padding)
      ),
    );
  }

  // Yardımcı fonksiyon: Butonları bir satıra yerleştirir
  Widget _buildButtonRow(List<String> texts, Color bgColor, Color specialBgColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: texts.map((text) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(4.0),
            child: _buildButton(
              text,
              text == "=" || text == "+" || text == "-" || text == "×" || text == "÷" ? specialBgColor : bgColor,
              text == "=" || text == "+" || text == "-" || text == "×" || text == "÷" ? Colors.white : Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }

  // Buton tıklama işlevi
  void _onButtonPressed(String text) {
    if (text == "AC") {
      ilkEkran = "0";
      islemText = "";
      ilkIslem = 0;
      ikinciIslem = 0;
      Islem = "";
    } else if (text == "+" || text == "-" || text == "×" || text == "÷") {
      ilkIslem = double.parse(ilkEkran);
      Islem = text;
      islemText = "${ilkIslem.toString()} $text";
      ilkEkran = "0";
    } else if (text == "=") {
      ikinciIslem = double.parse(ilkEkran);
      _calculateResult();
    } else {
      if (ilkEkran == "0") {
        ilkEkran = text;
      } else {
        ilkEkran += text;
      }
    }
    setState(() {});
  }

  // Hesaplama işlemi
  void _calculateResult() {
    double result;
    switch (Islem) {
      case "+":
        result = ilkIslem + ikinciIslem;
        break;
      case "-":
        result = ilkIslem - ikinciIslem;
        break;
      case "×":
        result = ilkIslem * ikinciIslem;
        break;
      case "÷":
        result = ilkIslem / ikinciIslem;
        break;
      default:
        result = 0;
        break;
    }
    ilkEkran = result.toStringAsFixed(2);
    islemText = "${ilkIslem.toString()} $Islem ${ikinciIslem.toString()} = ${ilkEkran}";
  }
}

/*body: Container(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: (){

                  }, child: const Text("AC",style: TextStyle(
                      fontSize: 30,
                      color: Colors.black),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white60,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("(",style: TextStyle(
                      fontSize: 30,
                      color: Colors.black),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white60, fixedSize: Size.fromWidth(101),),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text(")",style: TextStyle(
                      fontSize: 30,
                      color: Colors.black),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white60,fixedSize: Size.fromWidth(101),),
                  ),

                  ElevatedButton(onPressed: (){

                  }, child: const Text("AC",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,fixedSize: Size.fromWidth(101),),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: (){

                  }, child: const Text("1",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("2",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("3",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("X",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,fixedSize: Size.fromWidth(101)),
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: (){

                  },child: const Text("4",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("5",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("6",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("-",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,fixedSize: Size.fromWidth(101)),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: (){

                  },child: const Text("7",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("8",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("9",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("+",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,fixedSize: Size.fromWidth(101)),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: (){

                  },child: const Text("0",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text(",",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("%",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24,fixedSize: Size.fromWidth(101)),
                  ),
                  ElevatedButton(onPressed: (){

                  }, child: const Text("=",style: TextStyle(
                      fontSize: 30,
                      color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,fixedSize: Size.fromWidth(101)),
                  ),
                ],
              ),
            ],

              )
          ),
        ),
      backgroundColor: Colors.black54,
    );
  }
}*/
