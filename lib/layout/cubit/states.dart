abstract class FuelStationStates {}

class FuelStationInitialState extends FuelStationStates {}

class FuelStationChangePasswordVisibilityState extends FuelStationStates {}

class GetCurrentLocationState extends FuelStationStates {}

class StoreLoadingState extends FuelStationStates {}

class StoreSuccessState extends FuelStationStates {}

class StoreErrorState extends FuelStationStates {
  final String error;

  StoreErrorState(this.error);
}

class GetOrderLoadingState extends FuelStationStates {}

class GetOrderSuccessState extends FuelStationStates {}

class GetOrderErrorState extends FuelStationStates {
  final String error;

  GetOrderErrorState(this.error);
}
