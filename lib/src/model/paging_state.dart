import 'package:flutter/foundation.dart';
import 'package:infinite_scroll_pagination/src/model/paging_status.dart';

@immutable
class PagingState<PageKeyType, ItemType> {
  const PagingState({
    this.nextPageKey,
    this.itemList,
    this.error,
  });

  final List<ItemType> itemList;

  final dynamic error;

  final PageKeyType nextPageKey;

  PagingStatus get status {
    if (_isOngoing) {
      return PagingStatus.ongoing;
    }

    if (_isCompleted) {
      return PagingStatus.completed;
    }

    if (_isLoadingFirstPage) {
      return PagingStatus.loadingFirstPage;
    }

    if (_hasSubsequentPageError) {
      return PagingStatus.subsequentPageError;
    }

    if (_isEmpty) {
      return PagingStatus.noItemsFound;
    } else {
      return PagingStatus.firstPageError;
    }
  }

  int get itemCount => itemList?.length;

  bool get hasNextPage => nextPageKey != null;

  bool get _hasItems => itemCount != null && itemCount > 0;

  bool get _hasError => error != null;

  bool get _isListingUnfinished => _hasItems && hasNextPage;

  bool get _isOngoing => _isListingUnfinished && !_hasError;

  bool get _isCompleted => _hasItems && !hasNextPage;

  bool get _isLoadingFirstPage => itemCount == null && !_hasError;

  bool get _hasSubsequentPageError => _isListingUnfinished && _hasError;

  bool get _isEmpty => itemCount != null && itemCount == 0;
}
