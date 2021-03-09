import 'package:mobx/mobx.dart';
part 'NASATables.g.dart';

class NASATables = NASATablesBase with _$NASATables;

abstract class NASATablesBase with Store {
  @observable
  int selectedTable = 0;
  @observable
  Map<int, String> tableNames = {0: "exoplanets", 1: "compositepars"};
  @observable
  List<bool> selectedColumnIsChecked;
  @observable
  Set<int> selectedColumns;
  @observable
  Map<int, String> exoplanets = {
    0: "pl_hostname",
    1: "pl_letter",
    2: "pl_name",
    3: "pl_discmethod",
    4: "pl_controvflag",
    5: "pl_pnum",
    6: "pl_orbper",
    7: "pl_orbsmax",
    8: "pl_orbeccen",
    9: "pl_orbincl",
    10: "pl_bmassj",
    11: "pl_bmassprov",
    12: "pl_radj",
    13: "pl_dens",
    14: "pl_ttvflag",
    15: "pl_kepflag",
    16: "pl_k2flag",
    17: "pl_nnotes",
    18: "ra_str",
    19: "dec_str",
    20: "ra",
    21: "dec",
    22: "st_dist",
    23: "gaia_dist",
    24: "st_optmag",
    25: "st_optband",
    26: "gaia_gmag",
    27: "st_teff",
    28: "st_mass",
    29: "st_rad",
    30: "rowupdate",
    31: "pl_facility",
  };
  @observable
  Map<int, String> compositePars = {
    0: "fpl_hostname",
    1: "fpl_letter",
    2: "fpl_name",
    3: "fpl_discmethod",
    4: "fpl_disc",
    5: "fpl_controvflag",
    6: "fpl_orbper",
    7: "fpl_orbpererr1",
    8: "fpl_orbpererr2",
    9: "fpl_orbperlim",
    10: "fpl_orbperreflink",
    11: "fpl_smax",
    12: "fpl_smaxerr1",
    13: "fpl_smaxerr2",
    14: "fpl_smaxlim",
    15: "fpl_smaxreflink",
    16: "fpl_eccen",
    17: "fpl_eccenerr1",
    18: "fpl_eccenerr2",
    19: "fpl_eccenlim",
    20: "fpl_eccenreflink",
    21: "fpl_bmasse",
    22: "fpl_bmasseerr1",
    23: "fpl_bmasseerr2",
    24: "fpl_bmasselim",
    25: "fpl_bmassprov",
    26: "fpl_bmassreflink",
    27: "fpl_rade",
    28: "fpl_radeerr1",
    29: "fpl_radeerr2",
    30: "fpl_radelim",
    31: "fpl_radreflink",
    32: "fpl_dens",
    33: "fpl_denserr1",
    34: "fpl_denserr2",
    35: "fpl_denslim",
    36: "fpl_densreflink",
    37: "fpl_eqt",
    38: "fpl_eqterr1",
    39: "fpl_eqterr2",
    40: "fpl_eqtlim",
    41: "fpl_eqtreflink",
    42: "fpl_insol",
    43: "fpl_insolerr1",
    44: "fpl_insolerr2",
    45: "fpl_insollim",
    46: "fpl_insolreflink",
    47: "ra_str",
    48: "dec_str",
    49: "fst_posreflink",
    50: "fst_dist",
    51: "fst_disterr1",
    52: "fst_disterr2",
    53: "fst_distlim",
    54: "fst_distreflink",
    55: "fst_optmag",
    56: "fst_optmagerr",
    57: "fst_optmaglim",
    58: "fst_optmagband",
    59: "fst_optmagreflink",
    60: "fst_nirmag",
    61: "fst_nirmagerr",
    62: "fst_nirmaglim",
    63: "fst_nirmagband",
    64: "fst_nirmagreflink",
    65: "fst_spt",
    66: "fst_sptlim",
    67: "fst_sptreflink",
    68: "fst_teff",
    69: "fst_tefferr1",
    70: "fst_tefferr2",
    71: "fst_tefflim",
    72: "fst_teffreflink",
    73: "fst_logg",
    74: "fst_loggerr1",
    75: "fst_loggerr2",
    76: "fst_logglim",
    77: "fst_loggreflink",
    78: "fst_lum",
    79: "fst_lumerr1",
    80: "fst_lumerr2",
    81: "fst_lumlim",
    82: "fst_lumreflink",
    83: "fst_mass",
    84: "fst_masserr1",
    85: "fst_masserr2",
    86: "fst_masslim",
    87: "fst_massreflink",
    88: "fst_rad",
    89: "fst_raderr1",
    90: "fst_raderr2",
    91: "fst_radlim",
    92: "fst_radreflink",
    93: "fst_met",
    94: "fst_meterr1",
    95: "fst_meterr2",
    96: "fst_metlim",
    97: "fst_metratio",
    98: "fst_metreflink",
    99: "fst_age",
    100: "fst_ageerr1",
    101: "fst_ageerr2",
    102: "fst_agelim",
    103: "fst_agereflink",
  };
  String exoPlanetURL =
      "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?table=exoplanets&select=";
  String compositeParsURL =
      "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?table=compositepars&select=";
  // ignore: non_constant_identifier_names
  NASATablesBase() {
    selectedColumnIsChecked = List<bool>.filled(exoplanets.length, false);
    selectedColumns = Set<int>();
  }
  // UI is built of available tables, and user selects which to use, keeps checked table in List of ints
  String generateQuery(String sqlTerms) {
    StringBuffer query = StringBuffer();
    if (selectedTable == 0) {
      query.write(exoPlanetURL);
    } else if (selectedTable == 1) {
      query.write(compositeParsURL);
    }
    List<int> columnsList = selectedColumns.toList();
    if (selectedTable == 0) {
      for (int i = 0; i < columnsList.length - 1; i++) {
        query.write(exoplanets[columnsList[i]]);
        query.write(",");
      }
      query.write(exoplanets[columnsList[columnsList.length - 1]]);
    } else if (selectedTable == 1) {
      for (int i = 0; i < columnsList.length - 1; i++) {
        query.write(compositePars[columnsList[i]]);
        query.write(",");
      }
      query.write(compositePars[columnsList[columnsList.length - 1]]);
    }

    if (sqlTerms.length > 0) {
      query.write(sqlTerms);
    }
    print(query.toString());
    return query.toString();
  }

  void changeTable(int selected) {
    if (selected == 0) {
      selectedTable = 0;
      selectedColumnIsChecked = List<bool>.filled(exoplanets.length, false);
    } else if (selected == 1) {
      selectedTable = 1;
      selectedColumnIsChecked = List<bool>.filled(compositePars.length, false);
    }
    selectedColumns.clear();
  }
}
