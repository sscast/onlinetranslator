import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedantic/pedantic.dart';
import 'package:translatetest/post.dart';
import 'package:translatetest/util/show_exception_alert_dialog.dart';
import 'package:translator/translator.dart';
import 'package:translatetest/footer.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({Key? key, this.post}) : super(key: key);
  final Post? post;

  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final _formKey = GlobalKey<FormState>();

  String? _content;
  String? uid;

  TextEditingController? _controller;
  TextEditingController? _translateController;

  late bool showTranslation;
  bool? isTranslated;
  final GoogleTranslator translator = GoogleTranslator();
  String? _translated;
  Map<String, String> languagesList = {
    // "Cantonese": "zh-hk", //not surported by Google API
    "Original": "auto",
    "Chinese (Simplified)": "zh-cn",
    "Chinese (Traditional)": "zh-tw",
    "English": "en",
    'Hebrew': "iw",
    'Italian': "it",
    'Japanese': "ja",
    "Spanish": "es",
    "French": "fr",
    'Russian': "ru",
  };

  String? _toLanguageCode;
  List<String> _dropdownMenuItems = [
    // "Cantonese",
    "Chinese (Simplified)",
    "Chinese (Traditional)",
    "English",
    "French",
    'Hebrew',
    'Italian',
    'Japanese',
    'Russian',
    "Spanish",
  ];
  String? _selectedLanguage;
  int selectedLanguageIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      // _title = widget.post?.title ?? "";
      // _content = widget.post?.content ?? "";
      // languagesList.forEach((key, value) => _dropdownMenuItems.add(key));
      _translated = widget.post?.translated ?? "";
      if (_translated == null || _translated == "") {
        isTranslated = false;
      } else {
        isTranslated = true;
      }
      _selectedLanguage = _dropdownMenuItems[selectedLanguageIndex];
      _toLanguageCode = languagesList[_selectedLanguage!] ?? 'en';

      showTranslation = false;
    }
  }

  // List<String> getLanguageList(Map languagesmap) {
  //   List<String> result = [];
  //   languagesmap.forEach((key, value) {
  //     result.add(key);
  //   });
  //   return result;
  // }

  Future<void> _translate(String? text, String code) async {
    if (isTranslated == false)
      try {
        Translation translation =
            await translator.translate(text!, from: 'auto', to: code);

        setState(() {
          _translated = translation.text;
          isTranslated = true;
        });

        print("_translated: $_translated");
      } catch (e) {
        unawaited(showExceptionAlertDialog(
          context: context,
          title: 'Operation failed',
          exception: e,
        ));
      }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: false,
          snap: false,
          floating: true,
          backgroundColor: Colors.blue[900],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text("Online Translator"),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.blue,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.0, 0.5],
                  ),
                ),
                child: _buildContents(),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      // TextFormField(
      //   textAlign: TextAlign.start,
      //   decoration: InputDecoration(
      //     labelText: 'Title',
      //     alignLabelWithHint: true,
      //     border: OutlineInputBorder(
      //       gapPadding: 2,
      //       borderSide: BorderSide(
      //         style: BorderStyle.none,
      //       ),
      //     ),
      //   ),
      //   keyboardAppearance: Brightness.light,
      //   initialValue: _title,
      //   validator: (value) => value.isNotEmpty ? null : 'Title can\'t be empty',
      // ),
      TextFormField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            labelText: 'Original Text',
            fillColor: Colors.grey[50],
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              gapPadding: 2,
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            // labelText: "INPUT",
            hintText: 'Enter text here'),
        keyboardType: TextInputType.multiline,
        controller: _controller,
        minLines: 6,
        maxLines: 6,
        showCursor: true,
        initialValue: _content,
        // onSaved: (value) => _content = value ?? _controller.text,
        onChanged: (value) {
          setState(() {
            _content = value;
          });
        },
      ),
      Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Language",
                    fillColor: Colors.blue[200]),
                value: _selectedLanguage ?? "English",
                onChanged: (dynamic value) {
                  setState(() {
                    _selectedLanguage =
                        value ?? _dropdownMenuItems[selectedLanguageIndex];
                    _toLanguageCode =
                        languagesList[_selectedLanguage!] ?? "auto";
                    isTranslated = false;
                    // selectedLanguageIndex = _selectedLanguage.indexOf(value);
                  });
                },
                // onChanged: (String value) {
                //   setState(() {
                //     _selectedLanguage = value;
                //   });
                // },
                items: _dropdownMenuItems
                    .map((language) => DropdownMenuItem(
                        value: language, child: Text("$language")))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      FloatingActionButton(
        onPressed: () async {
          if (_content != null)
            await _translate(_content, '${_toLanguageCode ?? "en"}');
          setState(() {
            showTranslation = !showTranslation;
          });
        },
        child: IconButton(
          icon: Icon(
            Icons.translate_rounded,
            color: Colors.white,
          ),
          onPressed: () async {
            if (_content != null)
              await _translate(_content, '${_toLanguageCode ?? "en"}');

            setState(() {
              showTranslation = !showTranslation;
            });
          },
        ),
        backgroundColor: Colors.blue,
      ),
      if (showTranslation)
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: TextFormField(
            textAlign: TextAlign.start,
            decoration: InputDecoration(
                labelText: 'Translation',
                fillColor: Colors.grey[50],
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  gapPadding: 2,
                  borderSide: BorderSide(style: BorderStyle.none),
                ),
                hintText: 'Translation can be edited here'),
            keyboardType: TextInputType.multiline,
            controller: _translateController,
            minLines: 6,
            maxLines: 6,
            showCursor: true,
            initialValue: _translated ?? "",
            onSaved: (value) =>
                _translated = value ?? _translateController!.text,
            onChanged: (value) {
              setState(() {
                _translated = value;
              });
            },
          ),
        ),
      Container(child: Footer()),
    ];
  }
}
