import 'package:e_commers_app/module/fav_noti_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commers_app/module/model/products_detail_model.dart';
import 'package:e_commers_app/module/products_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'api_service/api_service.dart';
import 'model/category_model.dart';
import 'model/product_model.dart';
import 'products_detail_screen.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>> _homeData;
  PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  final List<String> _imagePaths = [
    'images/16987373017frli-photo-2023-10-31-14-17-09.jpg',
    'images/Visa-Promotion-ProEng.jpg',
    'images/Website-Booking.com-Promotion-Visa.png',
    'images/16987373017frli-photo-2023-10-31-14-17-09.jpg',
    'images/Visa-Promotion-ProEng.jpg',
  ];
  List<String> _productImageUrlsToPrecache = [];

  @override
  void initState() {
    super.initState();
    _homeData = _loadHomeData();
    _startAutoSlideShow();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-cache asset images for the slideshow
    for (var path in _imagePaths) {
      precacheImage(AssetImage(path), context);
    }
    // Pre-cache network images for products after data is loaded
    _homeData.then((data) {
      final productsModel = data['Products'] as ProductsModel;
      final allProducts = productsModel.categories
          .expand((category) => category.products)
          .toList();
      for (var product in allProducts) {
        _productImageUrlsToPrecache.add(fixUrl(product.image));
      }
      for (var imageUrl in _productImageUrlsToPrecache) {
        precacheImage(NetworkImage(imageUrl), context);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoSlideShow() {
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (!_controller.hasClients) return; // Check if controller is attached
      int nextPage = _currentIndex + 1;
      if (nextPage >= _imagePaths.length) {
        nextPage = 0;
      }
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<Map<String, dynamic>> _loadHomeData() async {
    final categories = await ApiService().getCategoryList();
    final productsModel = await ApiService().getProductsList();

    return {
      'categories': categories,
      'Products': productsModel,
    };
  }

  void reloadData() {
    setState(() {
      _homeData = _loadHomeData();
      _productImageUrlsToPrecache
          .clear(); // Clear old URLs for fresh pre-caching
    });
  }

  String fixUrl(String url) {
    if (url.startsWith('https://')) {
      return url.replaceFirst('https://', 'http://');
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final languageData = context.watch<LanguageLogic>().language;
    return Scaffold(
      appBar: _buildAppBar(context, languageData),
      body: _buildBody(context, languageData),
    );
  }

  PreferredSize _buildAppBar(BuildContext context, Language languageData) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            languageData.Mega_Mall, // Use translated string
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          actions: [
            IconButton(
              icon: Image.asset(
                'images/notification_icon.png',
                height: 20,
                width: 20,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            IconButton(
              icon: Image.asset(
                'images/shopping_icon.png',
                height: 20,
                width: 20,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, Language languageData) {
    return RefreshIndicator(
      onRefresh: () async {
        reloadData();
      },
      child: FutureBuilder<Map<String, dynamic>>(
        future: _homeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${languageData.Error} ${snapshot.error}')); // Use translated string
          } else if (!snapshot.hasData) {
            return Center(child: Text(languageData.No_data_found)); // Use translated string
          }
          final categories = snapshot.data!['categories'] as CategoryModel;
          final allCategory = categories.categories;

          final productsModel = snapshot.data!['Products'] as ProductsModel;
          final allProducts = productsModel.categories
              .expand((category) => category.products)
              .toList();

  

  

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _build_search(context, languageData),
                buildAutoSlideShow(context, languageData), // Pass languageData if needed for future strings
                _buildCategory(context, languageData, allCategory, productsModel.categories),
                const SizedBox(height: 16),
                _buildMainProduct(context, languageData, allProducts),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _build_search(BuildContext context, Language languageData) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: languageData.Search_Product_Name, // Use translated string
              hintStyle: const TextStyle(color: Color(0xFFC4C5C4)),
              border: InputBorder.none, // Use translated string
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14), // <== add this line
              suffixIcon: Icon(
                Icons.search,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAutoSlideShow(BuildContext context, Language languageData) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: _imagePaths.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      _imagePaths[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('${languageData.Error_loading} $error'); // Use translated string
                        return const Icon(Icons.broken_image, size: 50);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_imagePaths.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 12 : 8,
                  height: _currentIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, Language languageData, List<Category_main> categories, List<Category> productCategories) {
    if (categories.isEmpty) {
      return Center(child: Text(languageData.No_categories_found)); // Use translated string
    }

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  languageData.Categories, // Use translated string
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final int categoryId = category.id;

                final imageUrl = fixUrl(category.image);
                return GestureDetector(
                  onTap: () {
                    final categoryData = productCategories.firstWhere(
                      (cat) => cat.id == categoryId,
                      orElse: () => Category(id: 0, name: '', products: []),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsScreen(
                          products: categoryData.products,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Column(
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              imageUrl,
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                debugPrint('${languageData.Error_Cate} $error'); // Use translated string
                                return const Icon(Icons.broken_image, size: 40);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 60,
                          child: Text(
                            category.name,
                            style: const TextStyle(fontSize: 12),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainProduct(BuildContext context, Language languageData, List<Product> products) {
    return Column(
      children: [
        buildFeaturedProduct(context, languageData, products),
        const SizedBox(height: 8),
        buildBestSellers(context, languageData, products),
        const SizedBox(height: 8),
        buildTopRatedProduct(context, languageData, products),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildFeaturedProduct(BuildContext context, Language languageData, List<Product> products) {
    if (products.isEmpty) {
      return const Center(child: Text('No products found.'));
    }
    // Limit to the first 2 products for the "Featured Product" section
    final displayProducts = products.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languageData.All_Product, 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductsScreen(products: products),
                    ),
                  );
                },
                child: Text(
                  languageData.See_All, 
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayProducts.length, 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = displayProducts[index];
              final imageUrl = fixUrl(product.image);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductsDetailScreen(
                        product: ProductsDetailModel.fromProductModel(product),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) {
                              debugPrint('${languageData.Error_loadi} $error'); 
                              return const Icon(Icons.broken_image, size: 50);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(Icons.more_vert,
                                size: 20, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildBestSellers(BuildContext context, Language languageData, List<Product> products) {
    if (products.isEmpty) {
      return Center(child: Text(languageData.No_products_found)); // Use translated string
    }
    final lowPriceProducts = List<Product>.from(products)
      ..sort((a, b) => double.parse(a.price).compareTo(double.parse(b.price)));

    // Limit to the first 2 products for the "Best Sellers" section
    final displayProducts = lowPriceProducts.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languageData.Best_Sellers, 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductsScreen(products: lowPriceProducts),
                    ),
                  );
                },
                child: Text(
                  languageData.See_All,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayProducts
                .length, 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = displayProducts[index];
              final imageUrl = fixUrl(product.image);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductsDetailScreen(
                        product: ProductsDetailModel.fromProductModel(product),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) {
                                debugPrint('${languageData.Error_loadi} $error'); 
                                return const Icon(Icons.broken_image, size: 50);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(Icons.more_vert,
                                size: 20, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildTopRatedProduct(BuildContext context, Language languageData, List<Product> products) {
    if (products.isEmpty) {
      return Center(child: Text(languageData.No_products_found)); 
    }
    final topRatedProducts = List<Product>.from(products)
      ..sort((a, b) => b.rating.compareTo(a.rating));

    // Limit to the first 2 products for the "Top Rated Products" section
    final displayProducts = topRatedProducts.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languageData.Top_Rated_Products, // Use translated string
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductsScreen(products: topRatedProducts),
                    ),
                  );
                },
                child: Text(
                  languageData.See_All,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayProducts.length, 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = displayProducts[index];
              final imageUrl = fixUrl(product.image);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductsDetailScreen(
                        product: ProductsDetailModel.fromProductModel(product),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) {
                                debugPrint('${languageData.Error_loadi} $error');
                                return const Icon(Icons.broken_image, size: 50);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(Icons.more_vert,
                                size: 20, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
