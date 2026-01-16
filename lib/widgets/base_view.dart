import 'package:flutter/material.dart';
import 'app_empty_state.dart';

enum ViewState { idle, loading, error, empty }

class BaseView extends StatelessWidget {
  final ViewState state;
  final Widget child;
  final Widget? loadingWidget;
  final String? errorMessage;
  final VoidCallback? onRetry;

  const BaseView({
    super.key,
    required this.state,
    required this.child,
    this.loadingWidget,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // Removed 'default' because Dart knows all 4 states are handled
    switch (state) {
      case ViewState.loading:
        return loadingWidget ?? const Center(child: CircularProgressIndicator());
      
      case ViewState.error:
        return AppEmptyState(
          title: "Oops!",
          message: errorMessage ?? "Something went wrong.",
          icon: Icons.error_outline_rounded,
          onRetry: onRetry,
        );
      
      case ViewState.empty:
        return AppEmptyState(
          title: "No Data",
          message: "There is nothing to show here yet.",
          icon: Icons.search_off_rounded,
          onRetry: onRetry,
        );

      case ViewState.idle:
        return child;
    }
  }
}