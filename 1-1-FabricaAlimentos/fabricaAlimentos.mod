/*********************************************
 * OPL 12.6.0.0 Model
 * Author: sabrina
 * Creation Date: 24/07/2018 at 00:45:14
 *********************************************/
{string} Productos = ...;

int NumMeses   = ...;
range Meses = 1..NumMeses;
float CostoCompra[Meses][Productos] = ...;
 
dvar float+ Producido[Meses];
dvar float+ Refinado[Meses][Productos];
dvar float+ Comprado[Meses][Productos];
dvar float Almacenado[Meses][Productos] in 0..1000;
 
maximize   
        sum( m in Meses)
 			(150 * Producido[m] 
 			- 5 * sum( p in Productos ) Almacenado[m][p]
 			- sum( p in Productos )(CostoCompra[m][p] * Comprado[m][p]) 
 			
    		);
subject to{

 forall( m in Meses){
 	loProducido: 
 		Producido[m] == sum( p in Productos ) Refinado[m][p];
	refinadoV: 
		Refinado[m]["v1"] + Refinado[m]["v2"] <= 200;
	refinadoO:                
	    Refinado[m]["o1"] + Refinado[m]["o2"] + Refinado[m]["o3"] <= 250; 	 	
    dureza3:
      3 * Producido[m] <= 8.8 * Refinado[m]["v1"] + 6.1 * Refinado[m]["v2"] +
            			 	2 * Refinado[m]["o1"] + 4.2 * Refinado[m]["o2"] + 
            			 	5 * Refinado[m]["o3"];
	dureza6:
      8.8 * Refinado[m]["v1"] + 6.1 * Refinado[m]["v2"] + 2 * Refinado[m]["o1"] + 
      4.2 * Refinado[m]["o2"] + 5 * Refinado[m]["o3"] <= 6 * Producido[m];

 	forall( p in Productos){ 
	    almacenado:  
	        if (m == 1) {
	          500 + Comprado[m][p] == Refinado[m][p] + Almacenado[m][p];
	        }
	        else {
	          Almacenado[m-1][p] + Comprado[m][p] == Refinado[m][p] + Almacenado[m][p];
	        }
    }    
 }
	
 forall( p in Productos){ 
 	almacenadoJunio: Almacenado[6][p] == 500;
 }	
};

execute DISPLAY {   
  writeln(" Beneficio maximo = " , cplex.getObjValue());
  for (var i in Meses) {
    writeln(" Mes ", i, " ");
    write("  . Comprado   ");
    for (var p in Productos)
      write(Comprado[i][p], "\t ");
    writeln();            
    write("  . Refinado   ");
    for (p in Productos) 
      write(Refinado[i][p], "\t ");
    writeln();
    write("  . almacenado ");
    for (p in Productos) 
      write(Almacenado[i][p], "\t ");
    writeln();
  }
}
