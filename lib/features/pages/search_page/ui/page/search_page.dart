import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../products_scanner/data/repository/fire_store_repositories.dart';
import '../../logic/search_bloc.dart';
import '../widget/search_page_view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
      create: (final context) => SearchBloc(FireStoreRepository()),
      child: const SearchPageView(),
    );
}
