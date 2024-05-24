# Calcula la pendiente entendida como 
# variación en semitonos entre el primer valor
# de f0 y el último
# el valor que entrega se puede interpretar como
# los semitonos de variación por milisengundos
# Requiere objetos Pitch en una carpeta
# guarda tabla con valores en esa misma carpeta
# Autores: Eva Velásquez y Domingo Román



# 	Calcula los semitonos entre el primer punto y el último con registro de f0
#	st = 12*log2(f0_postrer/f0_primer)
#	se divide los semitonos por el tiempo
# 	se multiplica por 1000 para que el número sea más evidente
#	pend_st = st/(distancia_puntos)*1000

directorio$ = chooseDirectory$ ("Elija directorio con archivos")

strings1 = Create Strings as file list... lista_1 'directorio$'/*.Pitch

ene_tonos = Get number of strings

tabla_data_tonos = Create Table with column names: "tabla", ene_tonos, { "archivo", "max", "min", "st_rango", "pendiente"}

writeInfoLine: "================"

for i to ene_tonos

	select strings1

  	tono$ = Get string... i

	tono = Read from file... 'directorio$'/'tono$'

	min = Get minimum: 0, 0, "Hertz", "parabolic"

	max = Get maximum: 0, 0, "Hertz", "parabolic"

	st_M_m = 12*log2(max/min)

	ton_2 = Smooth: 10

	select ton_2

	pp = To PointProcess

	ene_puntos = Get number of points

	primer_punto = Get time from index: 1

	postrer_punto = Get time from index: ene_puntos

	select ton_2

	f0_primer = Get value at time: primer_punto, "Hertz", "linear"

	f0_postrer = Get value at time: postrer_punto, "Hertz", "linear"

	max_f0 = Get maximum: 0, 0, "Hertz", "parabolic"

	max_tiempo = Get time of maximum: 0, 0, "Hertz", "parabolic"

	min_f0 = Get minimum: 0, 0, "Hertz", "parabolic"

	min_tiempo = Get time of minimum: 0, 0, "Hertz", "parabolic"


if f0_primer > f0_postrer

	punto_base = postrer_punto

	punto_base_2 = primer_punto

	valor_f0 = f0_postrer

else

	punto_base = primer_punto

	punto_base_2 = postrer_punto

	valor_f0 = f0_primer

endif 



#######################################
# cálculo de la pendiente 

# en % st

	distancia_puntos = (postrer_punto - primer_punto)*1000

	st = 12*log2(f0_postrer/f0_primer)

	pend_st = st/(distancia_puntos)*1000

	select tabla_data_tonos

	Set string value: i, "archivo", tono$
	
	Set numeric value: i, "max", max_f0

	Set numeric value: i, "min", min_f0

	Set numeric value: i, "st_rango", st

	Set numeric value: i, "pendiente", pend_st

	select ton_2

	plus pp

	plus tono

	Remove

endfor

select strings1
Remove

select tabla_data_tonos

Save as comma-separated file:  "'directorio$'/tabla_data_tonos.Table"


