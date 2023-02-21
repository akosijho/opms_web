enum EnumToothCondition {
  Carries_Indicated_For_Filling,
  Carries_Indicated_For_Extraction,
  Root_Fragment,
  Missing_Due_To_Carries,
  Missing_Due_To_Other_Causes,
  Unerupted_Tooth,
  Impacted_Tooth,
  Gold_Crown,
  Jacket_Crown,
  Abutment_Tooth,
  Pontic,
  Inlay,
  Amalgam_Filling,
  Fixed_Bridge,
  Glass_Ionomer_Filling,
  Composite_Filling,
  Normal,
}
EnumToothCondition getToothCondition(String appointmentStatus) {
  switch (appointmentStatus) {
    case 'Carries Indicated For Filling':
      return EnumToothCondition.Carries_Indicated_For_Filling;

    case 'Carries Indicated For Extraction':
      return EnumToothCondition.Carries_Indicated_For_Extraction;

    case 'Root Fragment':
      return EnumToothCondition.Root_Fragment;

    case 'Missing Due To Carries':
      return EnumToothCondition.Missing_Due_To_Carries;

    case 'Missing Due To Other Causes':
      return EnumToothCondition.Missing_Due_To_Other_Causes;

    case 'Unerupted Tooth':
      return EnumToothCondition.Unerupted_Tooth;

    case 'Impacted Tooth':
      return EnumToothCondition.Impacted_Tooth;

    case 'Gold Crown':
      return EnumToothCondition.Gold_Crown;

    case 'Jacket Crown':
      return EnumToothCondition.Jacket_Crown;

    case 'Abutment Tooth':
      return EnumToothCondition.Abutment_Tooth;

    case 'Pontic':
      return EnumToothCondition.Pontic;

    case 'Inlay':
      return EnumToothCondition.Inlay;

    case 'Amalgam Filling':
      return EnumToothCondition.Amalgam_Filling;

    case 'Fixed Bridge':
      return EnumToothCondition.Fixed_Bridge;

    case 'Glass Ionomer Filling':
      return EnumToothCondition.Glass_Ionomer_Filling;

    case 'Composite Filling':
      return EnumToothCondition.Composite_Filling;

    default:
      return EnumToothCondition.Normal;
  }
}

extension Ext on EnumToothCondition {
  String get name {
    switch (this) {
      case EnumToothCondition.Carries_Indicated_For_Filling:
        return 'Carries Indicated For Filling';

      case EnumToothCondition.Carries_Indicated_For_Extraction:
        return 'Carries Indicated For Extraction';

      case EnumToothCondition.Root_Fragment:
        return 'Root Fragment';

      case EnumToothCondition.Missing_Due_To_Carries:
        return 'Missing Due To Carries';

      case EnumToothCondition.Missing_Due_To_Other_Causes:
        return 'Missing Due To Other Causes';

      case EnumToothCondition.Unerupted_Tooth:
        return 'Unerupted Tooth';

      case EnumToothCondition.Impacted_Tooth:
        return 'Impacted Tooth';

      case EnumToothCondition.Gold_Crown:
        return 'Gold Crown';

      case EnumToothCondition.Jacket_Crown:
        return 'Jacket Crown';

      case EnumToothCondition.Abutment_Tooth:
        return 'Abutment Tooth';

      case EnumToothCondition.Pontic:
        return 'Pontic';

      case EnumToothCondition.Inlay:
        return 'Inlay';

      case EnumToothCondition.Amalgam_Filling:
        return 'Amalgam Filling';

      case EnumToothCondition.Fixed_Bridge:
        return 'Fixed Bridge';

      case EnumToothCondition.Glass_Ionomer_Filling:
        return 'Glass Ionomer Filling';

      case EnumToothCondition.Composite_Filling:
        return 'Composite Filling';

      default:
        return 'Normal';
    }
  }
}
