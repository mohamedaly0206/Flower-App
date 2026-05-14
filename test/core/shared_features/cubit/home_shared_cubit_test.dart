import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/shared_features/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/shared_features/intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/states/home_shared_states.dart';
import 'package:flower_app/features/best_seller/domain/models/best_seller_model.dart';
import 'package:flower_app/features/best_seller/domain/repo/best_seller_repo_contract.dart';
import 'package:flower_app/features/best_seller/domain/use_case/best_seller_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeBestSellerRepo implements BestSellerRepoContract {
  int callsCount = 0;
  BaseResponse<List<BestSellerModel>>? response;
  Completer<BaseResponse<List<BestSellerModel>>>? completer;

  @override
  Future<BaseResponse<List<BestSellerModel>>> getBestSeller() {
    callsCount++;

    final completer = this.completer;
    if (completer != null) {
      return completer.future;
    }

    return Future.value(response);
  }
}

void main() {
  group('HomeSharedCubit best sellers', () {
    late _FakeBestSellerRepo repo;
    late HomeSharedCubit cubit;

    final bestSellers = [
      BestSellerModel(
        id: '1',
        title: 'Red Rose Bouquet',
        imgCover: 'https://example.com/rose.png',
        price: 300,
        priceAfterDiscount: 250,
        discount: 15,
      ),
    ];

    setUp(() {
      repo = _FakeBestSellerRepo();
      cubit = HomeSharedCubit(BestSellerUseCase(repo));
    });

    tearDown(() async {
      await cubit.close();
    });

    test('starts with initial state', () {
      expect(cubit.state, const HomeSharedStates());
    });

    blocTest<HomeSharedCubit, HomeSharedStates>(
      'emits loading then best sellers data on success',
      build: () {
        repo.response = SuccessBaseResponse(data: bestSellers);
        return cubit;
      },
      act: (cubit) => cubit.handleHomeSharedIntent(GetBestSellersIntent()),
      expect: () => [
        const HomeSharedStates(
          bestSellersState: BaseState<List<BestSellerModel>>(isLoading: true),
        ),
        HomeSharedStates(
          bestSellersState: BaseState<List<BestSellerModel>>(data: bestSellers),
        ),
      ],
    );

    blocTest<HomeSharedCubit, HomeSharedStates>(
      'emits loading then error message on failure',
      build: () {
        repo.response = ErrorBaseResponse(errorMessage: 'network error');
        return cubit;
      },
      act: (cubit) => cubit.handleHomeSharedIntent(GetBestSellersIntent()),
      expect: () => const [
        HomeSharedStates(
          bestSellersState: BaseState<List<BestSellerModel>>(isLoading: true),
        ),
        HomeSharedStates(
          bestSellersState: BaseState<List<BestSellerModel>>(
            errorMessage: 'network error',
          ),
        ),
      ],
    );

    blocTest<HomeSharedCubit, HomeSharedStates>(
      'gets best sellers when GetBestSellersIntent is handled',
      build: () {
        repo.response = SuccessBaseResponse(data: bestSellers);
        return cubit;
      },
      act: (cubit) => cubit.handleHomeSharedIntent(GetBestSellersIntent()),
      expect: () => [
        const HomeSharedStates(
          bestSellersState: BaseState<List<BestSellerModel>>(isLoading: true),
        ),
        HomeSharedStates(
          bestSellersState: BaseState<List<BestSellerModel>>(data: bestSellers),
        ),
      ],
      verify: (_) {
        expect(repo.callsCount, 1);
      },
    );

    test('ignores duplicate best seller requests while loading', () async {
      repo.completer = Completer<BaseResponse<List<BestSellerModel>>>();

      final firstRequest = cubit.handleHomeSharedIntent(GetBestSellersIntent());
      await Future<void>.delayed(Duration.zero);

      cubit.handleHomeSharedIntent(GetBestSellersIntent());

      expect(repo.callsCount, 1);

      repo.completer!.complete(SuccessBaseResponse(data: bestSellers));

      await firstRequest;

      expect(cubit.state.bestSellersState.isLoading, false);
      expect(cubit.state.bestSellersState.data, bestSellers);
    });
  });
}
