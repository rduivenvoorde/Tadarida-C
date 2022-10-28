
# INPUT
# Het beginpunt is een RSDB (Reference Sound Data Base): een directory met 
# wav bestandjes en eti files (de door tadarida gevonden calls (en evt tags) in de wavjes)
# Een eti file bevat alle geluidjes/calls en een index/getal/volgnummer.
# Met Tadarida-l kun je die labelen (en sonogrammen van maken) OF via ons bc2eti script

# Een ta file (in de txt dir) is een metadata file van een wav bestand (aangemaakt met Tadarida-D)
# deze heeft voor elk geluidje/call een hele rij gegevens/features (lengte/hoogte etc etc)

# LET OP: op dit moment RStudio opstarten vanuit: /home/richard/git/tadarida-c

# OUTPUT
# een learner file (classifier), die dan door Ta_Tc.R wordt gebruikt 

library(data.table) #used to generate features table from labelled sound database


# variabelen (CHECK!!)
source('./inputs.R')

# eerst write_tabase3HF.R aanroepen, om een csv tabel aan te maken(Ftabase, zijnde een csv)
# die als input dient voor buildClassif_HF.r

print(paste(getwd()))
print(paste0('Op basis van RSDB: ', RSDB))
print(paste0('Maken we Ftabase: ', RSDB, "tabase.csv"))

# dit maakt aan:
# tabase.csv  <= is de ta database voor de learner
# _NbSiteEsp.csv
source('./tadaridaC_src/builders/write_tabase3HF.R')
# dit maakt de learner file aan
source('./tadaridaC_src/builders/buildClassif_HF.R')

print(paste0('Learner file aangemaakt: ', RSDB, "tabase.learner"))

# en nu gaan we een set unknown (wav) ta files classificeren 
# (die door Tadarida-D zijn getrokken om de ta files te hebben)
# zie https://github.com/YvesBas/Tadarida-C#using-the-classifier
#source('./tadaridaC_src/Ta_Tc.R')
# of via command line:
# cd /home/richard/git/tadarida-c/tadaridaC_src
# Rscript Ta_Tc.R 
# of met argumenten:
# arg 0 = txt dir met .ta files van onbekenden
# arg 1 = learner file
# arg 3 = N
# Rscript Ta_Tc.R /media/richard/WD_BLACK/unknown/txt/ppip /media/richard/WD_BLACK/wav_6stabase.learner




