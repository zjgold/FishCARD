# EDIT THESE
BASEDIR="/data/anacapa" # change to folder you want shared into container
CONTAINER="/data/anacapa/anacapa-1.5.0.img" # change to full container .img path
DB="/data/anacapa/Anacapa-New-Master_08152019/Anacapa_db" # change to full path to Anacapa_db
DATA="/data/home/zgold/zgold/fishcard/seqs_fishcard" # change to input data folder (default 12S_test_data inside Anacapa_db)
OUT="/data/home/zgold/zgold/fishcard/c19_out_20201201" # change to output data folder

# OPTIONAL
FORWARD="/data/home/zgold/zgold/fishcard/forward_primers_fishcard_combo.txt"
REVERSE="/data/home/zgold/zgold/fishcard/reverse_primers_fishcard_combo.txt"

cd $BASEDIR

# If you need additional folders shared into the container, add additional -B arguments below

time singularity exec -B $BASEDIR $CONTAINER /bin/bash -c "$DB/anacapa_QC_dada2.sh -i $DATA -o $OUT -d $DB -f $FORWARD -r $REVERSE -e /data/home/zgold/zgold/fishcard/metabarcode_loci_min_merge_length_fishcard_combo.txt -a nextera -t MiSeq -l"

