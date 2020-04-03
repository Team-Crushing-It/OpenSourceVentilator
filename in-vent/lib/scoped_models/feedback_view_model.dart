import 'package:scoped_model/scoped_model.dart';
import '../models/list_item.dart';
import 'base_model.dart';

export '../enums/view_state.dart';


/// Contains logic for a list view with the general expected functionality.
class FeedbackViewModel extends BaseModel {
  List<ListItem> listData;

  Future fetchListData() async {
    setState(ViewState.Busy);

    await Future.delayed(Duration(seconds: 1));
    listData = List<ListItem>.generate(10, (index) =>
    ListItem(title: 'title $index', description: 'Description of this list Item. $index'));

   if (listData == null) {
      setState(ViewState.Error);
    } else {
      setState(listData.length == 0
          ? ViewState.NoDataAvailable
          : ViewState.DataFetched);
    }
  }
}