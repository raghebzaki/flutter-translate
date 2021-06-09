
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'LanguagesList.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class TranslateScreen extends StatefulWidget {
  @override
  _TranslateScreenState createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {

  GoogleTranslator translator = new GoogleTranslator();

  Translation out;
  final inputLang=TextEditingController();
  final outLang=TextEditingController();

  void trans(String selectedInputLang,String selectedOutLang)
  {

    translator.translate(inputLang.text, from: selectedInputLang,to: selectedOutLang)
        .then((output)
    {
      setState(() {
        out= output;
        outLang.text=out.text;
      });
      print(output);
    });
  }


  stt.SpeechToText _speech;
  bool _isListening = false;

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            inputLang.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }


  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    inputLang.addListener(controllerListener);
  }


  void controllerListener(){
    print(inputLang.text);
    setState(() {

      if(dropdownValueInput==spinnerItems[0])
      {
        cheak('ar');
      }else if(dropdownValueInput==spinnerItems[1])
      {
        cheak('en');
      }else if(dropdownValueInput==spinnerItems[2])
      {
        cheak('de');
      }else if(dropdownValueInput==spinnerItems[3])
      {
        cheak('es');
      }else if(dropdownValueInput==spinnerItems[4])
      {
        cheak('fr');
      }else if(dropdownValueInput==spinnerItems[5])
      {
        cheak('it');
      }else if(dropdownValueInput==spinnerItems[6])
      {
        cheak('pt');
      }else if(dropdownValueInput==spinnerItems[7])
      {
        cheak('ja');
      }else if(dropdownValueInput==spinnerItems[8])
      {
        cheak('hi');
      }else if(dropdownValueInput==spinnerItems[9])
      {
        cheak('ru');
      }
    });
  }

  void cheak(String inputlanguageCode){
    switch(dropdownValueOut){
      case 'arabic': trans(inputlanguageCode,'ar');
      break;
      case 'english': trans(inputlanguageCode,'en');
      break;
      case 'german': trans(inputlanguageCode,'de');
      break;
      case 'spain': trans(inputlanguageCode,'es');
      break;
      case 'french': trans(inputlanguageCode,'fr');
      break;
      case 'italian': trans(inputlanguageCode,'it');
      break;
      case 'Portuguese': trans(inputlanguageCode,'pt');
      break;
      case 'Japanese': trans(inputlanguageCode,'ja');
      break;
      case 'Hindi': trans(inputlanguageCode,'hi');
      break;
      case 'Russian': trans(inputlanguageCode,'ru');
      break;

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('translate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: dropdownValueInput,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 25,
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  onChanged: (String data) {
                    setState(() {
                      dropdownValueInput = data;
                    });
                  },
                  items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 10,),
                Icon(
                    Icons.translate, color: Colors.black
                ),
                SizedBox(width: 10,),
                DropdownButton(
                  value: dropdownValueOut,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 25,
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  onChanged: (String data) {
                    setState(() {
                      dropdownValueOut = data;
                    });
                  },
                  items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],

            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    //width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 1,),
                    ),
                    child: TextField(
                      
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'enter text',
                      ),
                      style: TextStyle( fontSize: 20),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: inputLang,

                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: _listen,
                    child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  ),
                ),
              ],
            ),

          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 1,),
            ),
            child: TextField(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.blueAccent, fontSize: 20,),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: outLang,
            ),
          ),
          ],
        ),
      ),
    );
  }
}
