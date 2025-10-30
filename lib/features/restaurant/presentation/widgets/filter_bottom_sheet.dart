import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/sort_restaurants_usecase.dart';
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
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              "Filtros e Ordenação",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text("Ordenar por"),
            SegmentedButton<SortType>(
              segments: const [
                ButtonSegment(
                  value: SortType.byDistance,
                  label: Text("Distância"),
                  icon: Icon(Icons.directions_walk),
                ),
                ButtonSegment(
                  value: SortType.byRating,
                  label: Text("Avaliação"),
                  icon: Icon(Icons.star),
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
            Divider(),
            SwitchListTile(
              title: const Text("Apenas veganos"),
              value: _tempFilters.filterVegan,
              contentPadding: EdgeInsets.zero,
              secondary: Icon(Icons.eco),
              onChanged: (newValue) {
                setState(() {
                  _tempFilters = _tempFilters.copyWith(filterVegan: newValue);
                });
              },
            ),
            Divider(),
            Text(
              "Avaliação Mínima: ${_tempFilters.minRating.toStringAsFixed(1)}",
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
            Divider(),
            Text(
              "Distância Máxima: ${_tempFilters.maxDistance.toStringAsFixed(0)} km",
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
            SizedBox(height: 16),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _clearModalFilters,
                    child: const Text("Limpar"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    child: const Text("Aplicar Filtros"),
                    onPressed: () {
                      Navigator.pop(context, _tempFilters);
                    },
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
