import 'package:barista_notes/features/pos/domain/usecases/orders/get_item_by_order_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../domain/usecases/orders/create_order_usecase.dart';
import '../../domain/usecases/orders/get_all_orders_usecase.dart';
import '../../domain/usecases/orders/delete_order_usecase.dart';
import '../../domain/repositories/orders_repository.dart';

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
