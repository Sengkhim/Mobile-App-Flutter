import 'package:flutter/material.dart';
import '../services/dispose.dart';
import '../states/loading_state.dart';

class BaseController with ChangeNotifier implements IDisposeable {
  late LoadingState _loadingState = LoadingState.onInit;
  late LoadingStateView _loadingStateView = LoadingStateView.onInit;
  LoadingState get loadingState => _loadingState;
  LoadingStateView get loadingStateView => _loadingStateView;

  void onChangeState(LoadingState loadingState) {
    _loadingState = loadingState;
  }

  void onChangeStateView(LoadingStateView loadingStateView) {
    _loadingStateView = loadingStateView;
  }

  void updateChange() {
    notifyListeners();
  }

  @override
  Future<void> disposeable() {
    throw UnimplementedError();
  }
}
