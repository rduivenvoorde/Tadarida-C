
# RSDB: (character) the path where the RSDB from Tadarida-L has been saved
# eg: /home/richard/git/tadarida-c/RSDB_sample
# eg: /home/richard/z/21/vleermuisgeluiden/RSDBnl/
#RSDB="/home/richard/z/22/vleermuisgeluiden/RSDBnl/"
# EINDIGEND MET EEN '/' !!! dan komt de output netjes in dat mapje terecht

# LET OP: in de RSDB moeten weer MAPPEN staan (meestal een datum-map) NIET meteen de wav/txt/eti dirs
# anders krijg je: FOUT: Error in etilist1[[i]] : subscript out of bounds ???

# onderstaande is waarschijnlijk te weinig bestandjes:
# Error in randomForest.default(x = Predictors, y = ClassY$class, replace = T,  : 
# Need at least two classes to do classification.
# EINDIGEN OP EEN / !!!!!
RSDB="/media/richard/WD_BLACK/wav_6s/"
RSDB="/tmp/RSDB/"
RSDB="/tmp/20221027T1000/RSDB/"

# VarSel: (character) a csv file indicating which sound features should be subsetted (see VarSel.csv example)
#VarSel=fread("VarSel.csv") #to uncomment to select variables
#VarSel=NA #NA if no selection of variables
VarSel=fread("/home/richard/git/tadarida-c/tadaridaC_src/other_inputs/VarSel.csv")

# SpeciesList: (optional, character) a path indicating a table listing the potential species and grouping, and/or a filter excluding some taxa, according to geographical occurrence for example. If no “SpeciesList” is provided, all taxa will be included in the classifier without any grouping.
#SPECIESLIST=
#SpeciesList=as.data.frame(fread("SpeciesList_ForVerbatim.csv")) #to uncomment if a species grouping and/or filtering is necessary
#SpeciesList=as.data.frame(fread("SpeciesList.csv")) #to uncomment if a species grouping and/or filtering is necessary
# /home/richard/z/21/vleermuisgeluiden/RSDBnl/SpeciesList.csv

 
# GeoFilter: (optional, character) a header of SpeciesList indicating which species list should be selected (= according to geographical occurrence
# eg: GeoFilter="France" #to uncomment and edit if a species filtering is necessary
# NOTE: IF GeoFilter is defined ALSO SpeciesList should be defined !!!!
#GeoFilter="France"


HPF=0 # high-pass filter  # in kHz:  20 voor 20 kHz


#### buildClassif_HF.r

# MRF: (character) the path where Modified_randomForest.r has been stored
MRF="./tadaridaC_src/Modified_randomForest.R"


#VarSel: (character) a csv file indicating which sound features should be subsetted (see VarSel.csv example)
# zie boven


#GeoFilter: (character) which geographical zone should be selected (if none, use "") (write_tabase3HF.r should have been run first)
# zie boven

# dit is de csv die is aangemaakt mbv write_tabase3HF.R !!!!!
#Ftabase="RSDB_sample_tabase3HF_sansfiltre.csv"
#Ftabase="/home/richard/z/21/vleermuisgeluiden/RSDBnl_tabase3HF_sansfiltre.csv"
#Ftabase="/media/richard/WD_BLACK/wav_tabase3HF_sansfiltre.csv"
#Ftabase="/home/richard/z/22/vleermuisgeluiden/20220518/wav_tabase.csv"

#SETTINGS (both are intended to balance unevenness in species sampling)
#SubSamp: (numeric) level of minimum subsampling (= X times average number of calls per species)
SubSamp=11 #level of minimum subsampling (= X times average number of calls per species)

#GradientSamp: (numeric) gradient strength (must be negative)
GradientSamp=-0.1 #gradient strength (must be negative)

SaveTemp=F

#Ftabase="RSDB_sample2011_tabase3HF_sansfiltre.csv"

StartForest=1
ToPredict="Nesp"
Simplified=T


