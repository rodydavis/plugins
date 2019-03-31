import 'package:flutter/material.dart';

class SheetMusicView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _height = 150.0;
    var _notes = List<MusicNote>.generate(
      4,
      (index) => MusicNote(
            midi: 60,
            type: NoteType.quarter,
          ),
    );
    return SliverToBoxAdapter(
      child: Container(
        child: MusicMeasure(
          size: Size(MediaQuery.of(context).size.width, _height),
          notes: _notes,
        ),
      ),
    );
  }
}

class MusicMeasure extends StatelessWidget {
  MusicMeasure({
    Key key,
    this.notes,
    this.clef = ClefType.treble,
    this.showClef = false,
    this.size = const Size(100, 100),
  })  : assert(1 == _calculateNotes(notes),),
        super(key: key);

  final List<MusicNote> notes;
  final ClefType clef;
  final bool showClef;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      padding: EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: MusicStaff(height: size.height),
          ),
        ]..addAll(_buildNotes(notes)),
      ),
    );
  }

  List<Widget> _buildNotes(List<MusicNote> values) {
    var _children = <Widget>[];
    int _index = 0;
    for (var n in notes) {
      _children.add(Positioned(
        left: _noteX(_index, n),
        bottom: _noteY(n.midi),
        child: NoteDecoration(n: n),
      ));
      _children.addAll(_fillMeasure(n.type));
      _index++;
    }
    return _children;
  }

  double _noteY(int midi) {
    if (clef == ClefType.treble) {
      if (midi == 60) return size.height * 0.05;
      return 0;
    }
    return 0;
  }

  double _noteX(int index, MusicNote note) {
    if (index == 0) return 0;
    return (getNoteWeight(note.type) * size.width + (note.radius * 2)) * index;
  }

  List<Widget> _fillMeasure(NoteType value) {
    switch (value) {
      case NoteType.whole:
        return List.generate(63, (_) => Container());
      case NoteType.half:
        return List.generate(31, (_) => Container());
      case NoteType.quarter:
        return List.generate(15, (_) => Container());
      case NoteType.eighth:
        return List.generate(7, (_) => Container());
      case NoteType.sixteenth:
        return List.generate(3, (_) => Container());
      case NoteType.thirtysecond:
        return List.generate(1, (_) => Container());
      case NoteType.sixtyfourth:
        return [];
    }
    return [];
  }

  static num _calculateNotes(List<MusicNote> values) {
    num _total = 0;
    for (var n in values) {
      _total += getNoteWeight(n.type);
    }
    return _total;
  }
}

class NoteDecoration extends StatelessWidget {
  const NoteDecoration({
    Key key,
    @required this.n,
  }) : super(key: key);

  final MusicNote n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: n.radius * 2,
      height: n.radius * 6,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: n,
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 5,
            child: Container(width: 1, color: Colors.black),
          )
        ],
      ),
    );
  }
}

class MusicNote extends StatelessWidget {
  const MusicNote({
    Key key,
    @required this.midi,
    this.radius = 10,
    this.type = NoteType.quarter,
    this.invert = false,
    this.clef = ClefType.treble,
    this.shapeNote = false,
    this.color = Colors.black,
  }) : super(key: key);

  final double radius;
  final NoteType type;
  final bool invert;
  final int midi;
  final ClefType clef;
  final bool shapeNote;
  final Color color;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case NoteType.whole:
      case NoteType.half:
        return Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: color)),
        );
      case NoteType.quarter:
        return Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: color,
          ),
        );
      default:
        return Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: color,
          ),
        );
    }
  }
}

double getNoteWeight(NoteType value) {
  switch (value) {
    case NoteType.whole:
      return 1;
    case NoteType.half:
      return 0.5;
    case NoteType.quarter:
      return 0.25;
    case NoteType.eighth:
      return 0.125;
    case NoteType.sixteenth:
      return 0.0625;
    case NoteType.thirtysecond:
      return 0.03125;
    case NoteType.sixtyfourth:
      return 0.015625;
    default:
      return 1;
  }
}

class MusicStaff extends StatelessWidget {
  const MusicStaff({
    Key key,
    this.height = 125,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Divider(
            color: Colors.black,
          ),
          Divider(
            color: Colors.black,
          ),
          Divider(
            color: Colors.black,
          ),
          Divider(
            color: Colors.black,
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

enum ClefType { treble, bass }

enum NoteType {
  whole,
  half,
  quarter,
  eighth,
  sixteenth,
  thirtysecond,
  sixtyfourth
}
