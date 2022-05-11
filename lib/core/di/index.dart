import 'package:get_it/get_it.dart';
import 'package:promdifarm_app/core/routes/index.dart';
import 'package:promdifarm_app/data/sources/index.dart';
import 'package:promdifarm_app/domain/repositories/index.dart';
import 'package:promdifarm_app/domain/sources/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/data/repositories/index.dart';
import 'package:promdifarm_app/core/services/index.dart';
import 'package:promdifarm_app/view/bloc/rider-profile/rider.cubit.dart';
import 'package:promdifarm_app/view/bloc/slider/slider.cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This is our global ServiceLocator
GetIt sl = GetIt.instance;

void init() {
  // Register Services
  registerServices();

  // Register Sources
  registerSources();

  // Register Repositories
  registerRepositories();

  // Register Cubits
  registerCubits();
}

void registerServices() {
  sl.registerLazySingleton(
    () => ApiService(
      localStorage: sl<LocalStorageService>(),
      loginService: sl<LoginService>(),
    ),
  );
  sl.registerLazySingleton(() => LocationService());
  sl.registerLazySingleton(() => DirectionsService());
  sl.registerLazySingleton(
    () => LocalStorageService(
      sharedPreferences: SharedPreferences.getInstance,
    ),
  );
  sl.registerLazySingleton<LoginService>(() => LoginService());
  sl.registerLazySingleton<Routes>(
    () => Routes(
      loginService: sl<LoginService>(),
    ),
  );
}

void registerSources() {
  sl.registerLazySingleton<DeliverySource>(
    () => DeliverySourceImp(
      api: sl(),
      dirService: sl(),
      localStorage: sl(),
      locService: sl(),
    ),
  );
  sl.registerLazySingleton<MapSource>(
    () => MapSourceImp(
      dirService: sl(),
      api: sl(),
    ),
  );
  sl.registerLazySingleton<UserSource>(
    () => UserSourceImp(
      dirService: sl(),
      api: sl(),
      localStorage: sl(),
      loginService: sl(),
    ),
  );
}

void registerRepositories() {
  sl.registerLazySingleton<DeliveriesRepository>(
    () => DeliveriesRepositoryImp(sl()),
  );
  sl.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImp(source: sl()),
  );
  sl.registerLazySingleton<MapRepository>(() => MapRepositoryImp(sl()));
  sl.registerLazySingleton<ParcelRepository>(() => ParcelsRepositoryImp(sl()));
}

void registerCubits() {
  sl.registerFactory<DeliveriesCubit>(() => DeliveriesCubit(repository: sl()));
  sl.registerFactory<UserCubit>(() => UserCubit(repository: sl()));
  sl.registerFactory<MapCubit>(() => MapCubit(repository: sl()));
  sl.registerFactory<ButtonCubit>(() => ButtonCubit());
  sl.registerFactory<SideNavCubit>(() => SideNavCubit(repository: sl()));
  sl.registerFactory<SliderCubit>(() => SliderCubit());
  sl.registerFactory<HomeCubit>(() => HomeCubit(repository: sl()));
  sl.registerFactory<DestinationDetailsCubit>(
    () => DestinationDetailsCubit(sl()),
  );
  sl.registerFactory<DeliveryProofCubit>(
    () => DeliveryProofCubit(repository: sl()),
  );

  sl.registerFactory<PickUpCardCubit>(() => PickUpCardCubit());
  sl.registerFactory<PickUpListCubit>(() => PickUpListCubit(repository: sl()));
  sl.registerFactory<RiderCubit>(() => RiderCubit(repository: sl()));
  sl.registerFactory<DateCubit>(() => DateCubit());
}
