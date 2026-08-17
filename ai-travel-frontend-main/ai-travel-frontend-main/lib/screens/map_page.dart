import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../services/api_service.dart';

class MapItem {
  final String name;
  final String category;
  final LatLng location;
  final String type;
  final String date;

  MapItem({
    required this.name,
    required this.category,
    required this.location,
    required this.type,
    this.date = "",
  });
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _defaultLocation = LatLng(31.9454, 35.9284); // Amman

  final MapController _mapController = MapController();

  LatLng _currentLocation = _defaultLocation;
  List<MapItem> _items = [];
  String _searchText = "";
  String _selectedFilter = "All";
  MapItem? _selectedItem;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
    _getCurrentLocation();
  }

  Future<void> _loadItems() async {
    try {
      final places = await ApiService.getPlaces();
      final events = await ApiService.getEvents();

      final items = <MapItem>[
        ...places.map((p) => MapItem(
              name: p["name"] ?? "",
              category: p["category"] ?? "",
              location: LatLng(
                (p["latitude"] as num).toDouble(),
                (p["longitude"] as num).toDouble(),
              ),
              type: "Place",
            )),
        ...events.map((e) => MapItem(
              name: e["name"] ?? "",
              category: e["category"] ?? "",
              location: LatLng(
                (e["latitude"] as num).toDouble(),
                (e["longitude"] as num).toDouble(),
              ),
              type: "Event",
              date: e["date"] ?? "",
            )),
      ];

      if (!mounted) return;
      setState(() {
        _items = items;
        _loading = false;
      });
    } catch (e) {
      debugPrint("Failed to load map items: $e");
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  Future<void> _getCurrentLocation() async {
    final permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      if (!mounted) return;

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });

      _mapController.move(_currentLocation, _mapController.camera.zoom);
    } catch (e) {
      debugPrint("Failed to get current location: $e");
    }
  }

  List<MapItem> get _filteredItems {
    return _items.where((item) {
      final matchesSearch = _searchText.isEmpty ||
          item.name.toLowerCase().contains(_searchText.toLowerCase()) ||
          item.category.toLowerCase().contains(_searchText.toLowerCase());

      final matchesFilter =
          _selectedFilter == "All" || item.type == _selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  Widget _pinMarker({
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          "Explore the Map",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _mapController.move(_currentLocation, 15);
        },
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation,
              initialZoom: 12,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "com.example.ai_travel_frontend",
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentLocation,
                    width: 34,
                    height: 34,
                    child: _pinMarker(
                      icon: Icons.person_pin_circle,
                      color: Colors.blue,
                      onTap: null,
                    ),
                  ),
                  for (final item in _filteredItems)
                    Marker(
                      point: item.location,
                      width: 34,
                      height: 34,
                      child: _pinMarker(
                        icon: item.type == "Event"
                            ? Icons.event
                            : Icons.place,
                        color: item.type == "Event"
                            ? Colors.orange.shade700
                            : Colors.red.shade600,
                        onTap: () => setState(() => _selectedItem = item),
                      ),
                    ),
                ],
              ),
            ],
          ),

          if (_loading)
            Container(
              color: Colors.black.withValues(alpha: 0.05),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            ),

          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Column(
              children: [
                Material(
                  elevation: 4,
                  shadowColor: Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search places or events",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: const Icon(Icons.search, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    onChanged: (value) =>
                        setState(() => _searchText = value),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    for (final filter in ["All", "Place", "Event"])
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(filter),
                          labelStyle: TextStyle(
                            color: _selectedFilter == filter
                                ? Colors.white
                                : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                          selected: _selectedFilter == filter,
                          selectedColor: Colors.blue,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 2,
                          onSelected: (_) =>
                              setState(() => _selectedFilter = filter),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          if (_selectedItem != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _selectedItem!.type == "Event"
                                ? Colors.orange.shade50
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _selectedItem!.type == "Event"
                                ? Icons.event
                                : Icons.place,
                            color: _selectedItem!.type == "Event"
                                ? Colors.orange.shade700
                                : Colors.red.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _selectedItem!.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () =>
                              setState(() => _selectedItem = null),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _selectedItem!.type == "Event"
                          ? "${_selectedItem!.type} • ${_selectedItem!.category} • ${_selectedItem!.date}"
                          : "${_selectedItem!.type} • ${_selectedItem!.category}",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
