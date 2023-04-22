import 'package:cached_network_image/cached_network_image.dart';
import 'package:opmswebstaff/models/medicine/medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_network/image_network.dart';

import '../../../app/app.locator.dart';
import '../../../constants/styles/text_styles.dart';
import '../../../core/service/validator/validator_service.dart';

class CartMedicineCard extends StatefulWidget {
  final Medicine medicine;
  final bool isChecked;
  final List<Medicine> selectedMedicines;
  final VoidCallback notifyChange;
  CartMedicineCard(
      {Key? key,
      required this.medicine,
      required this.isChecked,
      required this.selectedMedicines,
      required this.notifyChange})
      : super(key: key);

  @override
  State<CartMedicineCard> createState() => _CartMedicineCardState();
}

class _CartMedicineCardState extends State<CartMedicineCard> {
  final validatorService = locator<ValidatorService>();
  final qtyTxtController = TextEditingController();

  @override
  void initState() {
    qtyTxtController.text = widget.medicine.qty ?? '1';
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
      updateQtyOfSelectedMedicine(widget.selectedMedicines,
          widget.medicine.id ?? '', qtyTxtController.text);
    } catch (e) {}
  }

  void decrementQty() {
    try {
      int qtyF = int.parse(qtyTxtController.text);
      if (!(qtyF <= 1)) {
        qtyF--;
        qtyTxtController.text = qtyF.toString();
        updateQtyOfSelectedMedicine(widget.selectedMedicines,
            widget.medicine.id ?? '', qtyTxtController.text);
      }
    } catch (e) {}
  }

  void updateQtyOfSelectedMedicine(List<Medicine> selectedMedicineList,
      String selectedMedicineId, String newAmount) {
    int target = selectedMedicineList
        .indexWhere((element) => element.id == selectedMedicineId);
    if (target != null) {
      selectedMedicineList[target].qty = newAmount;
      debugPrint("Updated qty " + selectedMedicineList[target].qty!);
    }
    // return (listOfSelectedDentalNote);
  }

  void onItemTap(String newQty) {
    if ((widget.selectedMedicines
        .map((medicine) => medicine.id)
        .contains(widget.medicine.id))) {
      widget.selectedMedicines
          .removeWhere((medicine) => medicine.id == widget.medicine.id);
      widget.notifyChange();
    } else {
      widget.selectedMedicines.add(Medicine(
        medicineName: widget.medicine.medicineName,
        price: widget.medicine.price,
        qty: newQty,
        brandName: widget.medicine.brandName,
        dateCreated: widget.medicine.dateCreated,
        id: widget.medicine.id,
        image: widget.medicine.image,
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
                showMedImage(widget.medicine.image),
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
                                widget.selectedMedicines,
                                widget.medicine.id ?? '',
                                value),
                            onSaved: (value) => updateQtyOfSelectedMedicine(
                                widget.selectedMedicines,
                                widget.medicine.id ?? '',
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
                    widget.medicine.brandName ?? 'No Brand',
                    style: TextStyles.tsBody1(color: Colors.grey.shade900),
                  ),
                  Text(
                    widget.medicine.medicineName,
                    style: TextStyles.tsBody2(color: Colors.black54),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.medicine.priceToCurrency ?? '0',
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
            'assets/icons/eyeglass.svg',
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
