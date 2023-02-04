// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dw9_delivery_appp/app/dto/order_product_dto.dart';
import 'package:equatable/equatable.dart';

import 'package:dw9_delivery_appp/app/models/product_model.dart';
import 'package:match/match.dart';
part 'home_state.g.dart';

@match
enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;
  final List<ProductModel> products;
  final List<OrderProductDto> shoppingBag;

  const HomeState({
    required this.status,
    required this.products,
    required this.shoppingBag,
    required this.errorMessage,
  });

  const HomeState.intial()
      : status = HomeStatus.initial,
        errorMessage = null,
        products = const [],
        shoppingBag = const [];

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<ProductModel>? products,
    List<OrderProductDto>? shoppingBag,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      shoppingBag: shoppingBag ?? this.shoppingBag,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage, shoppingBag];
}
