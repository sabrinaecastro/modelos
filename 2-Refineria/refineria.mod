
{string} Crudo = ...;
{string} Nafta = ...;
{string} Residuo = ...;
{string} Aceite = ...;
{string} Reformado = ...;
{string} Crackeado = ...;
{string} Gasolina = ...; 
{string} Combustible = ...;
{string} Lubricante = ...;

float DistNafta[Crudo][Nafta] = ...;
float DistAceite[Crudo][Aceite] = ...;
float DistResiduo[Crudo][Residuo] = ...;

float ResiduoProcess[Residuo][Lubricante] = ...;
float ReformadoProcess[Nafta][Reformado] = ...;
float CrackeadoProcess[Aceite][Crackeado] = ...;

float VaporAceite[Aceite] = ...;
float VaporResiduo[Residuo] = ...;
float VaporCrkAceite = ...;
float LimVaporCA = ...;

float LimCrudo[Crudo] = ...;
float LimDestilado = ...;
float LimReformado = ...;
float LimCrackeado = ...;
float LoLubricante[Lubricante] = ...;
float UpLubricante[Lubricante] = ...;

float OctaneNafta[Nafta] = ...;
float OctaneReformado[Reformado] = ...;
float OctaneCG = ...;
float ReqOctane[Gasolina] = ...;
float ReqRatioGasolina = ...;

float ReqAceiteFO[Aceite] = ...;
float ReqCrkFO = ...;
float ReqResiduoFO[Residuo] = ...;

float ProfitGasolina[Gasolina] = ...;
float ProfitCombustible[Combustible] = ...;
float ProfitLubricante[Lubricante] = ...;

dvar float+ Cr[c in Crudo] in 0..LimCrudo[c];
dvar float+ Nap[Nafta];
dvar float+ Napref[Nafta][Reformado];
dvar float+ Napb[Nafta][Gasolina];
dvar float+ Refb[Reformado][Gasolina];
dvar float+ Ref[Reformado];
dvar float+ AceiteVar[Aceite];
dvar float+ Aceitecrk[Aceite];
dvar float+ Aceiteb[Aceite][Combustible];
dvar float+ Crk[Crackeado];
dvar float+ Crkg[Gasolina];
dvar float+ Crko[Combustible];
dvar float+ ResiduoVar[Residuo];
dvar float+ Residuol[Residuo][Lubricante];
dvar float+ Residuobf[Residuo][Combustible];
dvar float+ Fpf[Combustible]; 
dvar float+ Fpp[Gasolina]; 
dvar float+ Fpl[l in Lubricante] in LoLubricante[l]..UpLubricante[l];

dexpr float TotalProfitFuel =
   sum(f in Combustible) ProfitCombustible[f] * Fpf[f];
     
dexpr float TotalProfitGasolina =
   sum(p in Gasolina) ProfitGasolina[p] * Fpp[p];
   
dexpr float TotalProfitLubricante = 
   sum(l in Lubricante) ProfitLubricante[l] * Fpl[l];
   
maximize TotalProfitFuel + TotalProfitGasolina + TotalProfitLubricante;

subject to {
  // Distallation capacity
  ctDistCap: sum(c in Crudo) Cr[c] <= LimDestilado;

  // ReACrming capacity
  ctRefCap:
    sum(n in Nafta, r in Reformado) Napref[n][r] <= LimReformado;

  // Cracking capacity
  ctCrkCap: sum(o in Aceite) Aceitecrk[o] <= LimCrackeado;

  // Distallation products
  forall(n in Nafta)
    sum(c in Crudo) DistNafta[c][n] * Cr[c] == Nap[n];     

  forall(o in Aceite)
    sum(c in Crudo) DistAceite[c][o] * Cr[c] == AceiteVar[o];     

  forall(r in Residuo)
    sum(c in Crudo) DistResiduo[c][r] * Cr[c] == ResiduoVar[r];     

  // ReACrmer products
  forall (r in Reformado)
    sum(n in Nafta) ReformadoProcess[n][r] * Napref[n][r] == Ref[r]; 
   
  // Cracking products
  forall(c in Crackeado)
    sum(o in Aceite) CrackeadoProcess[o][c] * Aceitecrk[o] == Crk[c];

  Crk["CG"] == sum(p in Gasolina) Crkg[p];
  Crk["CO"] == sum(f in Combustible) Crko[f];

  // Residuo process
  forall(l in Lubricante)
    sum(r in Residuo) ResiduoProcess[r][l] * Residuol[r][l] == Fpl[l];

  // Balance constraints on Naftas
  forall(n in Nafta)
    sum(r in Reformado) Napref[n][r] + sum(p in Gasolina) Napb[n][p] == Nap[n];

  // Balance constraints on Aceites
  forall(o in Aceite)
    Aceitecrk[o] + sum(f in Combustible) Aceiteb[o][f] == AceiteVar[o];   

  // Balance constraints on Residuos
  forall(r in Residuo)
    sum(f in Combustible) Residuobf[r][f] + sum(l in Lubricante) Residuol[r][l] == ResiduoVar[r];

  // Balance constaint on ReACrmer products
  forall(r in Reformado)
    sum(p in Gasolina) Refb[r][p] == Ref[r];

  // Balance constraints on Gasolinas
  forall(p in Gasolina)
    sum(n in Nafta) Napb[n][p] + sum(r in Reformado) Refb[r][p] + Crkg[p] == Fpp[p];

  // Balance constraint on Fuels
  forall(f in Combustible)
    sum(o in Aceite) Aceiteb[o][f] + Crko[f] + sum(r in Residuo) Residuobf[r][f] == Fpf[f];
   
  // Fixed proportions required ACr Fuel Aceite
  forall(o in Aceite)
    Aceiteb[o,"AC"] == ReqAceiteFO[o] * Fpf["AC"];
  Crko["AC"] == ReqCrkFO * Fpf["AC"];
  forall(r in Residuo)
    Residuobf[r]["AC"] == ReqResiduoFO[r] * Fpf["AC"]; 

  // Required ratio beteen Gasolinas
  cttReqRatio: Fpp["PRE"] >= ReqRatioGasolina * Fpp["REG"];
   
  // Qualities
  // Octane
  forall(p in Gasolina)
    ctOctane :      
      sum(n in Nafta) OctaneNafta[n] * Napb[n][p] + 
      sum(r in Reformado) OctaneReformado[r] * Refb[r][p]
         + OctaneCG * Crkg[p] >= ReqOctane[p] * Fpp[p]; 

  // Vapor Pressure constraint on Jet Fuel
  ctVapPres: 
  sum(o in Aceite) VaporAceite[o] * Aceiteb[o]["CA"] + VaporCrkAceite * Crko["CA"]
       + sum(r in Residuo) VaporResiduo[r] * Residuobf[r]["CA"] <= LimVaporCA * Fpf["CA"];
      
}
