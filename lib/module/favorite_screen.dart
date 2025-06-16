import 'package:e_commers_app/module/model/fav_noti_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commers_app/module/api_service/api_fav.dart';
import 'package:e_commers_app/module/model/productfav.dart';
class MyFavScreen extends StatefulWidget {
  const MyFavScreen({Key? key}) : super(key: key);

  @override
  State<MyFavScreen> createState() => _MyFavScreenState();
}

class _MyFavScreenState extends State<MyFavScreen> {
  int selectedFilterIndex = 0;
  final List<String> filters = ['All', 'Latest', 'Most Popular', 'Cheapest','Expensive'];
  final TextEditingController _searchController = TextEditingController();
  List<ProductFavModel> products = [];
  List<ProductFavModel> filteredProducts = [];
  Set<int> favoriteIds = {};
  bool isLoading = true;
  String? errorMessage;
  SortOption? currentSort;

  final ApiFav apiFav = ApiFav();
@override
void initState() {
  super.initState();
  // Initialize empty list and load products
  filteredProducts = [];
  loadFavorites();
}

  Future<void> loadFavorites() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final fetchedProducts =
          await apiFav.getProductfav(); // <-- call from ApiFav

      setState(() {
        products = fetchedProducts;
        filteredProducts = fetchedProducts;
        isLoading = false;
      });

      _applyFilter();
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "There was a problem retrieving data: $e";
      });
    }
  }
void _sortProducts(SortOption option) {
    setState(() {
      currentSort = option;
      switch (option) {
        case SortOption.priceHighToLow:
          filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        case SortOption.priceLowToHigh:
          filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        case SortOption.nameAZ:
          filteredProducts.sort((a, b) => a.title.compareTo(b.title));
        case SortOption.nameZA:
          filteredProducts.sort((a, b) => b.title.compareTo(a.title));
      }
    });
  }
  void _applyFilter() {
    setState(() {
      switch (selectedFilterIndex) {
        case 1:
          filteredProducts = List.from(products)
            ..sort((a, b) => b.id.compareTo(a.id));
          break;
        case 2:
          filteredProducts = List.from(products)
            ..sort((a, b) => a.category.compareTo(b.category));
          break;
        case 3:
          filteredProducts = List.from(products)
            ..sort((a, b) => a.price.compareTo(b.price));
          break;
        case 4:
          filteredProducts = List.from(products)
            ..sort((a, b) => b.price.compareTo(a.price));
          break;

        default:
          filteredProducts = products;
      }
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'My Favorite',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false, // This prevents the back button
      actions: [
        GestureDetector( // Remove extra Padding widget
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationScreen(),
              ),
            );
          },
          child: Container( // Use Container for more controlled padding
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              'images/notification_icon_true.jpg',
              width: 20,
              height: 20,
              fit: BoxFit.contain, // Ensure the image fits well
            ),
          ),
        ),
      ],
    ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildFilterTabs(),
            const SizedBox(height: 20),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

 Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
       child: Row(
        children: [
          // Clickable search icon
          InkWell(
            onTap: () {
              final searchText = _searchController.text;
              setState(() {
                filteredProducts = products.where((product) =>
                  product.title.toLowerCase().contains(searchText.toLowerCase()) ||
                  product.category.toLowerCase().contains(searchText.toLowerCase())
                ).toList();
                // Maintain current sort after searching
                if (currentSort != null) {
                  _sortProducts(currentSort!);
                }
              });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search, color: Colors.grey),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search something...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                setState(() {
                  filteredProducts = products.where((product) =>
                    product.title.toLowerCase().contains(value.toLowerCase()) ||
                    product.category.toLowerCase().contains(value.toLowerCase())
                  ).toList();
                  // Maintain current sort after filtering
                  if (currentSort != null) {
                    _sortProducts(currentSort!);
                  }
                });
              },
            ),
          ),
          PopupMenuButton<SortOption>(
            icon: Icon(Icons.tune, color: Colors.grey[600]),
            onSelected: _sortProducts,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: SortOption.priceHighToLow,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_downward,
                      color: currentSort == SortOption.priceHighToLow
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    const Text('Price: High to Low'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: SortOption.priceLowToHigh,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: currentSort == SortOption.priceLowToHigh
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    const Text('Price: Low to High'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: SortOption.nameAZ,
                child: Row(
                  children: [
                    Icon(
                      Icons.sort_by_alpha,
                      color: currentSort == SortOption.nameAZ
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    const Text('Name: A to Z'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: SortOption.nameZA,
                child: Row(
                  children: [
                    Icon(
                      Icons.sort,
                      color: currentSort == SortOption.nameZA
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    const Text('Name: Z to A'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterTabs() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isSelected = selectedFilterIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() => selectedFilterIndex = index);
              _applyFilter();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
              ),
              child: Text(
                filters[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[600],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
Widget _buildContent() {
  if (isLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (errorMessage != null) {
    return Center(child: Text(errorMessage!));
  }

  if (filteredProducts.isEmpty) {
    return const Center(child: Text("No products found"));
  }

  return GridView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    physics: const BouncingScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      mainAxisSpacing: 18,
      crossAxisSpacing: 18,
    ),
    itemCount: filteredProducts.length,
    itemBuilder: (context, index) {
      final product = filteredProducts[index];
      return _buildProductCard(
          product: product,
          isFavorite: favoriteIds.contains(product.id),
          onFavoriteToggle: () {
            setState(() {
              if (favoriteIds.contains(product.id)) {
                favoriteIds.remove(product.id);
              } else {
                favoriteIds.add(product.id);
              }
            });
          },
        );
      },
    );
  }

 Widget _buildProductCard({
  required ProductFavModel product,
  required bool isFavorite,
  required VoidCallback onFavoriteToggle,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Card with Image and Favorite Button Only
      Flexible(
        flex: 3,
        child: Card(
          elevation: 0,
          margin: EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.grey[100],
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(
                  product.image,
                  fit: BoxFit. cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[600],
                        size: 50,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: onFavoriteToggle,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey[600],
                    size: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
      SizedBox(height: 8),
      // Product Details Outside the Card
      Padding(
        padding: EdgeInsets.only(top: 6, left: 4, right: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              product.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              product.category,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
}
enum SortOption {
  priceHighToLow,
  priceLowToHigh,
  nameAZ,
  nameZA,
}

