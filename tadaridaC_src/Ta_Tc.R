ClassifC1="ClassifC1.R"
AggContacts="AggContacts.R"
AggNbSp="AggNbSp.R"
PipBuz="PipBuz.R"

#get arguments from the command line
args <- commandArgs(trailingOnly = TRUE)

if(length(args)<3) #for local tests
{
  print("Gebruik args van Command line")
  ClassifC1="/home/richard/git/tadarida-c/tadaridaC_src/ClassifC1.R"
  AggContacts="/home/richard/git/tadarida-c/tadaridaC_src/AggContacts.R"
  AggNbSp="/home/richard/git/tadarida-c/tadaridaC_src/AggNbSp.R"
  PipBuz="/home/richard/git/tadarida-c/tadaridaC_src/PipBuz.R"
  
  #args="/media/richard/WD_BLACK/21106_DenHaag/002/txt" # directory containing .ta files to classify
  #args="/media/richard/WD_BLACK/test/txt"
  #args="/media/richard/WD_BLACK/test/bcalls-ppip_1.0_8_6s/txt"
  #args="/media/richard/WD_BLACK/unknown/txt"
  #args[1]="F:/txt"
  #args[2]="ClassifEsp_LF_180320.learner"
  #args[2]="ClassifEsp_RSDB_LF_tabase3HF_sansfiltre_2020-04-22.learner"
  #args[2]="/media/richard/WD_BLACK/wav_6stabase.learner"
  #args[2]="ClassifEspFrance180303.learner"
  #args[3]="tabase3_LFXC"
  args[3]="N"
  
  #options (HPF = filtre passe-haut / Reduc = r?duction des features par DFA)
  args[4]=0 #HPF  # 0 is GEEN HPF filter, anders de hoeveelheid kHz, bv 40 voor 40.000 kHz
  args[5]=F #Reduc - obsolete
  args[6]=F #TC  # 1 tc file per wav/ta (T/True) of een Total (F/False)
  args[7]=1000 #block size
  args[8]=0 #init for test
  args[9]=0 #init for test
  #args[10]="SpeciesList.csv" #species list
  args[10]= "./other_inputs/SpeciesList.csv"
  args[11]="CNS_tabase3HF_France_IdConc.learner" #name of the species number" classifier
  args[12]=F #if species number should be filtered or not
  args[13]=NA # "Referentiel_seuils_ProbEspHF_.csv"
  args[14]=80000 #an additionnal, larger block size to handle memory leaks problem in randomForest
  args[15]="ClassifEsp_tabase3HF_France_Cir_2019-11-26_wiSR.learner"
  args[16]="CNS_RSDB_HF_tabase3HF_sansfiltre_IdTot_wiSR_IdConc.learner"
  #args[17]="Referentiel_seuils_RSDB_HF_tabase3HF_sansfiltre_IdTot_wiSR_IdConc__G.csv"
  args[18]=1 #block number
  #args[19]="ClassifBuzzPippip170328.learner"
}

print(getwd())
print(args)

tadir=args[1]
talistot=list.files(tadir,pattern=".ta$",full.names=T)

if(length(talistot)>as.numeric(args[14])*(as.numeric(args[18])-1))
{
  talistot=talistot[(as.numeric(args[14])*(as.numeric(args[18])-1)+1)
                    :(min(length(talistot)
                          ,as.numeric(args[14])*(as.numeric(args[18]))))]
  
  FITA=file.info(talistot)
  talistot=subset(talistot,FITA$size>1000)
  
  
  
  block=as.numeric(args[7])
  
  
  for (r in 1:ceiling(length(talistot)/block))
  {
    args[8]=block*(r-1)+1 #start number
    args[9]=block*r #end number
    #source(ResizeTA)
    
    source(ClassifC1)
    print(paste(r,ceiling(length(talistot)/block),Sys.time()))
    if(!skip){
      source(AggContacts)
      source(AggNbSp)
    }
    
    print(gc())
    
  }
}

