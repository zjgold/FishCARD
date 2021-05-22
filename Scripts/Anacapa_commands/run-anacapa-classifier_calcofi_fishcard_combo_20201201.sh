# EDIT THESE
BASEDIR="/data/anacapa" # change to folder you want shared into container
CONTAINER="/data/anacapa/anacapa-1.5.0.img" # change to full container .img path
DB="/data/anacapa/Anacapa-New-Master_08152019/Anacapa_db" # change to full path to Anacapa_db
OUT="/data/home/zgold/zgold/fishcard/c19_out_20201201" # change to output data folder

cd $BASEDIR

# If you need additional folders shared into the container, add additional -B arguments below
time singularity exec -B $BASEDIR $CONTAINER /bin/bash -c "$DB/anacapa_classifier.sh -o $OUT -d $DB -l"