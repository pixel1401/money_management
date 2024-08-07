import 'package:googleapis/drive/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/src/auth_client.dart';
import 'package:money_management/core/helpers/helpers.dart';
import 'package:money_management/core/helpers/types.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';

const APP_FILE_NAME = 'Money_Management';
const QUERY_FILE = 'name="Money_Management" and trashed = false';

const endColumnLetter = 'E';
const int columnDate = 2; // Column for dates (C)

var sortForDate = (int sheetId) => SortRangeRequest(
      range: GridRange(
        sheetId: sheetId,
        startColumnIndex: 0,
        startRowIndex: 1,
      ),
      sortSpecs: [
        SortSpec(dimensionIndex: columnDate, sortOrder: "DESCENDING"),
      ],
    );

class SheetRepositoryImpl implements SheetsRepository {
  // final SheetsApi client;

  SheetRepositoryImpl();

  @override
  Future<SheetsApi> initSheet(AuthClient credentials) async {
    var client = SheetsApi(credentials);
    return client;
  }

  @override
  Future<DriveApi> initDrive(AuthClient credentials) async {
    var client = DriveApi(credentials);
    return client;
  }

  @override
  Future<Spreadsheet> getSpreadSheet(
      DriveApi driveApi, SheetsApi sheetsApi) async {
    var datafileList = await driveApi.files.list(q: QUERY_FILE);

    Spreadsheet? dataSpread;

    if (datafileList.files != null && datafileList.files!.length > 0) {
      var getSpreadSheet =
          await sheetsApi.spreadsheets.get(datafileList.files?.first.id ?? '');
      dataSpread = getSpreadSheet;
    }
    return dataSpread!;
  }

  @override
  Future<Spreadsheet> createSpreadSheet(SheetsApi sheetsApi) async {
    var spreadsheet = Spreadsheet();
    spreadsheet.properties = SpreadsheetProperties(title: APP_FILE_NAME);
    spreadsheet.sheets = [
      Sheet(data: [
        GridData(rowData: [
          RowData(values: [
            CellData(userEnteredValue: ExtendedValue(stringValue: "Category")),
            CellData(userEnteredValue: ExtendedValue(stringValue: "Name")),
            CellData(userEnteredValue: ExtendedValue(stringValue: "Date")),
            CellData(userEnteredValue: ExtendedValue(stringValue: "Amount")),
            CellData(userEnteredValue: ExtendedValue(stringValue: "Color")),
          ])
        ])
      ], properties: SheetProperties(title: DateTime.now().year.toString())),
    ];

    Spreadsheet? dataSpread;

    var createSpreadSheet = await sheetsApi.spreadsheets.create(spreadsheet);
    dataSpread = createSpreadSheet;
    return dataSpread;
  }

  @override
  Future<List<SheetValueRange>> getSheets(
      SheetsApi sheetsApi, Spreadsheet dataSpread) async {
    List<SheetValueRange> dataValueRange = [];

    List<Map<String, dynamic>> sheetNames = [];
    if (dataSpread.sheets != null) {
      for (var a in dataSpread.sheets!) {
        if (a.properties?.title != null && a.properties?.sheetId != null) {
          sheetNames.add({
            'sheetName': a.properties!.title,
            'sheetId': a.properties!.sheetId
          });
        }
      }
    }

    for (var a in sheetNames) {
      var data = await sheetsApi.spreadsheets.values.get(
          dataSpread.spreadsheetId ?? '',
          a['sheetName'] + '!A:$endColumnLetter');
      dataValueRange.add(SheetValueRange(
          sheetName: a['sheetName'],
          sheetId: a['sheetId'],
          majorDimension: data.majorDimension,
          values: data.values));
    }

    return dataValueRange;
  }

  @override
  Future<List<String>> getCategories({
    required SheetsApi sheetsApi,
    required Spreadsheet dataSpread,
    required List<SheetValueRange> sheetValueRange,
  }) async {
    List<String> categories = [];

    for (var a in sheetValueRange) {
      var data = await sheetsApi.spreadsheets.values
          .get(dataSpread.spreadsheetId ?? '', '${a.sheetName}!A2:A');
      if (data.values != null) {
        for (var wrap in data.values ?? []) {
          if (wrap[0] != null) {
            categories.add(wrap[0].toString());
          }
        }
        categories = categories.toSet().toList();
      }
    }

    return categories;
  }

  @override
  Future<bool> clearEmptySheetRowsValue(
      {required SheetsApi sheetsApi,
      required Spreadsheet dataSpread,
      required List<SheetValueRange> sheetsValueRange}) async {
    List<Request>? requestsForDelete = [];

    for (var a in sheetsValueRange) {
      int rowIndexLast = a.values?.length ?? 0;
      int indexList = sheetsValueRange.indexOf(a);
      if (a.values == null) continue;

      for (var i = 0; i < (a.values?.length ?? 0); i++) {
        var valueItem = a.values![i];

        if (valueItem == null) continue;
        if (valueItem.length < 4) {
          var itemProperties = dataSpread.sheets?[indexList].properties;
          if (itemProperties?.title != a.sheetName) break;
          requestsForDelete.add(Request(
              deleteDimension: DeleteDimensionRequest(
                  range: DimensionRange(
                      sheetId: itemProperties?.sheetId,
                      dimension: "ROWS",
                      startIndex: i,
                      endIndex: i + 1))));
        }
      }
    }

    if (requestsForDelete.length > 0) {
      BatchUpdateSpreadsheetRequest request =
          BatchUpdateSpreadsheetRequest(requests: requestsForDelete);
      var data = await sheetsApi.spreadsheets.batchUpdate(
        request,
        dataSpread.spreadsheetId ?? '',
      );

      return true;
    }

    return false;
  }

  @override
  Future<PostsData> deleteSheetRow(
      {required int sheetId,
      required int index,
      required SheetsApi sheetsApi,
      required Spreadsheet dataSpread}) async {
    Request requestsForDelete = Request(
      deleteDimension: DeleteDimensionRequest(
        range: DimensionRange(
            sheetId: sheetId,
            dimension: "ROWS",
            startIndex: index + 1,
            endIndex: index + 2),
      ),
      sortRange: sortForDate(sheetId),
    );

    BatchUpdateSpreadsheetRequest request = BatchUpdateSpreadsheetRequest(
        requests: [requestsForDelete],
        includeSpreadsheetInResponse: true,
        responseIncludeGridData: true,
        responseRanges: ['A2:$endColumnLetter']);
    var data = await sheetsApi.spreadsheets.batchUpdate(
      request,
      dataSpread.spreadsheetId ?? '',
    );

    return getPostData(data);
  }

  @override
  Future<PostsData> setDataSheet(
      {required List<RowData> rows,
      required SheetsApi sheetsApi,
      required Spreadsheet dataSpread,
      required List<SheetValueRange> sheetsValueRange}) async {
    for (var a in sheetsValueRange!) {
      if (a.sheetName == DateTime.now().year.toString()) {
        int rowIndexLast = a.values?.length ?? 0;

        BatchUpdateSpreadsheetRequest request = BatchUpdateSpreadsheetRequest(
          requests: [
            Request(
              updateCells: UpdateCellsRequest(
                fields: "*",
                start: GridCoordinate(
                    columnIndex: 0,
                    rowIndex: rowIndexLast,
                    sheetId: dataSpread.sheets?[0].properties?.sheetId),
                rows: rows,
              ),
            ),
            Request(
              sortRange:
                  sortForDate(dataSpread.sheets?[0].properties?.sheetId ?? 0),
            )
          ],
          includeSpreadsheetInResponse: true,
          responseIncludeGridData: true,
          responseRanges: ['A2:$endColumnLetter'],
        );

        var res = await sheetsApi.spreadsheets
            .batchUpdate(request, dataSpread.spreadsheetId ?? '', $fields: "*");

        return getPostData(res);
      }
    }
    return PostsData(posts: [], total: 0, current: 1);
  }

  @override
  Future<num> getTotalPriceSheet(
      {required SheetsApi sheetsApi,
      required Spreadsheet dataSpread,
      required List<SheetValueRange> sheetsValueRange,
      required String sheetName,
      DateTime? dateStart,
      DateTime? dateEnd,
      TimeRange? timeRange}) async {
    var res = await sheetsApi.spreadsheets.values.get(
        dataSpread.spreadsheetId!, '$sheetName!D2:D',
        majorDimension: 'COLUMNS');
    if (res.values?[0] != null) {
      return calculateSum(res.values![0]);
    } else {
      return 0;
    }
  }

  @override
  Future<PostsData> getPostsSortDate(
      {required SheetsApi sheetsApi,
      required Spreadsheet dataSpread,
      required List<SheetValueRange> sheetValueRange,
      int? sheetId,
      int currentPage = 1,
      int pageSize = 10,
      DateTime? dateStart,
      DateTime? dateEnd,
      TimeRange? timeRange}) async {
    int requestCount = currentPage * pageSize;

    BatchUpdateSpreadsheetRequest request = BatchUpdateSpreadsheetRequest(
      requests: [],
      includeSpreadsheetInResponse: true,
      responseIncludeGridData: true,
      responseRanges: ['A2:$endColumnLetter'],
    );

    if (sheetId != null) {
      // int? endColumn = dataSpread.sheets!.firstWhere((element) => element.properties?.sheetId == sheetId).properties?.gridProperties?.columnCount;

      request.requests!.add(
        Request(
          sortRange: sortForDate(sheetId),
        ),
      );
    } else {
      for (SheetValueRange a in sheetValueRange) {
        request.requests!.add(
          Request(
            sortRange: sortForDate(a.sheetId!),
          ),
        );
      }
    }

    var data = await sheetsApi.spreadsheets
        .batchUpdate(request, dataSpread.spreadsheetId!);

    return getPostData(data, current: currentPage);
  }

  @override
  Future<List<PieChartVM>> getPieChartData(
      {required SheetsApi sheetsApi,
      required Spreadsheet dataSpread,
      required String sheetName}) async {
    List<PieChartVM> res = [];

    var data = await sheetsApi.spreadsheets.values.get(
      dataSpread.spreadsheetId ?? '',
      '${sheetName}!A2:$endColumnLetter',
      majorDimension: 'ROWS',
    );

    if (data.values == null) return [];

    Map<String, num> dataMap = {};
    num totalSum = 0;

    for (var a in data.values!) {
      // PieChartVM item;
      if (a[0] != null && a[3] != null) {
        num itemSum = (num.tryParse(a[3].toString()) ?? 0);
        String itemTitle = a[0].toString();

        if (dataMap.containsKey(itemTitle)) {
          dataMap[a[0].toString()] = dataMap[itemTitle]! + itemSum;
        } else {
          dataMap[a[0].toString()] = itemSum;
        }

        totalSum += itemSum;
      }
    }

    dataMap.forEach((key, value) {
      res.add(
          PieChartVM(title: key, percent: ((value / totalSum) * 100).floor()));
    });

    return res;
  }

  @override
  Future<PostsData> updateDataSheet(
      {required List<RowData> rows,
      required SheetsApi sheetsApi,
      required Spreadsheet dataSpread,
      required int indexPost,
      required List<SheetValueRange> sheetsValueRange}) async {
    for (var a in sheetsValueRange!) {
      if (a.sheetName == DateTime.now().year.toString()) {

        BatchUpdateSpreadsheetRequest request = BatchUpdateSpreadsheetRequest(
          requests: [
            Request(
              updateCells: UpdateCellsRequest(
                fields: "*",
                start: GridCoordinate(
                    columnIndex: 0,
                    rowIndex: indexPost + 1,
                    sheetId: dataSpread.sheets?[0].properties?.sheetId),
                rows: rows,
              ),
            ),
            Request(
              sortRange:
                  sortForDate(dataSpread.sheets?[0].properties?.sheetId ?? 0),
            )
          ],
          includeSpreadsheetInResponse: true,
          responseIncludeGridData: true,
          responseRanges: ['A2:$endColumnLetter'],
        );

        var res = await sheetsApi.spreadsheets
            .batchUpdate(request, dataSpread.spreadsheetId ?? '', $fields: "*");

        return getPostData(res);
      }
    }
    return PostsData(posts: [], total: 0, current: 1);

  }
}

PostsData getPostData(BatchUpdateSpreadsheetResponse data, {int? current}) {
  try {
    if (data.updatedSpreadsheet?.sheets != null) {
      var sheets = data.updatedSpreadsheet?.sheets;
      if (sheets != null) {
        var total = sheets.first.properties?.gridProperties?.columnCount;
        List<Post> posts = [];
        for (var a in sheets) {
          var dataSheetId = a.properties?.sheetId;
          if (a.data == null || dataSheetId == null) break;
          for (var rowData in a.data!) {
            if (rowData.rowData == null) break;
            for (var rowListIndex = 0;
                rowListIndex < rowData.rowData!.length;
                rowListIndex++) {
              var item = rowData.rowData![rowListIndex].values;

              if ((item?.length ?? 0) > 3) {
                Post post = Post(
                  index: rowListIndex,
                  sheetId: dataSheetId,
                  category: item?[0].userEnteredValue?.stringValue ?? '',
                  name: item?[1].userEnteredValue!.stringValue ?? '',
                  date: item?[2].userEnteredValue!.stringValue ?? '',
                  amount: item?[3].userEnteredValue!.stringValue ?? '',
                  color: item!.length > 4
                      ? (item[4].userEnteredValue?.stringValue)
                      : null,
                );
                posts.add(post);
              }
            }
          }
        }

        return PostsData(
            posts: posts, total: total ?? 0, current: current ?? 1);
      }
    }

    return PostsData(posts: [], total: 0, current: 0);
  } catch (e) {
    print('Error in getPostData: $e');
    return PostsData(posts: [], total: 0, current: 0);
  }
}
