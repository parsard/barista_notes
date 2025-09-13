import 'package:barista_notes/features/pos/domain/entities/product.dart';
import 'package:barista_notes/features/pos/domain/usecases/orders/add_order_item_usecase.dart';
import 'package:barista_notes/features/pos/domain/usecases/orders/get_item_by_order_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../domain/usecases/orders/create_order_usecase.dart';
import '../../domain/usecases/orders/get_all_orders_usecase.dart';
import '../../domain/usecases/orders/delete_order_usecase.dart';
import '../../domain/repositories/orders_repository.dart';

final currentOrderProvider = StateProvider<OrderEntity?>((ref) => null);
final addOrderItemUseCaseProvider = Provider<AddOrderItemUseCase>((ref) {
  final repo = ref.watch(ordersRepositoryProvider);
  return AddOrderItemUseCase(repo);
});
final addItemToOrderProvider = Provider<
  Future<void> Function({required ProductEntity product, required int quantity})
>((ref) {
  return ({required ProductEntity product, required int quantity}) async {
    var currentOrder = ref.read(currentOrderProvider);

    if (currentOrder == null) {
      final order = OrderEntity(
        id: null,
        date: DateTime.now(),
        total: product.price * quantity,
        isPaid: false,
        note: '',
      );

      final orderItem = OrderItemEntity(
        id: null,
        orderId: 0,
        productId: product.id!,
        quantity: quantity,
        price: product.price,
      );

      final newOrderId = await ref.read(createOrderUseCaseProvider).call(
        order,
        [orderItem],
      );

      ref.read(currentOrderProvider.notifier).state = order.copyWith(
        id: newOrderId,
      );
      currentOrder = ref.read(currentOrderProvider);
    }

    await ref
        .read(addOrderItemUseCaseProvider)
        .call(
          orderId: currentOrder!.id!,
          productId: product.id!,
          quantity: quantity,
          price: product.price,
        );
  };
});
final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  throw UnimplementedError('OrdersRepository not implemented');
});

final createOrderUseCaseProvider = Provider<CreateOrderUseCase>((ref) {
  return CreateOrderUseCase(ref.watch(ordersRepositoryProvider));
});

final getAllOrdersUseCaseProvider = Provider<GetAllOrdersUseCase>((ref) {
  return GetAllOrdersUseCase(ref.watch(ordersRepositoryProvider));
});

final getItemsByOrderIdUseCaseProvider = Provider<GetItemsByOrderIdUseCase>((
  ref,
) {
  return GetItemsByOrderIdUseCase(ref.watch(ordersRepositoryProvider));
});

final deleteOrderUseCaseProvider = Provider<DeleteOrderUseCase>((ref) {
  return DeleteOrderUseCase(ref.watch(ordersRepositoryProvider));
});

final allOrdersProvider = FutureProvider<List<OrderEntity>>((ref) {
  return ref.watch(getAllOrdersUseCaseProvider).call();
});

final orderItemsProvider = FutureProvider.family<List<OrderItemEntity>, int>((
  ref,
  orderId,
) {
  return ref.watch(getItemsByOrderIdUseCaseProvider).call(orderId);
});
