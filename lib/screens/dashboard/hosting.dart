import 'package:alpaga/models/live_stream.dart';
import 'package:alpaga/models/user.dart';
import 'package:alpaga/screens/dashboard/streams_history_data_source.dart';
import 'package:flutter/material.dart';

import '../../fonts.dart';
import '../../res.dart';

class Hosting extends StatefulWidget {

  Hosting({
    @required this.currentUser,
  });

  final User currentUser;

  @override
  _HostingState createState() => _HostingState(currentUser: currentUser);
}

class _HostingState extends State<Hosting> {

  _HostingState({
    @required this.currentUser,
  });

  final User currentUser;

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
    _liveStreamsDataSource.sort<T>(getField, ascending);
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
                child: FadeInImage.assetNetwork(
                  height: 140,
                  width: 140,
                  placeholder: Res.peoplePlaceHolder,
                  image: currentUser.pictureURL,
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
                child: FadeInImage.assetNetwork(
                  height: 140,
                  width: 140,
                  placeholder: Res.peoplePlaceHolder,
                  image: currentUser.pictureURL,
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
                  onSelectAll: _liveStreamsDataSource.selectAll,
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
