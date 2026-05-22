import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/update_cart_item_quantity_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/response/cart_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class CartApiClient {
  @factoryMethod
  factory CartApiClient(Dio dio) = _CartApiClient;

  @GET(ApiEndpoints.cart)
  Future<CartResponseDto> getCartItems();

  @POST(ApiEndpoints.cart)
  Future<CartResponseDto> addItemToCart(@Body() AddToCartRequest request);

  @PUT('${ApiEndpoints.cart}/{productId}')
  Future<CartResponseDto> updateCartItemQuantity(
    @Path('productId') String productId,
    @Body() UpdateCartQuantityRequest request,
  );

  @DELETE('${ApiEndpoints.cart}/{productId}')
  Future<CartResponseDto> removeItemFromCart(
    @Path('productId') String productId,
  );
}
