import 'package:bloc_users_demo/users/data/datasources/users_remote_datasource.dart';
import 'package:bloc_users_demo/users/data/repositories/users_repository_impl.dart';
import 'package:bloc_users_demo/users/domain/usecases/GetUsersUseCase.dart';
import 'package:bloc_users_demo/users/presentation/cubit/UsersCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../cubit/users_state.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersCubit>(
      create: (_) => UsersCubit(
            getUsersUseCase: GetUsersUseCase(
            repository: UsersRepositoryImpl(
            remoteDatasource: UsersRemoteDatasource(),
          ),
        ),
      ),
      child: BlocListener<UsersCubit, UsersState>(
        listenWhen: (previous, current) =>
            previous.status != current.status,
        listener: (context, state) {
          switch (state.status) {
            case UsersStatus.loading:
              debugPrint('Loading...');
              break;

            case UsersStatus.success:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Usuarios cargados'),
                ),
              );
              break;

            case UsersStatus.failure:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? 'Ocurrió un error',
                  ),
                ),
              );
              break;

            case UsersStatus.initial:
            case UsersStatus.empty:
              break;
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Usuarios'),
                actions: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<UsersCubit>(context).fetchUsers();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              body: BlocBuilder<UsersCubit, UsersState>(
                builder: (context, state) {
                  switch (state.status) {
                    case UsersStatus.initial:
                      return Center(
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<UsersCubit>(context).fetchUsers();
                          },
                          child: const Text('Obtener usuarios'),
                        ),
                      );

                    case UsersStatus.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case UsersStatus.empty:
                      return const Center(
                        child: Text('No hay usuarios'),
                      );

                    case UsersStatus.failure:
                      return Center(
                        child: Text(
                          state.errorMessage ?? 'Ocurrió un error',
                        ),
                      );

                    case UsersStatus.success:
                      return ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          final user = state.users[index];

                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(user.id.toString()),
                            ),
                            title: Text(user.name),
                            subtitle: Text(user.email),
                          );
                        },
                      );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}