import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart' as auth;

class AddTrans extends StatefulWidget {
  const AddTrans({super.key});

  @override
  State<AddTrans> createState() => _AddTransState();
}

class _AddTransState extends State<AddTrans> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _createGoogleDoc() async {
    // Аутентификация пользователя
    var client = await auth.clientViaUserConsent(
      auth.ClientId('419675828315-uohlvf2dcieap19ks9k6k9ibq4tqudtr.apps.googleusercontent.com', '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'),
      ['https://www.googleapis.com/auth/drive.file'],
      (url) {
        // Отобразите URL для подтверждения пользователем
        print("Please go to $url");
      },
    );


     // Создание Google Docs документа
    var driveApi = drive.DriveApi(client);

    var fileMetadata = drive.File()
      ..name = 'example-fluter12'
      ..mimeType = 'application/vnd.google-apps.document';

    var result = await driveApi.files.create(fileMetadata);
    print('Google Docs document created with ID: ${result.id}');

    // Закройте клиент после использования
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
      ),
      body: SafeArea(
          child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'How much?',
                style: TextStyle(
                  color: Color(0xFF090000),
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Введите логин",
                          helperText: "Логин используется для входа в систему",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            
                            _createGoogleDoc();
                          }
                        },
                        child: Text('Submit'))
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
