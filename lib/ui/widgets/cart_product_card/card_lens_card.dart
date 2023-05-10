import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_network/image_network.dart';
import 'package:opmswebstaff/models/product/lens.dart';

import '../../../app/app.locator.dart';
import '../../../constants/styles/text_styles.dart';
import '../../../core/service/validator/validator_service.dart';

class CartLensCard extends StatefulWidget {
  final Lens lens;
  final bool isChecked;
  final List<Lens> selectedLens;
  final VoidCallback notifyChange;
  CartLensCard(
      {Key? key,
        required this.lens,
        required this.isChecked,
        required this.selectedLens,
        required this.notifyChange})
      : super(key: key);

  @override
  State<CartLensCard> createState() => _CartLensCardState();
}

class _CartLensCardState extends State<CartLensCard> {
  final validatorService = locator<ValidatorService>();
  final qtyTxtController = TextEditingController();

  @override
  void initState() {
    qtyTxtController.text = widget.lens.qty ?? '1';
    super.initState();
  }

  @override
  void dispose() {
    qtyTxtController.dispose();
    super.dispose();
  }

  void incrementQty() {
    try {
      int qtyF = int.parse(qtyTxtController.text);
      qtyF++;
      qtyTxtController.text = qtyF.toString();
      updateQtyOfSelectedMedicine(widget.selectedLens,
          widget.lens.id ?? '', qtyTxtController.text);
    } catch (e) {}
  }

  void decrementQty() {
    try {
      int qtyF = int.parse(qtyTxtController.text);
      if (!(qtyF <= 1)) {
        qtyF--;
        qtyTxtController.text = qtyF.toString();
        updateQtyOfSelectedMedicine(widget.selectedLens,
            widget.lens.id ?? '', qtyTxtController.text);
      }
    } catch (e) {}
  }

  void updateQtyOfSelectedMedicine(List<Lens> selectedLensList,
      String selectedLensId, String newAmount) {
    int target = selectedLensList
        .indexWhere((element) => element.id == selectedLensId);
    if (target != null) {
      selectedLensList[target].qty = newAmount;
      debugPrint("Updated qty " + selectedLensList[target].qty!);
    }
    // return (listOfSelectedDentalNote);
  }

  void onItemTap(String newQty) {
    if ((widget.selectedLens
        .map((lens) => lens.id)
        .contains(widget.lens.id))) {
      widget.selectedLens
          .removeWhere((lens) => lens.id == widget.lens.id);
      widget.notifyChange();
    } else {
      widget.selectedLens.add(Lens(
        lensName: widget.lens.lensName,
        price: widget.lens.price,
        qty: newQty,
        brandName: widget.lens.brandName,
        dateCreated: widget.lens.dateCreated,
        id: widget.lens.id,
        image: widget.lens.image,
      ));
      widget.notifyChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onItemTap(qtyTxtController.text),
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 101,
              color: Colors.grey.shade100,
              child: Checkbox(
                value: widget.isChecked,
                onChanged: (value) => onItemTap(qtyTxtController.text),
              ),
            ),
            Column(
              children: [
                showMedImage(widget.lens.image),
                SizedBox(height: 2),
                //design for add and minus quantity
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => decrementQty(),
                        child: Container(
                          width: 29,
                          height: 25,
                          color: Colors.black,
                          child: Center(
                              child: Text('-',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))),
                        ),
                      ),
                      Container(
                        width: 29,
                        height: 25,
                        color: Colors.white,
                        child: Center(
                          child: TextFormField(
                            onChanged: (value) => updateQtyOfSelectedMedicine(
                                widget.selectedLens,
                                widget.lens.id ?? '',
                                value),
                            onSaved: (value) => updateQtyOfSelectedMedicine(
                                widget.selectedLens,
                                widget.lens.id ?? '',
                                value!),
                            controller: qtyTxtController,
                            textAlign: TextAlign.center,
                            enableInteractiveSelection: false,
                            validator: (value) =>
                                validatorService.validateQty(value!),
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.always,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(height: 0),
                              contentPadding: EdgeInsets.zero,
                              fillColor: Colors.white,
                              filled: true,
                              constraints:
                              BoxConstraints(maxHeight: 60, minHeight: 40),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                BorderSide(color: Colors.red, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => incrementQty(),
                        child: Container(
                          width: 29,
                          height: 25,
                          color: Colors.black,
                          child: Center(
                              child: Text(
                                '+',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.lens.brandName ?? 'No Brand',
                    style: TextStyles.tsBody1(color: Colors.grey.shade900),
                  ),
                  Text(
                    widget.lens.lensName,
                    style: TextStyles.tsBody2(color: Colors.black54),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.lens.priceToCurrency ?? '0',
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showMedImage(String? image) {
    if (image == null || image == '') {
      return Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 75,
          width: 87,
          child: SvgPicture.asset(
            'assets/icons/contact_lens.svg',
            color: Colors.black,
            height: 50,
            width: 50,
            alignment: Alignment.center,
          ),
        ),
      );
    } else {
      return ImageNetwork(
        image: image,
        height: 75,
        width: 87,
        imageCache: CachedNetworkImageProvider(image),
      );
    }
  }
}
