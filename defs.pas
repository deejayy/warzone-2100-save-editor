{$O-}
unit defs;

interface

const

  CL_BODY       = $000001;
  CL_BRAIN      = $000002;
  CL_WHEEL      = $000003;
  CL_REPAIR     = $000004;
  CL_ECM        = $000005;
  CL_TOWER      = $000006;
  CL_CONSTRUCT  = $000007;
  CL_WEAPON     = $000008;

  comps         : array[CL_BODY..CL_WEAPON] of string = ('Bodys', 'Brain', 'Wheels', 'Repair', 'Ecm', 'Towers', 'Construct', 'Weapons');

type

  settings = record
    path        : string;
    inifile     : string;
    savegame    : string;
    logfile     : string;
  end;

implementation

end.
