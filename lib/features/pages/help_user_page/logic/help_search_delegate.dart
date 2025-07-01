import 'package:flutter/material.dart';
import '../data/model/qna_model.dart';

class HelpSearchDelegate extends SearchDelegate<QnaModel?> {

  HelpSearchDelegate({required this.qnaList, required this.onSearch});
  final List<QnaModel> qnaList;
  final Function(String) onSearch;

  @override
  String get searchFieldLabel => 'ابحث عن سؤال...';

  // @override
  // TextStyle get searchFieldStyle => const TextStyle(
  //       fontSize: 16,
  //       height: 1.5,
  //     );

  @override
  List<Widget> buildActions(final BuildContext context) => [
      IconButton(
        icon: const Icon(Icons.exit_to_app_rounded),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            onSearch(query);
          }
        },
      ),
    ];

  @override
  Widget buildLeading(final BuildContext context) => IconButton(
      icon: const Icon(Icons.double_arrow_rounded),
      onPressed: () => close(context, null),
    );

  @override
  Widget buildResults(final BuildContext context) => _buildSearchResults();

  @override
  Widget buildSuggestions(final BuildContext context) {
    onSearch(query);
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (qnaList.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64),
            SizedBox(height: 16),
            Text('لم يتم العثور على نتائج', style: TextStyle(fontSize: 16)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: qnaList.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (final context, final index) {
        final qna = qnaList[index];
        return ListTile(
          leading: const Icon(Icons.help_outline),
          title: Text(qna.question, style: const TextStyle(fontSize: 16)),
          subtitle: Text(
            qna.simAnswer,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => close(context, qna),
        );
      },
    );
  }
}
