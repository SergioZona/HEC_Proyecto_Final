clear all

import delimited "C:\Users\Sergio Julian Zona M\Desktop\Repositorios\Universidad\HEC_Proyecto_Final\output\census73_grouped.csv"

global xlist p10_lee_es p11_estudi p18_trab73 p19a_singr p12_nivele_ninguno p12_nivele_otros p12_nivele_primaria p12_nivele_secundariabachillerat p12_nivele_secundarianormal p12_nivele_secundariatecnica p12_nivele_superior

describe $xlist 
summarize $xlist
corr $xlist

pca $xlist, mineigen(1) blanks(0.35)

// Component rotation
rotate, blanks(0.35)

// Loading plot
predict pc1 pc2 pc3, score

scalar pond_comp1=0.43197698314
scalar pond_comp2=0.42019454719
scalar pond_comp3=0.14769146458

// Se calcula el índice.
gen y_index = (pc1*pond_comp1) + (pc2*pond_comp2) + (pc3*pond_comp3)

// Corremos regresiones
reg y_index league p03_sexo p04_edad p20_thnv p14_trabaj_notrabajo p14_trabaj_quehaceresdelhogar p14_trabaj_sinactividad p14_trabaj_trabajo p14_trabaj_viviodesurenta, robust

outreg2 using data.doc, replace ctitle(Índice de trabajo y educación) addstat(F, e(p))

// Verificamos multicolinealidad
vif

// Corremos múltiples regresiones contra las variables que componen el índice.

// Lee y Escribe:
reg p10_lee_es league p03_sexo p04_edad p20_thnv p14_trabaj_notrabajo p14_trabaj_quehaceresdelhogar p14_trabaj_sinactividad p14_trabaj_trabajo p14_trabaj_viviodesurenta, robust

outreg2 using data.doc, append ctitle(Lee y estudia) addstat(F, e(p))

// Ingreso:
reg p19a_singr league p03_sexo p04_edad p20_thnv p14_trabaj_notrabajo p14_trabaj_quehaceresdelhogar p14_trabaj_sinactividad p14_trabaj_trabajo p14_trabaj_viviodesurenta, robust

outreg2 using data.doc, append ctitle(Ingreso) addstat(F, e(p))

// Niveles de educación:
// Superior:
reg p12_nivele_superior league p03_sexo p04_edad p20_thnv p14_trabaj_notrabajo p14_trabaj_quehaceresdelhogar p14_trabaj_sinactividad p14_trabaj_trabajo p14_trabaj_viviodesurenta, robust

outreg2 using data.doc, append ctitle(Educación superior) addstat(F, e(p))

// Secundaria Bachillerato:
reg p12_nivele_secundariabachillerat league p03_sexo p04_edad p20_thnv p14_trabaj_notrabajo p14_trabaj_quehaceresdelhogar p14_trabaj_sinactividad p14_trabaj_trabajo p14_trabaj_viviodesurenta, robust

outreg2 using data.doc, append ctitle(Bachillerato) addstat(F, e(p))

// Primaria:
reg p12_nivele_primaria league p03_sexo p04_edad p20_thnv p14_trabaj_notrabajo p14_trabaj_quehaceresdelhogar p14_trabaj_sinactividad p14_trabaj_trabajo p14_trabaj_viviodesurenta, robust

outreg2 using data.doc, append ctitle(Primaria) addstat(F, e(p))
