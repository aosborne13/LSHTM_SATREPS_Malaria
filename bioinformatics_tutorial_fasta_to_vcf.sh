
### Bioinformatics tutorial - raw Fasta/q to vcf ###

## EVERYTHING IN COMMAND LINE IS CASE SENSITIVE - MUST ME TYPED EXACTLY AS SHOWN HERE ##

# Install required packages

sudo apt-get update
sudo apt-get install gcc
sudo apt-get install make
sudo apt-get install libbz2-dev
sudo apt-get install zlib1g-dev
sudo apt-get install libncurses5-dev 
sudo apt-get install libncursesw5-dev
sudo apt-get install liblzma-dev

## Create a tools folder to keep track of all of your packages!!!

cd ~
mkdir tools
cd tools

## Install using command line NOT CONDA

git clone git://github.com/samtools/htslib.git
git clone git://github.com/samtools/bcftools.git
cd bcftools
make

sudo apt update
sudo apt install bwa

## Download and install snpEff - this is used to annotate SNPs in oder to see if they contribute to a coding shift
# website - https://pcingola.github.io/SnpEff/download/

# There is no Pf3D7 database for snpEff, I had to build one so we need to replace and add some files after you install this with ones I have made

cd /tools/snpEff

# delete snpEff.config and replace with the snpEff.config file I have sent
# create a data folder

mkdir data
cd data

# create folder for Pf3D7 in data folder

mkdir Pf3D7
cd Pf3D7

# Download these files I have supplied and put them in /home/tools/data/Pf3D7/ - genes.gff.gz , protein.fa , sequences.fa , snpEffectPredictor.bin

# go back to home directory
cd ~

# make directory for data analysis in Documents folder

cd Documents
mkdir bioinfo_tutorial
cd bioinfo_tutorial

# Download the genome reference file I have sent and out it in the tutorial folder - Pfalciparum.genome.fasta
# Also Download the fasta sequences for each sample (there are two files per sample - e.g. 1_1 and 1_2)

# index the reference file - check out this website to understand why we do this - https://www.biostars.org/p/212594/#:~:text=Like%20the%20index%20at%20the,shorter%20sequences%20embedded%20within%20it.
bwa index Pfalciparum.genome.fasta


## Perform mapping of sequences with the reference genome using the following code for each sample
# this takes the sequences and aigns them with the reference genome, as well as dows some basic quality filtering
# the two fastq files will be used to generate a single bam file

bwa mem -t 10 -R "@RG\tID:AGT12\tSM:ATG12\tPL:Illumina" Pfalciparum.genome.fasta 1_1.fastq.gz 1_2.fastq.gz | samtools view -@ 10 -b - | samtools sort -@ 10 -o sample1.bam -

# Then index the bam file with

samtools index sample1.bam

# Create a table of variants
# This creates a vcf file (variant call format file) from you bam file - this will compile all of your snps and indels (insertions/deletions) into a single file

bcftools mpileup -f Pfalciparum.genome.fasta sample1.bam | bcftools call -mv  > sample1.vcf

# for this exercise we will annotate and look at SNPs in only one gene rather than the entire genome as this is unneccesary and may use more computing power than you have
# first we need to compress our vcf file to make it manageable to work with

bgzip -c sample1.vcf > sample1.vcf.gz

# index compressed file

bcftools index -f sample1.vcf.gz

# Let's look at Pfg377 by extracting the variants located where the gene is located - this is where carefully labelling your files becomes important so you know what step you are on

bcftools view --regions CHROM,Pf3D7_12_v3:2045070-2054500 sample1.vcf.gz > sample1_pfg377.vcf

# in order to streamline this we will only look at the SNPs in this gene (we will exclude indels and deletions for this exercise) - notice how I keep adding information in the file name

bcftools view --types snps sample1_pfg377.vcf > sample1_pfg377_snps.vcf

# Now we will annotate the SNPs and their effects on the gene using the snpEff package we installed earlier (might take a few seconds)

java -Xmx4g -jar ~/tools/snpEff/snpEff.jar Pf3D7 sample1_pfg377_snps.vcf > sample1_pfg377_snps_snpEff.vcf

## once this is done we can view the vcf file in the terminal or in excel - IF YOU OPEN IN EXCEL REMEMBER TO NEVER SAVE ANY CHANGES - this will ruin the file
# to view in terminal

bcftools view sample1_pfg377_snps_snpEff.vcf | egrep -v '##' | head -20


# to calculate your allele frequency and minor allele frequency of these snps use your unannotated vcf
# this may require additional packages to be installed and the pathway to be exported - we will see

bcftools +fill-tags sample1_pfg377_snps.vcf > sample1_pfg377_snps_MAF.vcf

# view in terminal

bcftools view sample1_pfg377_snps_MAF.vcf | egrep -v '##' | head -20

