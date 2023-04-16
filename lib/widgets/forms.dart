// import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:perfect_flatmate/services/data.dart';
import 'package:perfect_flatmate/util/data_model.dart';
import 'package:perfect_flatmate/util/theme.dart';

// TODO some countries are missed when converting from phone field to csc picker country
// TODO fix inconsistent styling
class FormFieldLabelWrapper extends StatelessWidget {
  final String label;
  final Widget child;
  final bool labelDisabled;
  const FormFieldLabelWrapper({super.key, required this.label, required this.child, this.labelDisabled = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelDisabled?Container():Text(label, style: CustomTheme.body,),
                      SizedBox(height: 4,),
                      child,
                    ],
                  ),
    );
  }
}

class EasyFormField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final bool required;
  final TextEditingController ? textEditingController;
  final String ? Function(String?) ? validator;
  final void Function(String) ? onSubmit;
  final bool labelDisabled;
  const EasyFormField({super.key, this.label = "Text", this.obscureText=false, this.textEditingController, this.validator, this.required=true, this.onSubmit, this.labelDisabled = false});

  @override
  State<EasyFormField> createState() => _EasyFormFieldState();
}

class _EasyFormFieldState extends State<EasyFormField> 
{

  @override
  Widget build(BuildContext context) 
  {
    // if validator null
    var formValidator = widget.validator;
    var enterAction = widget.onSubmit;
    enterAction ??= (value){};
    if(widget.required)
    {
      formValidator ??= (value)
        {
          if (value == null || value.isEmpty) 
          {
              return 'Please enter the ${widget.label}!';
          } 
          return null;
        };
    }
    else
    {
      formValidator ??= (value)
      {
        return null;
      };
    }

    return FormFieldLabelWrapper(
      labelDisabled: widget.labelDisabled,
      label: widget.label,
      child: TextFormField(
        keyboardType: (widget.label == "Email")?TextInputType.emailAddress:TextInputType.text,
        autovalidateMode: AutovalidateMode.disabled,
        onFieldSubmitted: enterAction,
        validator: formValidator,
        obscureText: widget.obscureText,
        obscuringCharacter: "*",
        controller: widget.textEditingController,
        decoration: InputDecoration(
          hintText: "Enter ${widget.label}",
          border:OutlineInputBorder(),
        ),
      ),
    );
  }
}


// class DataForm extends StatefulWidget 
// {
//   const DataForm({super.key});
  
//   @override
//   State<DataForm> createState() => _DataFormState();
// }

// class _DataFormState extends State<DataForm> 
// {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController addressController = TextEditingController();  
//   TextEditingController professionController = TextEditingController();  
//   TextEditingController referenceController = TextEditingController();  

//   String ?nameTitle = null;


  
//   String countryName = "India";
//   String ?stateName;
//   String ?cityName;
//   int phoneCode = 91;
//   DefaultCountry defaultCountry = DefaultCountry.India;
//   final _formKey = GlobalKey<FormState>();
//   var _cscKey = UniqueKey();

// // TODO check this out
//   String dataErrorMessage = "";
  

//   void onDataFormSubmit(String value) async
//   {
//     if (_formKey.currentState!.validate()) 
//     {
//       ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Processing Data')),
//       );
//     //* submit form data after validation!
//       dataErrorMessage = await DataHelper.addGuest(DataModel(
//       title: nameTitle,
//       name: nameController.text, 
//       country_code: phoneCode, 
//       phone: int.parse(phoneController.text), 
//       profession: professionController.text,
//       email: emailController.text,
//       reference: referenceController.text,
//       country: countryName,
//       state: stateName,
//       city: cityName,
//       address: addressController.text,
//       ), context);

//       // * Clear all fields if no error returned
//       if(dataErrorMessage == "")
//       {
//         nameTitle = null;
//         nameController.clear();
//         phoneController.clear();
//         phoneController.clearComposing();
//         professionController.clear();
//         emailController.clear();
//         referenceController.clear();
//         addressController.clear();
//         // * Changing the key of the widget forces it to be redrawn
//         _cscKey = UniqueKey();
//       }
//       setState(() {
        
//       });
//     }
//             debugPrint("Submit Pressed!");
//   }
  


//   DefaultCountry setDefaultCountry(String countryName)
//   {
//     var countries = DefaultCountry.values;
//     DefaultCountry selectedCountry = DefaultCountry.India;
//     for(var country in countries)
//     {
//        debugPrint(country.toString().split(".")[1].toString());
      
//       if(country.toString().split(".")[1].replaceAll("_", " ") == countryName)
//       {
//         selectedCountry = country;
//         break;
//       }
//     }
//     return selectedCountry;

//   }

//   Widget errorSizedBox()
//   {
//     if(dataErrorMessage != "")
//     {
//       return SizedBox(height: 12,);
//     }
//     return Container();
//   }
  

//   @override
//   Widget build(BuildContext context) 
//   {
    

//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           FormFieldLabelWrapper(label: "Name", 
//           child:Row(
//             crossAxisAlignment: CrossAxisAlignment.center,  
//             mainAxisAlignment: MainAxisAlignment.start,          children: [
//               Expanded(
//                 flex: 1,
//                 child: DropdownButtonFormField(
//                   autovalidateMode: AutovalidateMode.disabled,
//                   validator: (value)
//                   {
//                     if(value == null || value.isEmpty)
//                     {
//                       return "Select a Title!";
//                     }
//                     return null;
//                   },
//                   items: [
//                   DropdownMenuItem(child: Text("Mr"), value: "Mr",),
//                   DropdownMenuItem(child: Text("Ms"), value: "Ms",),
//                   DropdownMenuItem(child: Text("Mrs"), value: "Mrs",),
//                   DropdownMenuItem(child: Text("Dr"), value: "Dr",),
//                   DropdownMenuItem(child: Text("Adv"), value: "Adv",),
//                 ], onChanged: (value) {
//                   setState(() {
//                     nameTitle = value!;
//                   });
//                 },
//                 decoration: InputDecoration(
//                     hintText: "Title",
//                     border:OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10,),
//               Expanded(
//                 flex: 3,
//                 child: TextFormField(
//                   autovalidateMode: AutovalidateMode.disabled,
//                   onFieldSubmitted: onDataFormSubmit,
//                   validator: (value) {
//                     if(value == null || value.isEmpty)
//                     {
//                       return "Please Enter the Name!";
//                     }
//                     return null;
//                   },
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     hintText: "Enter Name",
//                     border:OutlineInputBorder(),
//                   ),
//                 ),
//               )
//             ],
//           ) 
//           ),
//           SizedBox(height: 12,),
//           FormFieldLabelWrapper(
//             label: "Phone",
//             child: IntlPhoneField(
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               decoration: InputDecoration(
//                 hintText: "Enter Phone Number",
//                 border: OutlineInputBorder()
//               ),
//               initialCountryCode: "IN",
//               controller: phoneController,
//               onCountryChanged: (country)
//               {
//                 setState(() {
//                   phoneCode = int.parse(country.dialCode);
//                   countryName = country.name;
//                   defaultCountry = setDefaultCountry(countryName);
//                   // * Changing the key of the widget forces it to be redrawn
//                   _cscKey = UniqueKey();
//                 });
                
//               },
//               onSubmitted: onDataFormSubmit,
//             ),
//           ),
//           SizedBox(height: 12,),
//           EasyFormField(label: "Reference", textEditingController: referenceController, required: true,
//           onSubmit: onDataFormSubmit,
//           ),
//           SizedBox(height: 12),
//           EasyFormField(label: "Email", required: false,textEditingController: emailController , validator: (value){
//             if(value == null || value.isEmpty)
//             {
//               return null;
//             }
//             if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
//             {
//               return "Please enter a valid email!";
//             }
//             return null;
//           },
//           onSubmit: onDataFormSubmit,
//           ),
//           SizedBox(height: 12),
//           EasyFormField(label: "Profession", textEditingController: professionController, required: false,
//           onSubmit: onDataFormSubmit,
//           ),
//           SizedBox(height: 16,),
//           FormFieldLabelWrapper(
//             label: "Address",
//             child: CSCPicker(
//               key: _cscKey,
//               layout: Layout.vertical,
//               selectedItemStyle: CustomTheme.h2,
              
//               dropdownDecoration: BoxDecoration(
//                 color: Colors.transparent,
//                 backgroundBlendMode: BlendMode.overlay,
//                 border: Border.all(color: Colors.grey.shade600),
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.all(Radius.circular(5))
                
//                 ),
//               disabledDropdownDecoration: BoxDecoration(
//                 color: Colors.transparent,
//                 backgroundBlendMode: BlendMode.overlay,
//                 border: Border.all(color: Colors.grey.shade600),
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.all(Radius.circular(5))
                
//                 ),
//               flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
//               defaultCountry: defaultCountry,
//               // * see if this needs to be enabled
//               disableCountry: true,
//               onCountryChanged: (country) {
//                 setState(() {
//                   countryName = country;
//                 });
//               },
//               onStateChanged: (state) 
//               {
//                 setState(() {
//                   stateName = state;
//                 });
//               },
//               onCityChanged: (city) 
//               {
//                 setState(() 
//                 {
//                   cityName = city;
//                 });
//               },
          
//             ),
//           ),
//           SizedBox(height: 12,),
//           EasyFormField(label:"Street/Flat No.", required: false, textEditingController: addressController,
//           onSubmit: onDataFormSubmit,
//           labelDisabled: true,
//           ),
//           errorSizedBox(),
//           Text(dataErrorMessage, style: CustomTheme.error,),
//           SizedBox(height: 12,),

//           ElevatedButton(onPressed: ()
//           {
//             onDataFormSubmit("");
//           }, 
//           child: Text("Submit",))
//         ]),
//     );
//   }
// }

class CustomValidators
{
  static String ? emailValidator(String ? value)
  {
    if (value == null || value.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) 
    {
        return "Please enter a valid email!";
    } 
    return null;
  }
}