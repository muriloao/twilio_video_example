import 'package:flutter/material.dart';
import 'package:twilio_test/conference/conference_page.dart';
import 'package:twilio_test/models/twilio_enums.dart';
import 'package:twilio_test/room/room_model.dart';

void main() {
  runApp(MyApp());
}

const TWILIO_TOKEN = 'your twilio token here';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twilio test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Twilio videocall test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _usernameController = TextEditingController(
      text: 'ADAM#' + DateTime.now().millisecondsSinceEpoch.toString());
  final TextEditingController _roomNameController =
      TextEditingController(text: 'test-room');
  TwilioRoomType _roomType = TwilioRoomType.peerToPeer;

  final _formKey = GlobalKey<FormState>();

  _connectToRoom() {
    if (this._formKey.currentState.validate()) {
      final roomModel = RoomModel(
        identity: this._usernameController.text,
        name: this._roomNameController.text,
        token: TWILIO_TOKEN,
        type: this._roomType,
      );
      Navigator.of(context).push(
        MaterialPageRoute<ConferencePage>(
          fullscreenDialog: true,
          builder: (BuildContext context) =>
              ConferencePage(roomModel: roomModel),
        ),
      );
    }
  }

  final validator =
      (String value) => value?.isEmpty == true ? 'Required' : null;

  _onSelectRoomType(value) {
    setState(() {
      this._roomType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Twilio videocall test'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: this._formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                validator: validator,
                decoration: InputDecoration(labelText: 'input your username'),
              ),
              TextFormField(
                controller: _roomNameController,
                validator: validator,
                decoration: InputDecoration(labelText: 'input room name'),
              ),
              DropdownButton(
                  underline: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  isExpanded: true,
                  items: TwilioRoomType.values.map<DropdownMenuItem<TwilioRoomType>>(
                      (TwilioRoomType value) {
                    return DropdownMenuItem<TwilioRoomType>(
                      value: value,
                      child: Text(RoomModel.getTypeText(value)),
                    );
                  }).toList(),
                  value: this._roomType,
                  onChanged: this._onSelectRoomType,
                ),
              RaisedButton.icon(
                onPressed: this._connectToRoom,
                color: Colors.blue[400],
                icon: Icon(Icons.video_call),
                label: Text('Start Videocall'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
