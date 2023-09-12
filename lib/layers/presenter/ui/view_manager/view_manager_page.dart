import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';
import 'package:apupu_eventos/layers/presenter/ui/view_manager/view_manager_controller.dart';
import 'package:flutter/material.dart';

class ViewManagerPage extends StatefulWidget {
  ViewManagerPage({Key? key}) : super(key: key);
  final controller = ViewManagerController();
  @override
  State<ViewManagerPage> createState() => _ViewManagerPageState();
}

class _ViewManagerPageState extends State<ViewManagerPage> {
  int _totalManager = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: const Text("Gerenciadores")),
        body: SingleChildScrollView(
          child: Column(children: [
            FutureBuilder<List<ManagerEntity>>(
                future: widget.controller.getManagers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Erro na Conexão, tente novamente!"),
                    );
                  } else if (snapshot.hasData) {
                    //totalManagers(snapshot.data!.length);
                    return Column(children: [
                      ...List.generate(
                          snapshot.data!.length,
                          (index) => ListTile(
                                leading: CircleAvatar(
                                    child: Text(snapshot.data![index].name[0]
                                        .toUpperCase())),
                                title: Text(snapshot.data![index].name),
                                subtitle: Text(snapshot.data![index].username),
                              )),
                      //Spacer(),
                    ]);
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                }),
          ]),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Total de Gerenciadores: $_totalManager",
            style:
                TextStyle(fontSize: width * .06, fontWeight: FontWeight.bold),
          ),
        ));
  }

  // totalManagers(int value) async {
  //   _totalManager = value;
  //   await Future.delayed(const Duration(milliseconds: 50), () {
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }
}
