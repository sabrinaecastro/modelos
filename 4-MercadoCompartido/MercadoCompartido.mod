/*********************************************
 * OPL 12.6.0.0 Model
 * Author: sabrina
 * Creation Date: 24/07/2018 at 09:58:11
 *********************************************/
{string} Grupos = ...;
{string} Minoristas = ...;
float PuntosDeEntrega[Minoristas]=...;
float MercadoAlcohol[Minoristas]=...;
float PorcMin[1..2]= ...;
float PorcMax[1..2]= ...;
/*Punto de entrega*/
dvar int MinoristasPuntosEntregaD1;
dvar int MinoristasPuntosEntregaD2;
dvar int+ PuntosEntregaGrupo[Grupos][Minoristas] in 0..1;
float TotalPuntosEntrega = sum( m in Minoristas) PuntosDeEntrega[m];
dvar float cantPuntosEntregaD1;
dvar float cantPuntosEntregaD2;
dvar float PorMinoristasPuntosEntregaD1;
dvar float PorMinoristasPuntosEntregaD2;

/*Mercado de alcohol*/
dvar int MinoristasMercadoAlcoholD1;
dvar int MinoristasMercadoAlcoholD2;
dvar int+ MercadoAlcoholGrupo[Grupos][Minoristas] in 0..1;
float TotalMercadoAlcohol = sum( m in Minoristas) MercadoAlcohol[m];
dvar float cantMercadoAlcoholD1;
dvar float cantMercadoAlcoholD2;
dvar float PorMinoristasMercadoAlcoholD1;
dvar float PorMinoristasMercadoAlcoholD2;

/*mercado de alcohol regiones 1 */
{string} MinoristasR1 = ...;
float MercadoAceiteR1[MinoristasR1]=...;
dvar int MinoristasMercadoAceiteR1D1;
dvar int MinoristasMercadoAceiteR1D2;
dvar int+ MercadoAceiteR1Grupo[Grupos][MinoristasR1] in 0..1;
float TotalMercadoAceiteR1 = sum( m in MinoristasR1) MercadoAceiteR1[m];
dvar float cantMercadoAceiteR1D1;
dvar float cantMercadoAceiteR1D2;
dvar float PorMinoristasMercadoAceiteR1D1;
dvar float PorMinoristasMercadoAceiteR1D2;


/*mercado de alcohol regiones 2 */
{string} MinoristasR2 = ...;
float MercadoAceiteR2[MinoristasR2]=...;
dvar int MinoristasMercadoAceiteR2D1;
dvar int MinoristasMercadoAceiteR2D2;
dvar int+ MercadoAceiteR2Grupo[Grupos][MinoristasR2] in 0..1;
float TotalMercadoAceiteR2 = sum( m in MinoristasR2) MercadoAceiteR2[m];
dvar float cantMercadoAceiteR2D1;
dvar float cantMercadoAceiteR2D2;
dvar float PorMinoristasMercadoAceiteR2D1;
dvar float PorMinoristasMercadoAceiteR2D2;

/*mercado de alcohol regiones 3 */
{string} MinoristasR3 = ...;
float MercadoAceiteR3[MinoristasR3]=...;
dvar int MinoristasMercadoAceiteR3D1;
dvar int MinoristasMercadoAceiteR3D2;
dvar int+ MercadoAceiteR3Grupo[Grupos][MinoristasR3] in 0..1;
float TotalMercadoAceiteR3 = sum( m in MinoristasR3) MercadoAceiteR3[m];
dvar float cantMercadoAceiteR3D1;
dvar float cantMercadoAceiteR3D2;
dvar float PorMinoristasMercadoAceiteR3D1;
dvar float PorMinoristasMercadoAceiteR3D2;

/*Grupo A*/
{string} MinoristasA = ...;
float GrupoA[MinoristasA]=...;
dvar int MinoristasGrupoAD1;
dvar int MinoristasGrupoAD2;
dvar int+ GrupoAGrupo[Grupos][MinoristasA] in 0..1;
float TotalGrupoA = sum(m in MinoristasA) GrupoA[m];
dvar float cantGrupoAD1;
dvar float cantGrupoAD2;
dvar float PorMinoristasGrupoAD1;
dvar float PorMinoristasGrupoAD2;

/*Grupo B*/
{string} MinoristasB = ...;
float GrupoB[MinoristasB]=...;
dvar int MinoristasGrupoBD1;
dvar int MinoristasGrupoBD2;
dvar int+ GrupoBGrupo[Grupos][MinoristasB] in 0..1;
float TotalGrupoB = sum(m in MinoristasB) GrupoB[m];
dvar float cantGrupoBD1;
dvar float cantGrupoBD2;
dvar float PorMinoristasGrupoBD1;
dvar float PorMinoristasGrupoBD2;

maximize 	PorMinoristasPuntosEntregaD1 + PorMinoristasPuntosEntregaD2 + 
		  	PorMinoristasMercadoAlcoholD1 + PorMinoristasMercadoAlcoholD2 +
		  	PorMinoristasMercadoAceiteR1D1 + PorMinoristasMercadoAceiteR1D2 +
		  	PorMinoristasMercadoAceiteR2D1 + PorMinoristasMercadoAceiteR2D2 +
		  	PorMinoristasMercadoAceiteR3D1 + PorMinoristasMercadoAceiteR3D2 +
		  	PorMinoristasGrupoAD1+PorMinoristasGrupoAD2+
		  	PorMinoristasGrupoBD1+PorMinoristasGrupoBD2;
		  	

subject to  {
	/*Puntos de entrega*/
	puntosEntregaD1:
		MinoristasPuntosEntregaD1 == sum( m in Minoristas) PuntosEntregaGrupo["D1"][m]==1;
	puntosEntregaD2:
		MinoristasPuntosEntregaD2 == sum( m in Minoristas) PuntosEntregaGrupo["D2"][m]==1;
	PuntoEntregatotal: 
		MinoristasPuntosEntregaD1 + MinoristasPuntosEntregaD2 == 23;
	sumaPuntosEntregaD1:
		cantPuntosEntregaD1 == sum( m in Minoristas) (PuntosEntregaGrupo["D1"][m] * PuntosDeEntrega[m]);
	sumaPuntosEntregaD2:
		cantPuntosEntregaD2 == sum( m in Minoristas) (PuntosEntregaGrupo["D2"][m] * PuntosDeEntrega[m]);
	porcPuntosEntregaD1:
		PorMinoristasPuntosEntregaD1 == 100 * cantPuntosEntregaD1 / TotalPuntosEntrega;
	porcPuntosEntregaD2:
		PorMinoristasPuntosEntregaD2 == 100 * cantPuntosEntregaD2 / TotalPuntosEntrega;
	PuntoEntregaD1Min1: 
		PorMinoristasPuntosEntregaD1 >= PorcMin[1];
	PuntoEntregaD1Min2: 
		PorMinoristasPuntosEntregaD1 <= PorcMin[2]; 
	PuntoEntregaD2Max1: 
		PorMinoristasPuntosEntregaD2 >= PorcMax[1];
	PuntoEntregaD2Max2: 
		PorMinoristasPuntosEntregaD2 <= PorcMax[2];  
    DebenSumar100:
		PorMinoristasPuntosEntregaD1+PorMinoristasPuntosEntregaD2==100;

	/*Mercado de acohol*/	
	MercadoAlcoholD1:
		MinoristasMercadoAlcoholD1 == sum( m in Minoristas) MercadoAlcoholGrupo["D1"][m]==1;
	MercadoAlcoholD2:
		MinoristasMercadoAlcoholD2 == sum( m in Minoristas) MercadoAlcoholGrupo["D2"][m]==1;
	MercadoAlcoholtotal: 
		MinoristasMercadoAlcoholD1 + MinoristasMercadoAlcoholD2 == 23;
	sumaMercadoAlcoholD1:
		cantMercadoAlcoholD1 == sum( m in Minoristas) (MercadoAlcoholGrupo["D1"][m] * MercadoAlcohol[m]);
	sumaMercadoAlcoholD2:
		cantMercadoAlcoholD2 == sum( m in Minoristas) (MercadoAlcoholGrupo["D2"][m] * MercadoAlcohol[m]);
	porcMercadoAlcoholD1:
		PorMinoristasMercadoAlcoholD1 == 100 * cantMercadoAlcoholD1 / TotalMercadoAlcohol;
	porcMercadoAlcoholD2:
		PorMinoristasMercadoAlcoholD2 == 100 * cantMercadoAlcoholD2 / TotalMercadoAlcohol;
	MercadoAlcoholD1Min1: 
		PorMinoristasMercadoAlcoholD1 >= PorcMin[1];
	MercadoAlcoholD1Min2: 
		PorMinoristasMercadoAlcoholD1 <= PorcMin[2]; 
	MercadoAlcoholD2Max1: 
		PorMinoristasMercadoAlcoholD2 >= PorcMax[1];
	MercadoAlcoholD2Max2: 
		PorMinoristasMercadoAlcoholD2 <= PorcMax[2];
	MercadoAlcoholDebesumar100:  
		PorMinoristasMercadoAlcoholD1+PorMinoristasMercadoAlcoholD2==100;


	/*Mercado aceite R1*/	
	
	MercadoAceiteR1D1:
		MinoristasMercadoAceiteR1D1 == sum( m in MinoristasR1) MercadoAceiteR1Grupo["D1"][m]==1;
	MercadoAceiteR1D2:
		MinoristasMercadoAceiteR1D2 == sum( m in MinoristasR1) MercadoAceiteR1Grupo["D2"][m]==1;
	MercadoAceiteR1total: 
		MinoristasMercadoAceiteR1D1 + MinoristasMercadoAceiteR1D2 == 8;
	sumaMercadoAceiteR1D1:
		cantMercadoAceiteR1D1 == sum( m in MinoristasR1) (MercadoAceiteR1Grupo["D1"][m] * MercadoAceiteR1[m]);
	sumaMercadoAceiteR1D2:
		cantMercadoAceiteR1D2 == sum( m in MinoristasR1) (MercadoAceiteR1Grupo["D2"][m] * MercadoAceiteR1[m]);
	porcMercadoAceiteR1D1:
		PorMinoristasMercadoAceiteR1D1 == 100 * cantMercadoAceiteR1D1 / TotalMercadoAceiteR1;
	porcMercadoAceiteR1D2:
		PorMinoristasMercadoAceiteR1D2 == 100 * cantMercadoAceiteR1D2 / TotalMercadoAceiteR1;
	MercadoAceiteR1D1Min1: 
		PorMinoristasMercadoAceiteR1D1 >= PorcMin[1];
	MercadoAceiteR1D1Min2: 
		PorMinoristasMercadoAceiteR1D1 <= PorcMin[2]; 
	MercadoAceiteR1D2Max1: 
		PorMinoristasMercadoAceiteR1D2 >= PorcMax[1];
	MercadoAceiteR1D2Max2: 
		PorMinoristasMercadoAceiteR1D2 <= PorcMax[2];  
	DebenSumar100MercadoAceiteR1:
		PorMinoristasMercadoAceiteR1D1+PorMinoristasMercadoAceiteR1D2==100;


	/*Mercado aceite R2*/	
	
	MercadoAceiteR2D1:
		MinoristasMercadoAceiteR2D1 == sum( m in MinoristasR2) MercadoAceiteR2Grupo["D1"][m]==1;
	MercadoAceiteR2D2:
		MinoristasMercadoAceiteR2D2 == sum( m in MinoristasR2) MercadoAceiteR2Grupo["D2"][m]==1;
	MercadoAceiteR2total: 
		MinoristasMercadoAceiteR2D1 + MinoristasMercadoAceiteR2D2 == 10;
	sumaMercadoAceiteR2D1:
		cantMercadoAceiteR2D1 == sum( m in MinoristasR2) (MercadoAceiteR2Grupo["D1"][m] * MercadoAceiteR2[m]);
	sumaMercadoAceiteR2D2:
		cantMercadoAceiteR2D2 == sum( m in MinoristasR2) (MercadoAceiteR2Grupo["D2"][m] * MercadoAceiteR2[m]);
	porcMercadoAceiteR2D1:
		PorMinoristasMercadoAceiteR2D1 == 100 * cantMercadoAceiteR2D1 / TotalMercadoAceiteR2;
	porcMercadoAceiteR2D2:
		PorMinoristasMercadoAceiteR2D2 == 100 * cantMercadoAceiteR2D2 / TotalMercadoAceiteR2;
	MercadoAceiteR2D1Min1: 
		PorMinoristasMercadoAceiteR2D1 >= PorcMin[1];
	MercadoAceiteR2D1Min2: 
		PorMinoristasMercadoAceiteR2D1 <= PorcMin[2]; 
	MercadoAceiteR2D2Max1: 
		PorMinoristasMercadoAceiteR2D2 >= PorcMax[1];
	MercadoAceiteR2D2Max2: 
		PorMinoristasMercadoAceiteR2D2 <= PorcMax[2];  
	DebenSumar100MercadoAceiteR2:
	PorMinoristasMercadoAceiteR2D1+PorMinoristasMercadoAceiteR2D2==100;


	/*Mercado aceite R3*/	
	
	MercadoAceiteR3D1:
		MinoristasMercadoAceiteR3D1 == sum( m in MinoristasR3) MercadoAceiteR3Grupo["D1"][m]==1;
	MercadoAceiteR3D2:
		MinoristasMercadoAceiteR3D2 == sum( m in MinoristasR3) MercadoAceiteR3Grupo["D2"][m]==1;
	MercadoAceiteR3total: 
		MinoristasMercadoAceiteR3D1 + MinoristasMercadoAceiteR3D2 == 5;
	sumaMercadoAceiteR3D1:
		cantMercadoAceiteR3D1 == sum( m in MinoristasR3) (MercadoAceiteR3Grupo["D1"][m] * MercadoAceiteR3[m]);
	sumaMercadoAceiteR3D2:
		cantMercadoAceiteR3D2 == sum( m in MinoristasR3) (MercadoAceiteR3Grupo["D2"][m] * MercadoAceiteR3[m]);
	porcMercadoAceiteR3D1:
		PorMinoristasMercadoAceiteR3D1 == 100 * cantMercadoAceiteR3D1 / TotalMercadoAceiteR3;
	porcMercadoAceiteR3D2:
		PorMinoristasMercadoAceiteR3D2 == 100 * cantMercadoAceiteR3D2 / TotalMercadoAceiteR3;
	MercadoAceiteR3D1Min1: 
		PorMinoristasMercadoAceiteR3D1 >= PorcMin[1];
	MercadoAceiteR3D1Min2: 
		PorMinoristasMercadoAceiteR3D1 <= PorcMin[2]; 
	MercadoAceiteR3D2Max1: 
		PorMinoristasMercadoAceiteR3D2 >= PorcMax[1];
	MercadoAceiteR3D2Max2: 
		PorMinoristasMercadoAceiteR3D2 <= PorcMax[2];
	DebenSumar100MercadoAceiteR3:	  
		PorMinoristasMercadoAceiteR3D1+PorMinoristasMercadoAceiteR3D2==100;

	/*Grupo A*/
	GrupoAD1:
		MinoristasGrupoAD1 == sum( m in MinoristasA) GrupoAGrupo["D1"][m]==1;
	GrupoAD2:
		MinoristasGrupoAD2 == sum( m in MinoristasA) GrupoAGrupo["D2"][m]==1;
	GrupoAtotal: 
		MinoristasGrupoAD1 + MinoristasGrupoAD2 == 8;
	sumaGrupoAD1:
		cantGrupoAD1 == sum( m in MinoristasA) (GrupoAGrupo["D1"][m] * GrupoA[m]);
	sumaGrupoAD2:
		cantGrupoAD2 == sum( m in MinoristasA) (GrupoAGrupo["D2"][m] * GrupoA[m]);
	porcGrupoAD1:
		PorMinoristasGrupoAD1 == 100 * cantGrupoAD1 / TotalGrupoA;
	porcGrupoAD2:
		PorMinoristasGrupoAD2 == 100 * cantGrupoAD2 / TotalGrupoA;
	GrupoAD1Min1: 
		PorMinoristasGrupoAD1 >= PorcMin[1];
	GrupoAD1Min2: 
		PorMinoristasGrupoAD1 <= PorcMin[2]; 
	GrupoAD2Max1: 
		PorMinoristasGrupoAD2 >= PorcMax[1];
	GrupoAD2Max2: 
		PorMinoristasGrupoAD2 <= PorcMax[2];  
    DebenSumar100GrupoA:
		PorMinoristasGrupoAD1+PorMinoristasGrupoAD2==100;

	/*Grupo B*/
	GrupoBD1:
		MinoristasGrupoBD1 == sum( m in MinoristasB) GrupoBGrupo["D1"][m]==1;
	GrupoBD2:
		MinoristasGrupoBD2 == sum( m in MinoristasB) GrupoBGrupo["D2"][m]==1;
	GrupoBtotal: 
		MinoristasGrupoBD1 + MinoristasGrupoBD2 == 15;
	sumaGrupoBD1:
		cantGrupoBD1 == sum( m in MinoristasB) (GrupoBGrupo["D1"][m] * GrupoB[m]);
	sumaGrupoBD2:
		cantGrupoBD2 == sum( m in MinoristasB) (GrupoBGrupo["D2"][m] * GrupoB[m]);
	porcGrupoBD1:
		PorMinoristasGrupoBD1 == 100 * cantGrupoBD1 / TotalGrupoB;
	porcGrupoBD2:
		PorMinoristasGrupoBD2 == 100 * cantGrupoBD2 / TotalGrupoB;
	GrupoBD1Min1: 
		PorMinoristasGrupoBD1 >= PorcMin[1];
	GrupoBD1Min2: 
		PorMinoristasGrupoBD1 <= PorcMin[2]; 
	GrupoBD2Max1: 
		PorMinoristasGrupoBD2 >= PorcMax[1];
	GrupoBD2Max2: 
		PorMinoristasGrupoBD2 <= PorcMax[2];  
    DebenSumar100GrupoB:
		PorMinoristasGrupoBD1+PorMinoristasGrupoBD2==100;

		 
};
execute DISPLAY {   
  writeln("------------------------------------------");
  writeln(" Beneficio maximo = " , cplex.getObjValue());
  writeln(" Porcentaje puntos de entrega D1 = " , PorMinoristasPuntosEntregaD1);
  writeln(" Porcentaje puntos de entraga D2 = " , PorMinoristasPuntosEntregaD2);
  /*writeln(" cantidAD D1 = " , cantPuntosEntregaD1);
  writeln(" CANTIDAD D2 = " , cantPuntosEntregaD2);
  writeln(" total puntos = " , TotalPuntosEntrega);*/
  writeln("------------------------------------------");
  writeln(" Porcentaje mercado de alcohol D1 = " , PorMinoristasMercadoAlcoholD1);
  writeln(" Porcentaje mercado de alcohol D2 = " , PorMinoristasMercadoAlcoholD2);
  /*writeln(" cantidAD D1 = " , cantMercadoAlcoholD1);
  writeln(" CANTIDAD D2 = " , cantMercadoAlcoholD2);
  writeln(" total puntos = " , TotalMercadoAlcohol);*/
  writeln("------------------------------------------");
  writeln(" Porcentaje mercado aceite R1 D1 = " , PorMinoristasMercadoAceiteR1D1);
  writeln(" Porcentaje mercado aceite R1 D2 = " , PorMinoristasMercadoAceiteR1D2);
  writeln("------------------------------------------");
  writeln(" Porcentaje mercado aceite R2 D1 = " , PorMinoristasMercadoAceiteR2D1);
  writeln(" Porcentaje mercado aceite R2 D2 = " , PorMinoristasMercadoAceiteR2D2);
  writeln("------------------------------------------");
  writeln(" Porcentaje mercado aceite R3 D1 = " , PorMinoristasMercadoAceiteR3D1);
  writeln(" Porcentaje mercado aceite R3 D2 = " , PorMinoristasMercadoAceiteR3D2);
  writeln("------------------------------------------");
  writeln(" Porcentaje Grupo A D1 = " , PorMinoristasGrupoAD1);
  writeln(" Porcentaje Grupo A D2 = " , PorMinoristasGrupoAD2);
  writeln("------------------------------------------");
  writeln(" Porcentaje Grupo B D1 = " , PorMinoristasGrupoBD1);
  writeln(" Porcentaje Grupo B D2 = " , PorMinoristasGrupoBD2);
  
  

}
