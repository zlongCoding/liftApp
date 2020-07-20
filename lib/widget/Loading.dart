import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingContainer({Key key, this.isLoading = true, this.child})
      : super(key: key);

  Widget _loadingView() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading ? child : _loadingView();
  }
}
