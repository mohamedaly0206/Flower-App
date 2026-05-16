import 'dart:async';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/entities/occasions_response_entity.dart';
import 'package:flower_app/features/occasion/domain/repositories/occasion_repo_contract.dart';
import 'package:flower_app/features/occasion/domain/use_cases/get_occasions_use_case.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_cubit.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_state.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Fake repository — lets tests control what getOccasions() returns.
// ---------------------------------------------------------------------------
class _FakeOccasionRepo implements OccasionRepoContract {
  BaseResponse<OccasionsResponseEntity>? response;
  Completer<BaseResponse<OccasionsResponseEntity>>? completer;
  int callsCount = 0;

  @override
  Future<BaseResponse<OccasionsResponseEntity>> getOccasions() {
    callsCount++;
    final c = completer;
    if (c != null) return c.future;
    return Future.value(response);
  }
}

// ---------------------------------------------------------------------------
// Helper — builds an entity list with the given names.
// ---------------------------------------------------------------------------
List<OccasionEntity> _makeOccasions(List<String> names) {
  return names
      .map(
        (n) => OccasionEntity(
          id: n,
          name: n,
          slug: n.toLowerCase(),
          image: 'https://img/$n.jpg',
        ),
      )
      .toList();
}

void main() {
  group('OccasionCubit', () {
    late _FakeOccasionRepo repo;
    late OccasionCubit cubit;

    setUp(() {
      repo = _FakeOccasionRepo();
      cubit = OccasionCubit(GetOccasionsUseCase(repo));
    });

    tearDown(() async {
      await cubit.close();
    });

    // -----------------------------------------------------------------------
    // Initial state
    // Verifies the cubit starts with OccasionInitial before any action.
    // -----------------------------------------------------------------------
    test('starts with OccasionInitial', () {
      expect(cubit.state, isA<OccasionInitial>());
    });

    // -----------------------------------------------------------------------
    // Loading → Success
    // Verifies the cubit emits [OccasionLoading, OccasionSuccess] in order
    // and that the success state holds the correctly mapped entity list.
    // -----------------------------------------------------------------------
    test(
      'emits [OccasionLoading, OccasionSuccess] on successful fetch',
      () async {
        // Arrange
        final occasions = _makeOccasions(['Birthday', 'Wedding']);
        repo.response = SuccessBaseResponse(
          data: OccasionsResponseEntity(message: 'ok', occasions: occasions),
        );
        final emitted = <OccasionState>[];
        final sub = cubit.stream.listen(emitted.add);

        // Act
        await cubit.getOccasions();
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        // Assert
        expect(emitted, hasLength(2));
        expect(emitted[0], isA<OccasionLoading>());
        expect(emitted[1], isA<OccasionSuccess>());

        final success = emitted[1] as OccasionSuccess;
        expect(success.occasions, hasLength(2));
        expect(success.occasions[0].name, 'Birthday');
        expect(success.occasions[1].name, 'Wedding');
        expect(success.selectedTabIndex, 0); // default tab
      },
    );

    // -----------------------------------------------------------------------
    // Loading → Success with empty list
    // Validates that when the API returns an empty occasions array the cubit
    // still emits OccasionSuccess (not a failure) with an empty list.
    // -----------------------------------------------------------------------
    test(
      'emits OccasionSuccess with empty list when occasions are empty',
      () async {
        // Arrange
        repo.response = SuccessBaseResponse(
          data: OccasionsResponseEntity(message: 'ok', occasions: []),
        );
        final emitted = <OccasionState>[];
        final sub = cubit.stream.listen(emitted.add);

        // Act
        await cubit.getOccasions();
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        // Assert
        expect(emitted[1], isA<OccasionSuccess>());
        expect((emitted[1] as OccasionSuccess).occasions, isEmpty);
      },
    );

    // -----------------------------------------------------------------------
    // Loading → Success — null occasions falls back to empty list
    // Validates that the null-coalescing fallback in the cubit (`?? []`)
    // prevents a null reference and still emits a valid OccasionSuccess.
    // -----------------------------------------------------------------------
    test('falls back to empty list when occasions field is null', () async {
      // Arrange — occasions field is null on the response entity
      repo.response = SuccessBaseResponse(
        data: OccasionsResponseEntity(message: 'ok', occasions: null),
      );
      final emitted = <OccasionState>[];
      final sub = cubit.stream.listen(emitted.add);

      // Act
      await cubit.getOccasions();
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      // Assert
      expect(emitted[1], isA<OccasionSuccess>());
      expect((emitted[1] as OccasionSuccess).occasions, isEmpty);
    });

    // -----------------------------------------------------------------------
    // Loading → Failure
    // Verifies the cubit emits [OccasionLoading, OccasionFailure] in order
    // and that the failure state carries the error message returned by the
    // repository.
    // -----------------------------------------------------------------------
    test(
      'emits [OccasionLoading, OccasionFailure] on error response',
      () async {
        // Arrange
        repo.response = ErrorBaseResponse(
          errorMessage: 'Something went wrong, please try again later',
        );
        final emitted = <OccasionState>[];
        final sub = cubit.stream.listen(emitted.add);

        // Act
        await cubit.getOccasions();
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        // Assert
        expect(emitted, hasLength(2));
        expect(emitted[0], isA<OccasionLoading>());
        expect(emitted[1], isA<OccasionFailure>());

        final failure = emitted[1] as OccasionFailure;
        expect(
          failure.errorMessage,
          'Something went wrong, please try again later',
        );
      },
    );

    // -----------------------------------------------------------------------
    // Idempotency while loading
    // Verifies that a second call to getOccasions() while the first is still
    // in-flight is ignored — the repository is called exactly once.
    // -----------------------------------------------------------------------
    test(
      'ignores concurrent getOccasions calls while already loading',
      () async {
        // Arrange — hold the future so we can control when it resolves
        repo.completer = Completer<BaseResponse<OccasionsResponseEntity>>();

        // Act — fire first call (in-flight) then immediately fire a second
        final first = cubit.getOccasions();
        await Future<void>.delayed(Duration.zero); // let cubit emit Loading

        await cubit.getOccasions(); // must be a no-op

        // Resolve the first call
        repo.completer!.complete(
          SuccessBaseResponse(
            data: OccasionsResponseEntity(
              message: 'ok',
              occasions: _makeOccasions(['Eid']),
            ),
          ),
        );
        await first;

        // Assert — repository was hit only once
        expect(repo.callsCount, 1);
      },
    );

    // -----------------------------------------------------------------------
    // selectTab
    // Verifies that selectTab emits a new OccasionSuccess with the updated
    // selectedTabIndex and that the occasions list remains unchanged.
    // -----------------------------------------------------------------------
    test('selectTab updates selectedTabIndex inside OccasionSuccess', () async {
      // Arrange — put cubit into success state first
      final occasions = _makeOccasions(['Christmas']);
      repo.response = SuccessBaseResponse(
        data: OccasionsResponseEntity(message: 'ok', occasions: occasions),
      );
      await cubit.getOccasions();

      final emitted = <OccasionState>[];
      final sub = cubit.stream.listen(emitted.add);

      // Act
      cubit.selectTab(2);
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      // Assert
      expect(emitted, hasLength(1));
      final updated = emitted.first as OccasionSuccess;
      expect(updated.selectedTabIndex, 2);
      expect(updated.occasions, hasLength(1));
    });

    // -----------------------------------------------------------------------
    // selectTab — no-op when not in success state
    // Verifies selectTab does nothing when called before occasions are loaded.
    // -----------------------------------------------------------------------
    test('selectTab is a no-op when state is not OccasionSuccess', () async {
      // Arrange — cubit is in OccasionInitial
      final emitted = <OccasionState>[];
      final sub = cubit.stream.listen(emitted.add);

      // Act
      cubit.selectTab(1);
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      // Assert — no new state was emitted
      expect(emitted, isEmpty);
    });
  });
}
