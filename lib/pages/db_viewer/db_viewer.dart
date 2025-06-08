import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rarbg_reader/util/rarbg_db_fetcher.dart';

import '../../theming/ThemeNotifier.dart';
import 'db_result_item.dart';

class DbViewer extends StatefulWidget {
  final ThemeNotifier themeNotifier;
  const DbViewer({super.key, required this.themeNotifier});

  @override
  State<DbViewer> createState() => _DbViewerState();
}

class _DbViewerState extends State<DbViewer> {
  final _searchController = TextEditingController();
  List<Map<String, String>> _moviesList = [];
  List<String> _categoryListList = [];
  String _selectedCategory = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _isLoading = true;
    RarbgDbFetcher.getCategories().then(
      (categories) => {
        setState(() {
          _categoryListList = categories;
          _selectedCategory = categories[0];
        }),

        getMoviesByCategory(),
      },
    );
  }

  Future<Set<void>> getMoviesByCategory() {
    return RarbgDbFetcher.getMoviesListByCategory(_selectedCategory).then(
      (list) => {
        setState(() {
          _isLoading = false;
          _moviesList = list;
        }),
      },
    );
  }

  void onCategorySelected(String cat) {
    setState(() {
      _isLoading = true;
      _selectedCategory = cat;
      getMoviesByCategory();
    });
  }

  void onQuerySubmitted(String query) {
    setState(() {
      _isLoading = true;
    });
    RarbgDbFetcher.getMoviesList(query).then(
      (movieTitle) => {
        setState(() {
          _isLoading = false;
          _moviesList = movieTitle;
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Total Items: ${_moviesList.length}',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: [
            Center(
              child: Visibility(
                visible: _isLoading,
                child: CircularProgressIndicator(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            onQuerySubmitted(value);
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).textTheme.bodyLarge!.color!,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).textTheme.bodyLarge!.color!,
                              ),
                            ),
                            hintText: 'Search',
                            suffixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).textTheme.bodyLarge!.color!,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.light_mode,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            Switch(
                              value: widget.themeNotifier.value == ThemeMode.dark,
                              onChanged: (bool isDarkMode) {
                                widget.themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
                              },
                            ),
                            Icon(
                              Icons.dark_mode,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ), // search bar
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categoryListList.map((cat) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ChoiceChip(
                            checkmarkColor: Theme.of(context).chipTheme.checkmarkColor,
                            label: Text(cat),
                            selected: _selectedCategory == cat,
                            onSelected: (bool selected) {
                              onCategorySelected(cat);
                            },
                            backgroundColor: Theme.of(context).chipTheme.backgroundColor,
                            selectedColor: Theme.of(context).chipTheme.selectedColor,
                            labelStyle: TextStyle(
                              color: _selectedCategory == cat
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_isLoading,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: _moviesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DbResultItem(
                          title: _moviesList[index]['title'],
                          magnet: _moviesList[index]['magnet'],
                        );
                      },
                    ),
                  ),
                ), // ListView
              ],
            ),
          ],
        ),
      ),
    );
  }
}
