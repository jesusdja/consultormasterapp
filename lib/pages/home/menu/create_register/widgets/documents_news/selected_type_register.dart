import 'package:consultormasterapp/config/master_colors.dart';
import 'package:consultormasterapp/config/master_style.dart';
import 'package:consultormasterapp/initial_page.dart';
import 'package:consultormasterapp/pages/home/menu/create_register/provider/create_register_provider.dart';
import 'package:consultormasterapp/widgets_utils/dialog_alert.dart';
import 'package:consultormasterapp/widgets_utils/dropdown_button_general.dart';
import 'package:consultormasterapp/widgets_utils/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedTypeRegister extends StatefulWidget {
  const SelectedTypeRegister({Key? key}) : super(key: key);

  @override
  State<SelectedTypeRegister> createState() => _CreateRegisterState();
}

class _CreateRegisterState extends State<SelectedTypeRegister> {

  late CreateRegisterProvider createRegisterProvider;

  @override
  Widget build(BuildContext context) {
    createRegisterProvider = Provider.of<CreateRegisterProvider>(context);
    return body();
  }

  Widget body(){
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: sizeH * 0.1),
            Container(
              width: sizeW,
              margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
              child: Text('Seleccionar el tipo de documento',style: MasterStyles().stylePrimary(
                fontWeight: FontWeight.bold ,size: sizeH * 0.03,
              ),textAlign: TextAlign.center),
            ),
            SizedBox(height: sizeH * 0.05),
            selectedWidget(),
            Expanded(child: Container()),
            buttonTypes(),
            SizedBox(height: sizeH * 0.05),
          ],
        ),
      ),
    );
  }

  Widget selectedWidget(){
    return Container(
      width: sizeW,
      height: sizeH * 0.05,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
      child: DropdownGeneral(
        value: createRegisterProvider.typeSelected,
        items: createRegisterProvider.typesSt.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          createRegisterProvider.typeSelected = newValue ?? createRegisterProvider.typesSt[0];
        },
        menuMaxHeight: sizeH * 0.5,
        itemHeight: sizeH * 0.06,
        textStyle: MasterStyles().styleKalam(size: sizeH * 0.018),
      ),
    );
  }

  Widget buttonTypes(){
    Color colorText = Colors.white;
    String title = 'Continuar';

    return InkWell(

      onTap: () async {
        if(createRegisterProvider.typeSelected != createRegisterProvider.typesSt[0]){
          bool? res = await alertCard();
          if(res!){
            createRegisterProvider.typeSt = createRegisterProvider.typeSelected;
          }
        }else{
          showAlert(text: 'Debe seleccionar al menos una opcion valida',isError: true);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: sizeH * 0.01),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: sizeW * 0.1),
        decoration: const BoxDecoration(
          color: MasterColors.primary4,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
              color: MasterColors.primary3,
              offset: Offset(10.0,10.0),
              spreadRadius: -10,
              blurRadius: 20,
            )
          ],
        ),
        child: Center(
          child: Text(title,style: MasterStyles().stylePrimary(
              size: sizeH * 0.02,color: colorText,fontWeight: FontWeight.bold
          ),textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
