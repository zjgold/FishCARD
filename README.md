# Improving Metabarcoding Taxonomic Assignment: A Case Study of Fishes in a Large Marine Ecosystem

Pre-print is Available [here](https://10.22541/au.161407483.33882798/v1)


Zachary Gold<sup>1</sup>,Emily Curd<sup>1</sup>,Kelly D. Goodwin<sup>3</sup>,Emma Choi<sup>2</sup>, Ben Frable<sup>2</sup>,Andrew R. Thompson<sup>4</sup>,H.J. Walker, Jr. <sup>2</sup>, Ronald S. Burton<sup>2</sup>,  Dovi Kacev<sup>2</sup>,Lucas D. Martz<sup>2</sup>,Paul H. Barber<sup>1</sup>


<sup>1</sup>Department of Ecology and Evolutionary Biology, UCLA, Los Angeles

<sup>2</sup>Scripps Institution of Oceanography, UCSD, La Jolla

<sup>3</sup>Ocean Chemistry and Ecosystems Division, Atlantic Oceanographic and Meteorological Laboratory, National Oceanic and Atmospheric Administration, stationed at Southwest Fisheries Science Center, La Jolla, California, USA

<sup>4</sup>Southwest Fisheries Science Center, NMFS/NOAA, La Jolla




## Abstract
DNA metabarcoding is an important tool for molecular ecology. However, its effectiveness hinges on the quality of reference sequence databases and classification parameters employed. Here we evaluate the performance of MiFish 12S taxonomic assignments using a case study of California Current Large Marine Ecosystem fishes to determine best practices for metabarcoding. Specifically, we use a taxonomy cross-validation by identity framework to compare classification performance between a global database comprised of all available sequences and a curated database that only includes sequences of fishes from the California Current Large Marine Ecosystem. We demonstrate that the curated, regional database provides higher assignment accuracy than the comprehensive global database. We also document a tradeoff between accuracy and misclassification across a range of taxonomic cutoff scores, highlighting the importance of parameter selection for taxonomic classification. Furthermore, we compared assignment accuracy with and without the inclusion of additionally generated reference sequences. To this end, we sequenced tissue from 597 species using the MiFish 12S primers, adding 252 species to GenBank’s existing 550 California Current Large Marine Ecosystem fish sequences. We then compared species and reads identified from seawater environmental DNA samples using global databases with and without our generated references, and the regional database. The addition of new references allowed for the identification of 16 native taxa and 17.0% of total reads from eDNA samples, including species with vast ecological and economic value. Together these results demonstrate the importance of comprehensive and curated reference databases for effective metabarcoding and the need for locus-specific validation efforts.

## Description
This page is dedicated to hosting code generated for the Accepted Molecular Ecology Resources Manuscript. FishCARD is a curated Calfiornia Current Large Marine Ecosystem fish specific reference database for MiFish Teleost and Elasmobranch 12S metabarcoding primer sets [Miya et al. 2015](https://royalsocietypublishing.org/doi/10.1098/rsos.150088). Included on this page is 1. Scripts used to Conduct Analyses 2. List of California Fish Species 3. List of California Fish Species still missing 12S reference barcodes 4. Three [CRUX-12S reference database](https://github.com/limey-bean/CRUX_Creating-Reference-libraries-Using-eXisting-tools) formatted reference databases: Regional (CCLME specific), Global (all 12S sequences), and GenBank

The CRUX-12S reference database was generated using standard CRUX parameters using EMBL and NCBI GenBank sequences downloaded in October 2019.

Efforts will be made to periodically update the FishCARD and CRUX-12S reference database ~every 6 months unless directly contacted to update sooner. Hoping to also string together the [TAXXI](https://drive5.com/taxxi/doc/index.html) and rCRUX (CRUX v2) to make this a more generalizable tool. Stay tuned...
