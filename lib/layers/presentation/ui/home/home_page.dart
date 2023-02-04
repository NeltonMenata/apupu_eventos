import 'package:apupu_eventos/layers/data/datasources/back4app/get_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/save_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/get_guest/get_guest_for_objectId_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/save_guest/save_guest_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/get_guest_for_objectId_usecase/get_guest_entity_for_objectId_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/save_guest/save_guest_usecase_imp.dart';
import 'package:apupu_eventos/layers/presentation/ui/home_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = HomeController(
      SaveGuestUseCaseImp(
        SaveGuestRepositoryImp(
          SaveGuestDataSourceBack4appImp(),
        ),
      ),
      GetGuestForObjectIdUseCaseImp(
        GetGuestForObjectIdRepositoryImp(
          GetGuestDataSourceBack4appImp(),
        ),
      ));

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<GuestEntity>(
              future: widget.controller.getGuest("objectId"),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.name);
                }
                return const Text("Nenhum retorno");
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
