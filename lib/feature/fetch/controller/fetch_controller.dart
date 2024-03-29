import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/fetch/repository/fetch_repository.dart';
import 'package:news_app/model/news_model.dart';

final fetchControllerProvider = StateNotifierProvider((ref) => FetchController(
      fetchRepository: ref.read(fetchRepositoryProvider),
    ));

final trendingNewsProvider = FutureProvider.autoDispose((ref) {
  final fetchController = ref.watch(fetchControllerProvider.notifier);
  return fetchController.fetchTrendingNews();
});

class FetchController extends StateNotifier {
  final FetchRepository _fetchRepository;
  FetchController({required FetchRepository fetchRepository})
      : _fetchRepository = fetchRepository,
        super(null);

  Future<NewsModel> fetchTrendingNews() async {
    return _fetchRepository.fetchTrendingNews();
  }
}
