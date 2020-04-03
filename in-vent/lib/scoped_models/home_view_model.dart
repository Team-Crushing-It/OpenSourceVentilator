import '../models/stats.dart';
import '../service_locator.dart';
import '../services/firebase_service.dart';

import 'base_model.dart';

class HomeViewModel extends BaseModel {

  // The UI will only display what's in the model and will never have contact with the service
  // This is for binding to the UI 
  FirebaseService _firebaseService = locator<FirebaseService>();
  Stats appStats;

  HomeViewModel() {
    _firebaseService.appStats.listen(_onStatsUpdated);
  }

  // In the implementation overview at the beginning we mentioned "Update our model state 
  // whenever a new update/snapshot is emitted from the service". To accomplish this we'll 
  // register to the stream in the Constructor and listen using a function called _onStatsUpdated 
  // that takes in a Stats parameter.

  void _onStatsUpdated(Stats stats) {
    appStats = stats; // Set the stats for the UI

    if (stats == null) {
      setState(ViewState.Busy); // If null indicate we're still fetching
    } else {
      setState(ViewState
          .DataFetched); // When not null indicate that the data is fetched
    }
  }

  // Now when ever the project_stats document updates we'll set the appStats and then emit the 
  // correct state. 
  // When we call setState in the model the state property on the BaseModel is 
  // updated and notifyListeners is called. In the UI we can listen to the state changes and 
  // display UI accrodingly.
}