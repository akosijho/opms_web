import 'package:opmsapp/core/service/validator/validator_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ValidatorServiceImpl extends ValidatorService {
  @override
  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return 'First name is empty.';
    } else
      return null;
  }

  @override
  String? validateLastName(String value) {
    if (value.isEmpty) {
      return 'Last name is empty.';
    } else
      return null;
  }

  @override
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is empty.';
    } else if (value.length < 8) {
      return 'Password must have at least 8 characters.';
    } else
      return null;
  }

  @override
  String? validateConfirmPassword(String value, String password) {
    if (value.isEmpty) {
      return 'Confirm password is empty.';
    } else if (value != password) {
      return 'Confirm Password do not match!';
    } else
      return null;
  }

  @override
  String? validateAddress(String value) {
    if (value.isEmpty) {
      return 'Address is empty';
    } else
      return null;
  }

  @override
  String? validateEmailAddress(String value) {
    bool emailValid = GetUtils.isEmail(value);
    if (value.isEmpty) {
      return 'Email address is empty';
    } else if (!emailValid) {
      return 'Enter a valid Email address';
    } else
      return null;
  }

  @override
  String? validateDate(String value) {
    if (value.isEmpty) {
      return 'Date is empty';
    } else if (DateFormat.yMMMd().parse(value) == null) {
      return 'Date is not valid';
    } else
      return null;
  }

  @override
  String? validateGender(String value) {
    if (value.isEmpty) {
      return 'Gender is empty';
    } else
      return null;
  }

  @override
  String? validatePosition(String value) {
    if (value.isEmpty) {
      return 'Position is empty';
    } else
      return null;
  }

  @override
  String? validateAllergies(String value) {
    if (value.isEmpty) {
      return 'List of Allergies is empty';
    } else
      return null;
  }

  @override
  String? validateContactName(String value) {
    if (value.isEmpty) {
      return 'Contact name is empty';
    } else
      return null;
  }

  @override
  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Phone number is empty';
    } else if (value.length < 11) {
      return 'Phone number is not valid';
    } else
      return null;
  }

  @override
  String? validateBrandName(String value) {
    if (value.isEmpty) {
      return 'Brand name is empty';
    } else
      return null;
  }

  @override
  String? validateMedicineName(String value) {
    if (value.isEmpty) {
      return 'Medicine name is empty';
    } else
      return null;
  }

  @override
  String? validatePrice(String value) {
    if (value.isEmpty) {
      return 'Price is empty';
    } else {
      try {
        double val = double.parse(value);
        if (val <= 0) {
          return 'Not A Valid Amount';
        } else {
          return null;
        }
      } catch (e) {
        return 'Not a Valid amount';
      }
    }
  }

  @override
  String? validateProcedureName(String value) {
    if (value.isEmpty) {
      return 'Procedure Name is empty';
    } else
      return null;
  }

  @override
  String? validateStartTime(String value) {
    if (value.isEmpty) {
      return ' Start Time is empty';
    } else
      return null;
  }

  @override
  String? validateEndTime(String value) {
    if (value.isEmpty) {
      return ' End Time is empty';
    } else
      return null;
  }

  @override
  String? validateDentist(String value) {
    if (value.isEmpty) {
      return ' No Dentist Selected';
    } else
      return null;
  }

  @override
  String? validateToothCondition(String value) {
    if (value.isEmpty) {
      return 'No Tooth Condition Selected';
    } else
      return null;
  }

  @override
  String? validatePaymentType(String value) {
    if (value.isEmpty)
      return 'No Payment Type Selected';
    else
      return null;
  }

  @override
  String? validateQty(String value) {
    if (value.isEmpty) {
      return '';
    } else {
      try {
        int val = int.parse(value);
        if (val <= 0) {
          return '';
        } else {
          return null;
        }
      } catch (e) {
        return '';
      }
    }
  }

  @override
  String? validateItemName(String value) {
    if (value.isEmpty) {
      return 'Item Name cannot be empty';
    } else {
      return null;
    }
  }

  @override
  String? validateTotalAmount(String value) {
    if (value.isEmpty) {
      return 'Amount cannot be empty';
    } else {
      try {
        double val = double.parse(value);
        if (val <= 0) {
          return 'Value is not valid';
        } else {
          return null;
        }
      } catch (e) {
        return 'Value is not valid';
      }
    }
  }

  @override
  String? validateItemQty(String value) {
    if (value.isEmpty) {
      return 'Amount cannot be empty';
    } else {
      try {
        int val = int.parse(value);
        if (val <= 0) {
          return 'Value is not valid';
        } else {
          return null;
        }
      } catch (e) {
        return 'Value is not valid';
      }
    }
  }

  @override
  String? validateInscription(String value) {
    if (value.isEmpty) {
      return 'Inscription cannot be empty';
    } else {
      return null;
    }
  }

  @override
  String? validateSignatura(String value) {
    if (value.isEmpty) {
      return 'Signatura cannot be empty';
    } else {
      return null;
    }
  }

  @override
  String? validateSubscription(String value) {
    if (value.isEmpty) {
      return 'Subscription cannot be empty';
    } else {
      return null;
    }
  }
}
