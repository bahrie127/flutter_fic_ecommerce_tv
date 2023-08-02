import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic6_ecommerce_tv/bloc/search/search_bloc.dart';

import '../detail_product/detail_product_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    required this.search,
  }) : super(key: key);
  final String search;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.text = widget.search;
    context.read<SearchBloc>().add(
          SearchEvent.search(widget.search),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Color(0xffEE4D2D)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 3,
                    child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (_) {
                        context.read<SearchBloc>().add(
                              SearchEvent.search(searchController.text),
                            );
                      },
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search ',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(child: Text('data not found'));
            },
            loaded: (data) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final product = data.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailProductPage(product: product);
                      }));
                    },
                    child: Card(
                      elevation: 5,
                      shadowColor: Color(0xffEE4D2D),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(product.attributes!.image!),
                        ),
                        title: Text(product.attributes!.name!),
                      ),
                    ),
                  );
                },
                itemCount: data.data!.length,
              );
            },
          );
        },
      ),
    );
  }
}
