import 'package:amazon_clone_flutter_app/common/widgets/custom_button.dart';
import 'package:amazon_clone_flutter_app/constants/utils.dart';
import 'package:amazon_clone_flutter_app/features/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    super.key,
    required this.totalAmount,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuldingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  final AddressServices addressServices = AddressServices();

  @override
  void dispose() {
    super.dispose();
    flatBuldingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  // void onGooglePayResult(res) {
  //   if (Provider.of<UserProvider>(context, listen: false)
  //       .user
  //       .address
  //       .isEmpty) {
  //     addressServices.saveUserAddress(
  //       context: context,
  //       address: addressToBeUsed,
  //     );
  //   }
  //   addressServices.placeOrder(
  //     context: context,
  //     address: addressToBeUsed,
  //     totalSum: double.parse(
  //       widget.totalAmount,
  //     ),
  //   );
  // }
  void onGooglePayResult() {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(
        widget.totalAmount,
      ),
    );

    // Navigator.pop(context);
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(
        widget.totalAmount,
      ),
    );
  }

  String addressToBeUsed = "";

  void payPressed(String addressFormProvider) {
    addressToBeUsed = "";
    bool isFine = true;
    bool isForm = flatBuldingController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuldingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        isFine = false;
        throw Exception('Please enter all the values!!!');
      }
    } else if (addressFormProvider.isNotEmpty) {
      addressToBeUsed = addressFormProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }

    if (isFine) {
      onGooglePayResult();
    }
  }

  // List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    super.initState();
    // paymentItems.add(
    //   PaymentItem(
    //     amount: widget.totalAmount,
    //     label: 'Total Amount',
    //     status: PaymentItemStatus.final_price,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuldingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: areaController, hintText: 'Area, Street'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              CustomButton(
                onTap: () {
                  payPressed(address);
                  // onGooglePayResult();
                },
                text: 'Buy From GPAY',
                color: Colors.amberAccent,
              ),
              // GooglePayButton(
              //   paymentConfigurationAsset: 'gpay.json',
              //   onPaymentResult: onGooglePayResult,
              //   onPressed: () => payPressed(address),
              //   paymentItems: paymentItems,
              //   type: GooglePayButtonType.buy,
              //   margin: const EdgeInsets.only(top: 15),
              //   width: double.infinity,
              //   height: 50,
              //   loadingIndicator: const Center(
              //     child: CircularProgressIndicator(),
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              // ApplePayButton(
              //   paymentConfigurationAsset: 'applepay.json',
              //   onPaymentResult: onApplePayResult,
              //   paymentItems: paymentItems,
              //   onPressed: () => payPressed(address),
              //   type: ApplePayButtonType.buy,
              //   margin: const EdgeInsets.only(top: 15),
              //   height: 50,
              //   style: ApplePayButtonStyle.white,
              //   width: double.infinity,
              //   loadingIndicator: const Center(
              //     child: CircularProgressIndicator(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
