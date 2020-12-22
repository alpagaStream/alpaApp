import 'package:alpaga/models/live_stream.dart';
import 'package:alpaga/models/user.dart';
import 'package:alpaga/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:alpaga/models/github_model.dart';
import 'package:alpaga/services/api_service.dart';

import 'package:alpaga/utils/raw_data.dart';
import 'package:alpaga/widgets/table_card.dart';
import 'package:alpaga/widgets/ticket_cards.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../fonts.dart';

class Hosting extends StatefulWidget {
  @override
  _HostingState createState() => _HostingState();
}


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

  void _sort<T>(Comparable<T> getField(LiveStream d), bool ascending) {
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

  void _selectAll(bool checked) {
    for (LiveStream liveStream in _liveStreams)
      liveStream.selected = checked;
    _selectedCount = checked ? _liveStreams.length : 0;
    notifyListeners();
  }
}

class _HostingState extends State<Hosting> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getDataFromUi();
  }

  getDataFromUi() async {
    loading = false;
    // await ApiData.getData();
    // setState(() {
    //   loading = true;
    // });
  }

  int _rowsPerPage = 5;
  int _sortColumnIndex;
  bool _sortAscending = true;
  final LiveStreamDataSource _liveStreamsDataSource = new LiveStreamDataSource();

  void _sort<T>(Comparable<T> getField(LiveStream d), int columnIndex, bool ascending) {
    _liveStreamsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
            padding: const EdgeInsets.all(30.0),
            children: <Widget>[
              Text(
                  "CURRENTLY HOSTING",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: ResFont.openSans,
                  )
              ),
              SizedBox(height: 30.0),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(width: 12.0),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(140.0),
                          child: FadeInImage.memoryNetwork(
                            height: 140,
                            width: 140,
                            placeholder: kTransparentImage,
                            image: 'https://picsum.photos/250?image=9',
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Center(
                            child: Text(
                              "Nobody to be hosted",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                                fontFamily: ResFont.openSans,
                              ),
                            )
                        ),],
                    ),
                    VerticalDivider(
                      color: Colors.black26,
                      thickness: 2,
                    ),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(140.0),
                          child: FadeInImage.memoryNetwork(
                            height: 140,
                            width: 140,
                            placeholder: kTransparentImage,
                            image: 'https://picsum.photos/250?image=9',
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Center(
                            child: Text(
                              "Nobody to be hosted",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                                fontFamily: ResFont.openSans,
                              ),
                            )
                        ),
                      ],
                    ),
                    SizedBox(width: 12.0),
                  ],
                ),
              ),
              SizedBox(height: 50.0),
              Text(
                  "HOSTING HISTORY",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: ResFont.openSans,
                  )
              ),
              SizedBox(height: 8.0),
              new PaginatedDataTable(
                  rowsPerPage: _rowsPerPage,
                  availableRowsPerPage: [5, 10],
                  dataRowHeight: 68,
                  onRowsPerPageChanged: (int value) { setState(() { _rowsPerPage = value; }); },
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  onSelectAll: _liveStreamsDataSource._selectAll,
                  showCheckboxColumn: false,
                  columns: <DataColumn>[
                    new DataColumn(
                        label: const Text(
                          'User name',

                        ),
                        onSort: (int columnIndex, bool ascending) => _sort<String>((LiveStream d) => d.user.username, columnIndex, ascending)
                    ),
                    new DataColumn(
                        label: const Text('From'),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) => _sort<num>((LiveStream d) => d.startDate.toUtc().millisecondsSinceEpoch, columnIndex, ascending)
                    ),
                    new DataColumn(
                        label: const Text('to'),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) => _sort<num>((LiveStream d) => d.endDate.toUtc().millisecondsSinceEpoch, columnIndex, ascending)
                    ),
                    new DataColumn(
                        label: const Text('Duration'),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) => _sort<num>((LiveStream d) => d.time, columnIndex, ascending)
                    ),
                    new DataColumn(
                        label: const Text('Type'),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) => _sort<num>((LiveStream d) => d.type.index, columnIndex, ascending)
                    ),
                  ],
                  source: _liveStreamsDataSource
              )
            ]
        )
    );
  }
}
