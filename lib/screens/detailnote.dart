import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notto/constant.dart';
import 'package:notto/model/note_model.dart';
import 'package:notto/service/network_service.dart';
import 'package:notto/utils.dart';

class DetailNote extends StatefulWidget {
  DetailNote({this.note, this.tags = ''});
  final Notes note;
  final String tags;
  final Map<String, TextEditingController> controller = {
    "title": TextEditingController(),
    "notes": TextEditingController()
  };

  @override
  _DetailNoteState createState() => _DetailNoteState();
}

class _DetailNoteState extends State<DetailNote> {
  GlobalKey<ScaffoldState> _sfKey = GlobalKey<ScaffoldState>();
  loadNote() {
    widget.controller['title'].text = widget.note.title ?? '';
    widget.controller['notes'].text = widget.note.notes ?? '';
  }

  @override
  void initState() {
    if (widget.note != null) loadNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.tags,
      child: Scaffold(
        key: _sfKey,
        backgroundColor: stickyColor,
        appBar: AppBar(
          elevation: 0,
          actions: [
            FlatButton(
                color: Colors.blue,
                onPressed: () => saveEdit(
                      id: (widget.note == null) ? null : widget.note.id,
                      title: widget.controller['title'].text,
                      notes: widget.controller['notes'].text,
                    ),
                child: Row(
                  children: [
                    Icon(Icons.save),
                    SizedBox(width: 5),
                    Text('Simpan')
                  ],
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              TextFormField(
                controller: widget.controller['title'],
                decoration:
                    InputDecoration(labelText: "title", hintText: "title"),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                controller: widget.controller['notes'],
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "catatan",
                    hintText: "catatan"),
              )
            ]),
          ),
        ),
      ),
    );
  }

  saveEdit(
      {@required int id,
      @required String title,
      @required String notes}) async {
    var service = NetworkService();
    String msg = '', timeout = '';
    if(title.isEmpty || notes.isEmpty){
        crtSnackbar("title dan catatan tidak boleh kssong");
    }
   else {if (id != null) {
      bool result;
      try {
        result = await service.editNotes(title, notes, id);
      } on SocketException catch (e) {
        if (isTimeOut(e)) timeout = " koneksi terputus";
        debugPrint(e.toString());
      } catch (e) {
        debugPrint("err : "+e.toString());
      }
      (result ?? false)
          ? msg = 'catatan berhasil diubah'
          : msg = 'catatan gagal diubah';
      crtSnackbar(msg+timeout);
    } else {
       bool result;
      try {
        result = await service.addNotes(title, notes);
      } on SocketException catch (e) {
        if (isTimeOut(e)) timeout = " koneksi terputus";
        debugPrint(e.toString());
      } catch (e) {
        debugPrint(e.toString());
      }
      (result ?? false)
          ? msg = 'catatan berhasil ditambahkan'
          : msg = 'catatan gagal ditambahkan';

      crtSnackbar(msg+timeout);
    }
  }}
  crtSnackbar(String msgs)=>_sfKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.white,
          content: Material(
            type: MaterialType.transparency,
            child: Container(
              height: 50,
              child: Center(
                  child: Text(
                msgs,
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
              )),
            ),
          )));
}
