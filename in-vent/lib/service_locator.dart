import 'package:get_it/get_it.dart';
import './scoped_models/home_view_model.dart';
import './scoped_models/feedback_view_model.dart';
import './services/firebase_service.dart';

GetIt locator = new GetIt();

void setupLocator() {
  // Register services
    locator.registerLazySingleton(() => FirebaseService());


  // Register ScopedModels
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<FeedbackViewModel>(() => FeedbackViewModel());
}

