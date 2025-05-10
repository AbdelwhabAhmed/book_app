// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:bookly_app/model/book_model/book_model.dart' as _i18;
import 'package:bookly_app/views/add_device_page.dart' as _i1;
import 'package:bookly_app/views/all_books/all_books_page.dart' as _i2;
import 'package:bookly_app/views/all_categorise_page.dart' as _i3;
import 'package:bookly_app/views/auth/login/login_page.dart' as _i8;
import 'package:bookly_app/views/auth/register/register_page.dart' as _i11;
import 'package:bookly_app/views/book_details/book_details.dart' as _i4;
import 'package:bookly_app/views/category_books/category_books_page.dart'
    as _i5;
import 'package:bookly_app/views/home/home_page.dart' as _i7;
import 'package:bookly_app/views/main_screen/main_screen.dart' as _i9;
import 'package:bookly_app/views/profile_page.dart' as _i10;
import 'package:bookly_app/views/search/search_page.dart' as _i12;
import 'package:bookly_app/views/selection/selection_page.dart' as _i13;
import 'package:bookly_app/views/settings/chat_with_admin_page.dart' as _i6;
import 'package:bookly_app/views/settings/settings_page.dart' as _i14;
import 'package:bookly_app/views/splash_page.dart' as _i15;
import 'package:flutter/material.dart' as _i17;

/// generated route for
/// [_i1.AddDevicePage]
class AddDeviceRoute extends _i16.PageRouteInfo<void> {
  const AddDeviceRoute({List<_i16.PageRouteInfo>? children})
    : super(AddDeviceRoute.name, initialChildren: children);

  static const String name = 'AddDeviceRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddDevicePage();
    },
  );
}

/// generated route for
/// [_i2.AllBooksPage]
class AllBooksRoute extends _i16.PageRouteInfo<void> {
  const AllBooksRoute({List<_i16.PageRouteInfo>? children})
    : super(AllBooksRoute.name, initialChildren: children);

  static const String name = 'AllBooksRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i2.AllBooksPage();
    },
  );
}

/// generated route for
/// [_i3.AllCategoriesPage]
class AllCategoriesRoute extends _i16.PageRouteInfo<void> {
  const AllCategoriesRoute({List<_i16.PageRouteInfo>? children})
    : super(AllCategoriesRoute.name, initialChildren: children);

  static const String name = 'AllCategoriesRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i3.AllCategoriesPage();
    },
  );
}

/// generated route for
/// [_i4.BookDetailsPage]
class BookDetailsRoute extends _i16.PageRouteInfo<BookDetailsRouteArgs> {
  BookDetailsRoute({
    _i17.Key? key,
    required _i18.BookModel book,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         BookDetailsRoute.name,
         args: BookDetailsRouteArgs(key: key, book: book),
         initialChildren: children,
       );

  static const String name = 'BookDetailsRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookDetailsRouteArgs>();
      return _i4.BookDetailsPage(key: args.key, book: args.book);
    },
  );
}

class BookDetailsRouteArgs {
  const BookDetailsRouteArgs({this.key, required this.book});

  final _i17.Key? key;

  final _i18.BookModel book;

  @override
  String toString() {
    return 'BookDetailsRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i5.CategoryBooksPage]
class CategoryBooksRoute extends _i16.PageRouteInfo<CategoryBooksRouteArgs> {
  CategoryBooksRoute({
    _i17.Key? key,
    required String categoryName,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         CategoryBooksRoute.name,
         args: CategoryBooksRouteArgs(key: key, categoryName: categoryName),
         initialChildren: children,
       );

  static const String name = 'CategoryBooksRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryBooksRouteArgs>();
      return _i5.CategoryBooksPage(
        key: args.key,
        categoryName: args.categoryName,
      );
    },
  );
}

class CategoryBooksRouteArgs {
  const CategoryBooksRouteArgs({this.key, required this.categoryName});

  final _i17.Key? key;

  final String categoryName;

  @override
  String toString() {
    return 'CategoryBooksRouteArgs{key: $key, categoryName: $categoryName}';
  }
}

/// generated route for
/// [_i6.ChatWithAdminPage]
class ChatWithAdminRoute extends _i16.PageRouteInfo<void> {
  const ChatWithAdminRoute({List<_i16.PageRouteInfo>? children})
    : super(ChatWithAdminRoute.name, initialChildren: children);

  static const String name = 'ChatWithAdminRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i6.ChatWithAdminPage();
    },
  );
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute({List<_i16.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomePage();
    },
  );
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i16.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i17.Key? key, List<_i16.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i8.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.MainPage]
class MainRoute extends _i16.PageRouteInfo<void> {
  const MainRoute({List<_i16.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i9.MainPage();
    },
  );
}

/// generated route for
/// [_i10.ProfilePage]
class ProfileRoute extends _i16.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({_i17.Key? key, List<_i16.PageRouteInfo>? children})
    : super(
        ProfileRoute.name,
        args: ProfileRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ProfileRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileRouteArgs>(
        orElse: () => const ProfileRouteArgs(),
      );
      return _i10.ProfilePage(key: args.key);
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.RegisterPage]
class RegisterRoute extends _i16.PageRouteInfo<void> {
  const RegisterRoute({List<_i16.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i11.RegisterPage();
    },
  );
}

/// generated route for
/// [_i12.SearchPage]
class SearchRoute extends _i16.PageRouteInfo<void> {
  const SearchRoute({List<_i16.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i12.SearchPage();
    },
  );
}

/// generated route for
/// [_i13.SelectionPage]
class SelectionRoute extends _i16.PageRouteInfo<void> {
  const SelectionRoute({List<_i16.PageRouteInfo>? children})
    : super(SelectionRoute.name, initialChildren: children);

  static const String name = 'SelectionRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i13.SelectionPage();
    },
  );
}

/// generated route for
/// [_i14.SettingsPage]
class SettingsRoute extends _i16.PageRouteInfo<void> {
  const SettingsRoute({List<_i16.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i14.SettingsPage();
    },
  );
}

/// generated route for
/// [_i15.SplashPage]
class SplashRoute extends _i16.PageRouteInfo<void> {
  const SplashRoute({List<_i16.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i15.SplashPage();
    },
  );
}
