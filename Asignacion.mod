# Conjuntos
set E ordered; #Empleados
set D ordered; #Escritorios
set T ordered; #Días
set G ordered; #Grupos
set Z ordered; #Zonas

#Parametros
param EscZona{d in D, z in Z} binary; # Pertenencia de escritorios a zonas 
param DispEsc{e in E, d in D} binary; # Disponibilidad de escritorios para empleados
param EmpGrupo{e in E, g in G} binary; # Pertenencia de empleados a grupos
param Preferencia{e in E, t in T} binary; #Preferencia de los empleados por los días de presencialidad
param zonas_maximas_grupo;
param Boni; # Bonificación por preferencia
param alpha default 0;  #Alfa de la FO

#Variables
var y{e in E, d in D, t in T} binary default 0; #Asignación de empleado e a escritorio d, el dia t
var f{t in T, z in Z, g in G} binary default 0; #Si al menos un miembro del grupo g es asignado a la zona z el dia t
var Reunion_G{g in G, t in T} binary default 0; #Si el grupo g se reune el dia t

param normz1 default 0; 

param normz2_l default card(G)*card(T)*zonas_maximas_grupo;
param normz2_u default card(G)*2; 

# Funciones objetivos
# 1- Maximizar asignación y preferencias
maximize z1_norm: (sum{e in E, d in D, t in T} (y[e,d,t]*(1+(Boni*Preferencia[e,t]))))/normz1;

maximize z1: sum{e in E, d in D, t in T} (y[e,d,t]*(1+(Boni*Preferencia[e,t])));

# 2- Minimizar dispersión
minimize z2_norm: ((sum{t in T, z in Z, g in G} (f[t,z,g])) - normz2_l )/(normz2_u - normz2_l );

minimize z2: sum{t in T, z in Z, g in G} (f[t,z,g]);

# 3- Funciones normalizadas
maximize z_total : (alpha*(sum{e in E, d in D, t in T} (y[e,d,t]*(1+(Boni*Preferencia[e,t]))))/normz1) + ((1-alpha)*((sum{t in T, z in Z, g in G} (f[t,z,g])) - normz2_l )/(normz2_u - normz2_l )); 

# Restricciones
# r1- Asignación de un solo escritorio a los empleados
s.t. r1 {d in D, t in T}:
	sum{e in E} y[e,d,t] <= 1;
	
# r2- Asignación de un solo empleado a cada escritorio
s.t. r2 {e in E, t in T}:
	sum{d in D} y[e,d,t] <= 1;
	
# r3- Por lo menos deben coincidir una vez a la semana todos los miembros del grupo 
s.t. r3_1 {g in G, t in T}:
	sum{e in E, d in D}y[e,d,t]*EmpGrupo[e,g] >= (sum{e in E}EmpGrupo[e,g])*Reunion_G[g,t];
	
s.t. r3_2 {g in G}:
	sum{t in T} Reunion_G[g,t] >= 1;
	
# r4- Los empleados no pueden estar aislados en las zonas
s.t. r4_1 {z in Z, t in T, g in G}:
	sum{e in E, d in D}y[e,d,t]*EscZona[d,z]*EmpGrupo[e,g] >= 2*f[t,z,g];
	
s.t. r4_2 {g in G, t in T}:
	sum{z in Z}f[t,z,g] <= zonas_maximas_grupo;

	
s.t. r4_3 {g in G, z in Z, t in T, e in E, d in D: EscZona[d,z]*EmpGrupo[e,g] >= 1}:
	f[t,z,g] >= y[e,d,t];	
	
# r5- Solo se puede asignar si el escritorio está disponible
s.t. r5 {d in D, t in T, e in E}:
	y[e,d,t] <= DispEsc[e,d];	

# r6- Cada trabajador debe asistir un numero minimo de dias a la semana	 
s.t. r6 {e in E}:
	sum{d in D, t in T}y[e,d,t] >= 2;	