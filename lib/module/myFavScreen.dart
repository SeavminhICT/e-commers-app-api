import 'package:e_commers_app/constant/constants.dart';
import 'package:e_commers_app/module/fav_noti_screen.dart';
import 'package:e_commers_app/module/model/products_detail_model.dart';
import 'package:flutter/material.dart';
enum SortOption {
  priceHighToLow,
  priceLowToHigh,
  nameAZ,
  nameZA,
}
enum FilterType {
  all,
  latest,
  cheapest,
  expensive
}
class MyFavScreen extends StatefulWidget {
  final List<ProductsDetailModel> favoriteProducts;

  const MyFavScreen({Key? key, required this.favoriteProducts}) : super(key: key);

  @override
  State<MyFavScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyFavScreen> {
  List<ProductsDetailModel> filteredProducts = [];
  final TextEditingController searchController = TextEditingController();
  FilterType selectedFilterType = FilterType.all;
  String selectedFilter = 'All';
@override
void initState() {
  super.initState();
  filteredProducts = widget.favoriteProducts;
  searchController.addListener(() {
    filterProducts(searchController.text);
  });
}

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String fixUrl(String url) {
    if (url.startsWith('https://')) {
      return url.replaceFirst('https://', 'http://');
    }
    return url;
  }
void filterProducts(String query) {
  setState(() {
    if (query.isEmpty) {
      filteredProducts = widget.favoriteProducts;
    } else {
      filteredProducts = widget.favoriteProducts
          .where((product) =>
              product.productName.toLowerCase().contains(query.toLowerCase()) ||
              product.productDescription.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  });
}

void sortProducts(SortOption option) {
  setState(() {
    switch (option) {
      
      case SortOption.nameAZ:
        filteredProducts.sort((a, b) => a.productName.compareTo(b.productName));
        break;
      case SortOption.nameZA:
        filteredProducts.sort((a, b) => b.productName.compareTo(a.productName));
        break;
        case SortOption.priceHighToLow:
        filteredProducts.sort((a, b) => b.productPrice.compareTo(a.productPrice));
        break;
      case SortOption.priceLowToHigh:
        filteredProducts.sort((a, b) => a.productPrice.compareTo(b.productPrice));
        break;
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
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // This prevents the back button
        actions: [
          GestureDetector(
            // Remove extra Padding widget
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            child: Container(
              // Use Container for more controlled padding
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TextField(
              controller: searchController,
              onChanged: filterProducts, // Add this line
              decoration: InputDecoration(
                hintText: 'Search your favotite...',
                border: InputBorder.none,
                icon: const Icon(Icons.search),
                suffixIcon: PopupMenuButton<SortOption>(
                icon: const Icon(Icons.tune),
                onSelected: sortProducts,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<SortOption>>[
                   const PopupMenuItem<SortOption>(
                    value: SortOption.nameAZ,
                    child: Text('Name: A to Z'),
                  ),
                  const PopupMenuItem<SortOption>(
                    value: SortOption.nameZA,
                    child: Text('Name: Z to A'),
                  ),
                  const PopupMenuItem<SortOption>(
                    value: SortOption.priceHighToLow,
                    child: Text('Price: High to Low'),
                  ),
                  const PopupMenuItem<SortOption>(
                    value: SortOption.priceLowToHigh,
                    child: Text('Price: Low to High'),
                  ),
                ],
                ),
              ),
            ),
                        ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilter('All'),
                _buildFilter('Latest'),
                _buildFilter('Cheapest'),
                _buildFilter('Expensive'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _buildProductCard(product);
              },
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildFilter(String label) {
  bool isSelected = selectedFilter == label;
  return Container(
    margin: const EdgeInsets.only(right: 8),
    child: ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600],
        ),
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) {
          setState(() {
            selectedFilter = label;
            switch (label) {
              case 'All':
                filteredProducts = widget.favoriteProducts;
                break;
              case 'Latest':
                // Assuming products have an ID or timestamp, sort by newest first
                filteredProducts = List.from(widget.favoriteProducts)
                  ..sort((a, b) => b.productId.compareTo(a.productId));
                break;
              case 'Cheapest':
                filteredProducts = List.from(widget.favoriteProducts)
                  ..sort((a, b) => a.productPrice.compareTo(b.productPrice));
                break;
              case 'Expensive':
                filteredProducts = List.from(widget.favoriteProducts)
                  ..sort((a, b) => b.productPrice.compareTo(a.productPrice));
                break;
            }
          });
        }
      },
      backgroundColor: Colors.white,
      selectedColor: Colors.blue,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

  Widget _buildProductCard(ProductsDetailModel product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Image.network(
                        fixUrl(product.productImageUrl),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.productDescription,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.productPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
