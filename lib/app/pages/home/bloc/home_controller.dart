// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_appp/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_appp/app/pages/home/bloc/home_state.dart';
import 'package:dw9_delivery_appp/app/repositories/products/products_repository.dart';

class HomeController extends Cubit<HomeState> {
  final ProductsRepository _repository;
  HomeController(
    this._repository,
  ) : super(const HomeState.intial());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final products = await _repository.findAllProducts();
      emit(state.copyWith(status: HomeStatus.loaded, products: products));
    } on Exception catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: HomeStatus.error, errorMessage: 'Erro ao buscar produtos'),
      );
    }
  }

  void addOrUpdateBag({required OrderProductDto orderProduct}) {
    final shoppingBag = [...state.shoppingBag];
    final orderIndex = shoppingBag
        .indexWhere((order) => order.product == orderProduct.product);

    if (orderIndex > -1) {
      if (orderProduct.amount == 0) {
        shoppingBag.removeAt(orderIndex);
      } else {
        shoppingBag[orderIndex] = orderProduct;
      }
    } else {
      shoppingBag.add(orderProduct);
    }

    emit(state.copyWith(shoppingBag: shoppingBag));
  }

  void updateBag({required List<OrderProductDto> updateBag}) {
    emit(state.copyWith(shoppingBag: updateBag));
  }
}
