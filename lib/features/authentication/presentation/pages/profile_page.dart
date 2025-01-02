import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/exceptions/app_global_exception.dart';
import 'package:recipe_app/features/authentication/presentation/riverpod/profile_displayer_rp.dart';

import '../../../../extensions/error_widget.dart';

@RoutePage()
class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final ts = Theme.of(context).textTheme;
    final profileData = ref.watch(profileInformationProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: profileData.when(
          skipLoadingOnRefresh: false,
          data: (data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
                ),
                Row(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    data.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Wrap(
                  spacing: 5,
                  children: [
                    Text(data.firstName,
                        style: ts.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Text(data.lastName,
                        style: ts.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(
                  "@${data.username}",
                  style: ts.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
                ),
                Spacer(
                  flex: 5,
                ),
              ],
            );
          },
          error: (e, _) {
            return CustomErrorWidget(
              message: e is AppGlobalException ? e.message : e.toString(),
              onRetry: () {
                ref.invalidate(profileInformationProvider);
              },
            );
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
