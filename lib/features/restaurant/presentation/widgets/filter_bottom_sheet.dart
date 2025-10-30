import 'package:flutter/material.dart';
import '../../domain/usecases/sort_restaurants_usecase.dart';
import '../../../../l10n/app_localizations.dart';
import '../models/restaurant_filter_model.dart';

class FilterBottomSheet extends StatefulWidget {
  final RestaurantFilterModel initialFilters;

  const FilterBottomSheet({super.key, required this.initialFilters});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late RestaurantFilterModel _tempFilters;

  final _defaultFilters = RestaurantFilterModel(
    sortType: SortType.byDistance,
    minRating: 0,
    maxDistance: 0,
    filterVegan: false,
  );

  @override
  void initState() {
    super.initState();
    _tempFilters = widget.initialFilters;
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              i18n.filterAndSort,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(i18n.sortBy),
            SegmentedButton<SortType>(
              segments: [
                ButtonSegment(
                  value: SortType.byDistance,
                  label: Text(i18n.distance),
                  tooltip: i18n.distance,
                  icon: const Icon(Icons.directions_walk),
                ),
                ButtonSegment(
                  value: SortType.byRating,
                  label: Text(i18n.rating),
                  tooltip: i18n.rating,
                  icon: const Icon(Icons.star),
                ),
              ],
              selected: {_tempFilters.sortType},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _tempFilters = _tempFilters.copyWith(
                    sortType: newSelection.first,
                  );
                });
              },
            ),
            const Divider(),
            Tooltip(
              message: i18n.onlyVegans,
              child: SwitchListTile(
                title: Text(i18n.onlyVegans),
                value: _tempFilters.filterVegan,
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.eco),
                onChanged: (newValue) {
                  setState(() {
                    _tempFilters = _tempFilters.copyWith(filterVegan: newValue);
                  });
                },
              ),
            ),
            const Divider(),
            Text(
              "${i18n.minimumRating}: ${_tempFilters.minRating.toStringAsFixed(1)}",
            ),
            Slider(
              value: _tempFilters.minRating,
              min: 0,
              max: 5,
              divisions: 10,
              label: _tempFilters.minRating.toStringAsFixed(1),
              onChanged: (newValue) {
                setState(() {
                  _tempFilters = _tempFilters.copyWith(minRating: newValue);
                });
              },
            ),
            const Divider(),
            Text(
              "${i18n.maximumDistance}: ${_tempFilters.maxDistance.toStringAsFixed(0)} km",
            ),
            Slider(
              value: _tempFilters.maxDistance,
              min: 0,
              max: 20, // (20km máx)
              divisions: 20,
              label: "${_tempFilters.maxDistance.toStringAsFixed(0)} km",
              onChanged: (newValue) {
                setState(() {
                  _tempFilters = _tempFilters.copyWith(maxDistance: newValue);
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Tooltip(
                    message: i18n.clean,
                    child: OutlinedButton(
                      onPressed: _clearModalFilters,
                      child: Text(i18n.clean),
                    ),
                  ),
                ),
                Expanded(
                  child: Tooltip(
                    message: i18n.applyFilters,
                    child: ElevatedButton(
                      child: Text(i18n.applyFilters),
                      onPressed: () {
                        Navigator.pop(context, _tempFilters);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _clearModalFilters() {
    setState(() {
      _tempFilters = _defaultFilters;
    });
  }
}
