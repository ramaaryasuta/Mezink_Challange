import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';

class DataServices with ChangeNotifier {
  /// Initialize the dio package
  final dio = Dio();

  final String baseUrl = 'https://reqres.in/api/users';
  int pages = 1;

  /// Store number of pages Json
  int maxPage = 1;

  /// Store List of users
  List<UserModel> _usersList = [];
  List<UserModel> get usersList => _usersList;

  /// store filter data
  List<UserModel> filteredList = [];
  List<UserModel> dropFilterList = [];
  String query = '';
  String filter = 'All';

  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  bool get sortAscending => _sortAscending;
  int get sortColumnIndex => _sortColumnIndex;

  void getUserData() async {
    try {
      Response response = await dio.get('$baseUrl?page=$pages');
      if (response.statusCode == 200) {
        maxPage = response.data['total_pages'];
        _usersList = (response.data['data'] as List)
            .map((e) => UserModel.fromJson(e))
            .toList();

        /// creating dummy role
        for (UserModel user in _usersList) {
          if (user.id % 2 == 0) {
            user.role = 'Influencer';
          } else {
            user.role = 'New Commer';
          }
        }
        notifyListeners();
      } else {
        /// empty list if error
        _usersList = [];
      }
    } catch (e) {
      rethrow;
    }
  }

  /// search query from users list
  void searchQuery(String value) {
    query = value;
    notifyListeners();
    if (query.isEmpty) {
      /// clear filtered list if query is empty
      filteredList.clear();
      notifyListeners();
    } else {
      filterUsers(query);
      notifyListeners();
    }
  }

  /// filter query users
  void filterUsers(query) {
    filteredList = _usersList
        .where((element) =>
            element.firstName.toString().toLowerCase().contains(query) ||
            element.lastName.toString().toLowerCase().contains(query) ||
            element.email.toString().toLowerCase().contains(query))
        .toList();
    notifyListeners();
  }

  /// sort by compare data
  void sort<T>(Comparable<T> Function(UserModel user) getField, int columnIndex,
      bool ascending) {
    /// check if filtered list is not empty and sort
    if (filteredList.isNotEmpty) {
      filteredList.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    } else {
      /// sort the original data
      _usersList.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    }
    _sortAscending = ascending;
    _sortColumnIndex = columnIndex;
    notifyListeners();
  }

  void usersListFilter() {
    if (filter != 'All') {
      dropFilterList =
          _usersList.where((element) => element.role == filter).toList();
      notifyListeners();
    }
    if (filter == 'All') {
      dropFilterList.clear();
      notifyListeners();
    }
  }

  void setFilter(String selectedFilter) {
    filter = selectedFilter;
    notifyListeners();
  }

  void nextPage() {
    pages++;
    notifyListeners();
    getUserData();
  }

  void previousPage() {
    if (pages > 1) {
      pages--;
      notifyListeners();
      getUserData();
    }
  }
}
