import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Para acceder 
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: ( _ ) => ProductFormProvider(productService.selectedProduct),
        child: _ProductsScreenBody(productService: productService,),
      );

    // return _ProductsScreenBody(productService: productService);
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      //El single child scroll view es muy bueno para formularios
      body: SingleChildScrollView(
        //Es para que cuando se haga scroll se oculte
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct?.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(), 
                    icon: Icon(Icons.arrow_back_ios, size: 40, color: Colors.white,)
                    )
                    ),
                  Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    
                    onPressed: () async{
                      
                      //Instancia del imagePicker
                      final picker = new ImagePicker();
                      //Es opcional
                      // final PickedFile? pickedFile = await picker.getImage(
                      //   //En IOS no funciona la camara asi nomas
                      //   //source: ImageSource.gallery,
                      //   source: ImageSource.camera,
                      //   imageQuality: 100
                      //   );

                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        //source: ImageSource.camera,
                        imageQuality: 100,
                        );


                        if(pickedFile == null){
                          print('No seleccion nada');

                          //return;
                        }
                        print('Tenemos imagen ${pickedFile!.path}');
                         productService.updateSelectedProductImage(pickedFile.path);
                    },
                    
                    //onPressed: () => Navigator.of(context).pop(), 
                    icon: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,))
                    ),
              ],
            ),

            _ProductForm(),

            SizedBox(height: 100,),

          ],
          
        ),
        
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: () async {
          //TODO Guardar producto

          //productForm.isValidForm();
          if (!productForm.isValidForm() ) return;

          final String? imageUrl = await productService.uploadImage();

          print(imageUrl);

          if(imageUrl != null) productForm.product?.picture = imageUrl;
          
          await productService.saveOrCreateProduct(productForm.product!);
          
        }),

   );
  }
}

class _ProductForm extends StatelessWidget {
  // const _ProductForm({
  //   Key? key,
  // }) : super(key: key);



  @override
  Widget build(BuildContext context) {

  final productForm = Provider.of<ProductFormProvider>(context);
  final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        //height: 300,
        decoration: _buildBoxDecoration(),
        child: Form(

          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10,),

              TextFormField(
                initialValue: product!.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if(value == null || value.length <1)
                   return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del producto', 
                  labelText: 'Nombre:'),
              ),
              SizedBox(height: 30,),

              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  //Expresion regular 
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: ((value) {
                  if(double.tryParse(value) == null){
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                }),
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150', 
                  labelText: 'Precio:'),
              ),
              SizedBox(height: 30,),

              SwitchListTile.adaptive(
                value: product.available, 
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: productForm.updateAvailability
              ),
                SizedBox(height: 30,)
            ],
          )
          ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: Offset(0, 5),
        blurRadius: 5
      )
    ]
  );
}