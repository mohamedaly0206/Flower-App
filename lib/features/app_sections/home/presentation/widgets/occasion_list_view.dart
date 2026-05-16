import 'package:flower_app/core/shared_features/shared_view_model/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/shared_features/shared_view_model/states/home_shared_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'occasion_list_view_item.dart';

class OccasionListView extends StatelessWidget {
  const OccasionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeSharedCubit, HomeSharedStates>(
      buildWhen: (previous, current) =>
      previous.occasionsState != current.occasionsState,
      builder: (context, state) {
        final occasionsState = state.occasionsState;

        if (occasionsState.isLoading) {
          return SizedBox(
            height: 210,
            child: Center(
              child: SpinKitFadingCircle(
                color: Theme.of(context).colorScheme.primary,
                size: 50,
              ),
            ),
          );
        }

        // error
        if (occasionsState.errorMessage != null) {
          return SizedBox(
            height: 210,
            child: Center(
              child: Text(
                occasionsState.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final occasions = occasionsState.data?.occasions;
        print(occasions);
        if (occasions == null || occasions.isEmpty) {
          return const SizedBox(
            height: 210,
            child: Center(
              child: Text('No Occasions Found'),
            ),
          );
        }

        return SizedBox(
          height: 210,
          child: ListView.separated(
            itemCount: occasions.length,

            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) =>
            const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final occasion = occasions[index];

               return OccasionListViewItem(
                 occasion: occasion,
               );
            },
          ),
        );
      },
    );
  }
}