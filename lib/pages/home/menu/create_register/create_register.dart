import 'package:consultormasterapp/pages/home/menu/create_register/provider/create_register_provider.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/widgets/register_document_new.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/widgets/selected_type_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRegister extends StatefulWidget {
  const CreateRegister({Key? key}) : super(key: key);

  @override
  State<CreateRegister> createState() => _CreateRegisterState();
}

class _CreateRegisterState extends State<CreateRegister> {

  late CreateRegisterProvider createRegisterProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context1) => CreateRegisterProvider(),
        child: Consumer<CreateRegisterProvider>(
            builder: (context, provider, child){
              createRegisterProvider = provider;
              return body();
            }
        )
    );
  }

  Widget body(){
    Widget selectW = const SelectedTypeRegister();

    if(createRegisterProvider.typeSt == createRegisterProvider.typesSt[1]){
      selectW = const RegisterDocumentNew();
    }
    if(createRegisterProvider.typeSt == createRegisterProvider.typesSt[2]){

    }
    if(createRegisterProvider.typeSt == createRegisterProvider.typesSt[3]){

    }

    return selectW;
  }

}
