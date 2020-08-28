import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notto/model/note_model.dart';
import 'package:notto/service/network_service.dart';
import 'package:notto/service/sharepref_service.dart';

import '../utils.dart';
import 'detailnote.dart';
import 'logres.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _sfKey = GlobalKey<ScaffoldState>();
  List<Notes> listNote;
  bool isDragged = false;
  bool isThisTimeOut = false;
  @override
  Widget build(BuildContext context) {
    getListNotes();
    return Stack(children: [
      Scaffold(
        key: _sfKey,
        appBar: AppBar(
          title: createTitle(),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () => logOut())
          ],
        ),
        body: SafeArea(
          child: Container(
              color: Colors.white,
              child: Center(
                child: (isThisTimeOut)
                    ? Container(
                        child: Column(
                          children: [
                            Text('maaf koneksi dengan server terputus',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              'muat ulang',
                              style: TextStyle(color: Colors.blue),
                            ),
                            IconButton(
                                icon: Icon(Icons.refresh, color: Colors.blue),
                                onPressed: () {
                                  setState(() {});
                                })
                          ],
                        ),
                      )
                    : (listNote == null || listNote.length == 0)
                        ? Container(
                            child: Text('Anda tidak memiliki catatan',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold)),
                          )
                        : GridView.builder(
                            itemCount: listNote.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => DetailNote(
                                              tags: "note$index",
                                              note: listNote[index]))),
                                  child: Hero(
                                    tag: "note$index",
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: Draggable<int>(
                                          data: listNote[index].id,
                                          onDragStarted: () {
                                            setState(() {
                                              isDragged = true;
                                            });
                                          },
                                          onDragEnd: (det) {
                                            setState(() {
                                              isDragged = false;
                                            });
                                          },
                                          childWhenDragging:
                                              Container(color: Colors.white),
                                          feedback: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                      "assets/images/stickynote.png")),
                                            ),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 30, 15, 0),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: AssetImage(
                                                        "assets/images/stickynote.png"))),
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 35,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                          listNote[index]
                                                                  .title ??
                                                              ''))
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0,
                                                    right: 4,
                                                    top: 2),
                                                child: Row(children: [
                                                  Expanded(
                                                      child: Text(getShortNotes(
                                                          listNote[index]
                                                                  .notes ??
                                                              '')))
                                                ]),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
              )),
        ),
        floatingActionButton: Wrap(children: [
          AnimatedContainer(
              duration: Duration(milliseconds: 250),
              child: FloatingActionButton(
                onPressed: () =>
                    Navigator.of(context).push(routeAnimRoute(DetailNote())),
                child: Icon(Icons.mode_edit),
              ))
        ]),
      ),
      AnimatedPositioned(
          bottom: (isDragged) ? 0 : -250,
          right: (isDragged) ? 0 : -250,
          child: Wrap(children: [
            DragTarget<int>(
                onAccept: (id) => deleteConfirmation(id),
                builder: (context, _, __) => Material(
                      type: MaterialType.transparency,
                      child: Container(
                          padding: EdgeInsets.only(bottom: 20, right: 20),
                          alignment: Alignment.bottomRight,
                          width: 100,
                          height: 100,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  'Hapus',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0)))),
                    ))
          ]),
          duration: Duration(milliseconds: 250))
    ]);
  }

  void deleteConfirmation(int id) async {
    Timer timer = Timer(Duration(seconds: 3), () => deleteNote(id));

    _sfKey.currentState.showSnackBar(SnackBar(
        action: SnackBarAction(
            label: 'batalkan',
            onPressed: () {
              timer.cancel();
              print('canceled');
              setState(() {});
            }),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.white,
        content: Material(
          type: MaterialType.transparency,
          child: Container(
            height: 50,
            child: Center(
                child: Text(
              'catatan telah dihapus',
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
            )),
          ),
        )));
  }

  deleteNote(int id) async {
    print('data dihapus');
    var service = NetworkService();
    try {
      var result = await service.deleteNotes(id);
      (result ?? false)
          ? debugPrint('data berhasil dihapus')
          : debugPrint('data gagal dihapus');
    } on SocketException catch (e) {
      if (isTimeOut(e)) {
        _sfKey.currentState.showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.white,
            content: Material(
              type: MaterialType.transparency,
              child: Container(
                height: 50,
                child: Center(
                    child: Text(
                  'catatan gagal dihapus koneksi terputus',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black),
                )),
              ),
            )));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {});
  }

  getListNotes() async {
    List<Notes> notes = [];
    try {
      notes = await NetworkService().getListNotes();
      setState(() {
        isThisTimeOut = false;
      });
    } on SocketException catch (er) {
      if (isTimeOut(er)) {
        setState(() {
          isThisTimeOut = true;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    try{setState(() {
      listNote = notes;
    });}catch(e){
      print(e.toString());
    }
  }
  logOut()async{
                      await SFService().removeSaveLogin();
                      Navigator.of(context).pushReplacement(routeAnimRoute(LoginRegister()));
                    }
  
}
