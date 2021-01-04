import 'package:alpaga/models/live_stream.dart';
import 'package:alpaga/models/user.dart';
import 'package:alpaga/utils/color_constants.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../fonts.dart';

class LiveStreamDataSource extends DataTableSource {


  final List<LiveStream> _liveStreams = <LiveStream>[
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
    new LiveStream(User("Quentin"), DateTime.now(), DateTime.now(), 100, LiveStreamType.host),
  ];

  void sort<T>(Comparable<T> getField(LiveStream d), bool ascending) {
    _liveStreams.sort((LiveStream a, LiveStream b) {
      if (!ascending) {
        final LiveStream c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _liveStreams.length)
      return null;
    final LiveStream liveStream = _liveStreams[index];
    return new DataRow.byIndex(
        index: index,
        selected: liveStream.selected,
        onSelectChanged: (bool value) {
          if (liveStream.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            liveStream.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          new DataCell(
            new Container(
              width: 200,
              child: Row(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(44.0),
                      child: FadeInImage.memoryNetwork(
                        height: 44,
                        width: 44,
                        placeholder: kTransparentImage,
                        image: 'https://picsum.photos/250?image=9',
                      ),
                    ),
                  ),
                  SizedBox(width: 24.0),
                  Text(
                    '${liveStream.user.username}',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          new DataCell(new Text('${DateFormat('yyyy/MM/dd hh:mm').format(liveStream.startDate)}')),
          new DataCell(new Text('${DateFormat('yyyy/MM/dd hh:mm').format(liveStream.endDate)}')),
          new DataCell(new Text('${liveStream.time}')),
          new DataCell(
            new Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Text(
                liveStream.type == LiveStreamType.host ? "HOST" : "GUEST",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: ResFont.openSans,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all( Radius.circular(200)),
                color: liveStream.type == LiveStreamType.host ? ColorConstants.hostTagColor :  ColorConstants.guestTagColor,
              ),
            ),
          ),
        ]
    );
  }

  @override
  int get rowCount => _liveStreams.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool checked) {
    for (LiveStream liveStream in _liveStreams)
      liveStream.selected = checked;
    _selectedCount = checked ? _liveStreams.length : 0;
    notifyListeners();
  }
}