# muestra la pendiente del tonema y del enunciado

tgri = selected("TextGrid")
tono = selected("Pitch")
tono$ = selected$("Pitch")
select tono
dur = Get total duration


ton_2 = Smooth: 10


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

st_M_m = 12*log2(max_f0/min_f0)


select tgri

tpo_ini_tonema = Get time of point: 1, 1

select tono
f0_ini_tonema = Get value at time: tpo_ini_tonema, "Hertz", "linear"



st_tone = 12*log2(f0_postrer/f0_ini_tonema)

# pendiente del enunciado

distancia_puntos = (postrer_punto - primer_punto)

st_enunciado = 12*log2(f0_postrer/f0_primer)

pend_st_enunciado = st_enunciado/(distancia_puntos)


pend_tonema = st_tone/(postrer_punto - tpo_ini_tonema)


divi = pend_tonema/pend_st_enunciado

#writeInfoLine: "st_M-m",tab$,"PenEn",tab$,"PendTon",tab$,"Div"
appendInfoLine: fixed$(st_M_m,1),tab$,fixed$(pend_st_enunciado,1),tab$,fixed$(pend_tonema,1),tab$,fixed$(divi,1)





# condiciones para 

Erase all
Black
Line width: 1
Select inner viewport: 1, 8, 1, 5

select ton_2

techo = max_f0+50

piso = min_f0 -50



Axes: 0, dur, piso, techo

Blue

Speckle size: 1.5


Speckle: 0, 0, piso, techo, "no"

Black

Draw inner box

Marks left every: 1, 50, "yes", "yes", "yes"


Red
Solid line
Draw arrow: primer_punto, f0_primer, postrer_punto, f0_postrer

Dashed line
Line width: 1.5
Draw line: primer_punto, f0_postrer, postrer_punto, f0_postrer
Draw line: primer_punto, f0_primer, primer_punto, f0_postrer

Solid line


Green
Draw arrow: tpo_ini_tonema, f0_ini_tonema, postrer_punto, f0_postrer
Dashed line
Draw line: tpo_ini_tonema, f0_postrer, postrer_punto, f0_postrer
Draw line: tpo_ini_tonema, f0_ini_tonema, tpo_ini_tonema, f0_postrer


tituloa$ = fixed$(pend_st_enunciado,2)
titulob$ = fixed$(pend_tonema,2)
amasb$ = "Pendientes: enunciado = " + tituloa$ + ";  tonema " + titulob$
Text top: "yes", amasb$

Line width: 1


select ton_2
plus pp
Remove
