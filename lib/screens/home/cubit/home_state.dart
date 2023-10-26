part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetFeedsLoading extends HomeState {}

class GetFeedsSuccess extends HomeState {
  final List<FeedListModel> feedListModel;

  GetFeedsSuccess(this.feedListModel);
}

class GetFeedsError extends HomeState {
  final String message;

  GetFeedsError(this.message);
}