

## Methylo New stuff

## /data/shared/2016_10_06_Mixed_16S_Angela_Alix_StudentMethods/Undetermined_S0_L001_R2_001.fastq.gz
## Undetermined_S0_L001_I1_001.fastq.gz
## Undetermined_S0_L001_R1_001.fastq.gz
## Undetermined_S0_L001_R2_001.fastq.gz

## prep_fastq_for_uparse_paired.py -i Undetermined_S0_L001_R1_001.fastq.gz -r Undetermined_S0_L001_R2_001.fastq.gz -b Undetermined_S0_L001_I1_001.fastq.gz -m Map_same_ol_same.txt -o demultiplexed_seqs/
install.packages('devtools')
library(devtools)
devtools::install_github('leffj/mctoolsr')
install.packages('curl')
library(curl)
install.packages("biomformat")

# load mctoolsr
library(mctoolsr)

source("https://bioconductor.org/biocLite.R")
biocLite("BiocInstaller")

install.packages("mctooslr")
library(mctoolsr)
install.packages("vegan")
library(vegan)

mapfp = "C:/Users/Godzilla/Documents/Masters/THE_MAP.txt"
tabfp = "Actual_data/otu_table_wTax_noChloroMito.txt"

input_f = load_taxa_table(tab_fp = tabfp, map_fp = mapfp)
head(input_f)

str(input_f)

dm = vegdist(t(input_f$data_loaded), method = 'bray')
dm
########
##****##
########
tax_table_fp = ("C:/Users/Godzilla/Documents/Masters/Tax_OTU_pH_table.txt")
map_f = ("C:/Users/Godzilla/Documents/Masters/THE_MAP.txt")

input = load_taxa_table(tax_table_fp, map_f)

input_f = filter_taxa_from_input(input = input, taxa_to_remove = 'Chloroplast')
input_f = filter_taxa_from_input(input = input, taxa_to_remove = 'mitochondria')
(input_f)
input_fBlank <- filter_data(input_f, filter_cat = 'has_soil', keep_vals = 'no')

blank_tax <- input_fBlank$taxonomy_loaded

#Returning numbers of sequences per sample
sort(colSums(input$data_loaded))
hist(sort(colSums(input$data_loaded)), breaks = 100, xlim = c(1,10000))

### Look at blanks, etc first
Table <- read.csv('C:/Users/Godzilla/Documents/Masters/Tax_OTU_pH_table.csv')

head(Table)

# Trying to look at one sample's community
PCRBLANK1 <- select(input$data_loaded, PCRBLANK1)
# merges two data frames based on a column or attribute (i.e. rownames) they
# share
PCRBLANK1_tax <- merge(PCRBLANK1, input$taxonomy_loaded, by = "row.names")

grepl(or("BLANK", "Empty", "NTC", "Swab"), input$map_loaded$SampleType)

BLANKs <- mutate(input$map_loaded, SampleID = row.names(input$map_loaded)) %>%
  select(SampleID, SampleType) %>%
  filter(grepl("Blank", SampleType))


select(input$data_loaded, match(BLANKs$SampleID))



head(input$taxonomy_loaded)

input_frar = single_rarefy(input = input_f, depth = 5000)

## how many are blanks?
input$map_loaded$has_soil

## how many samples total

head(input_f$map_loaded)
nrow(input_f$map_loaded)


## HEATMAP
# Phylum level taxonomy and plot

## REMOVING BLANKS / things you don't want

working_dat = filter_data(input = input_f, filter_cat = 'has_soil', filter_vals = 'yes')
working_dat2 = filter_data(input = input_f, filter_cat = 'has_soil', filter_vals = 'no')
## what are the most abundant OTUs?
top_taxa_in_no_soil <- return_top_taxa(input = working_dat, number_taxa = 5)
top_taxa_in_yes_soil <- return_top_taxa(input =working_dat2, number_taxa = 5)

# How many OTUs are there in total?
nrow(working_dat$data_loaded)
# head(working_dat$data_loaded)

# Diversity across sample types
plot_diversity(input = working_dat, variable = 'has_soil', 'richness')

working_dat$map_loaded$rich = calc_diversity(tax_table = working_dat$data_loaded, metric = 'richness')
tapply(working_dat$map_loaded$rich, working_dat$map_loaded$SampleType, FUN = mean)


taxa_smry = summarize_taxonomy(input = working_dat, level = 5)

plot_taxa_bars(
  tax_table = taxa_smry,
  metadata_map = working_dat$map_loaded,
  type_header = 'has_soil',
  num_taxa = 10
)

plot_ts_heatmap(tax_table = taxa_smry, metadata_map = working_dat$map_loaded, min_rel_abund = 0.02, type_header = 'has_soil')


## create disimilarity matrix
dm = vegdist(t(input$data_loaded), ord_type = 'pcoa')
dm
## calculate oridnation axes
ord <- calc_ordination(dm = dm, ord_type = 'PCoA')
ord
## plot the ordination
## Convert num to categorical if needed
input$map_loaded$pH = as.factor(input$map_loaded$pH)

input$map_loaded$pH2 = as.character(input$map_loaded$pH)
input$map_loaded$pH2[is.na(input$map_loaded$pH2)] = 'NA'

input$map_loaded$has_soil2 = as.factor(input$map_loaded$has_soil)
input$map_loaded$has_soil2[is.na(input$map_loaded$has_soil)] = 'NA'

input$map_loaded$soil2 = as.factor(input$map_loaded$soil)
input$map_loaded$soil2[is.na(input$map_loaded$soil2)] = 'NA'
head(input$map_loaded)

plot_ordination(
  input = input,
  ordination_axes = ord,
  shape_cat = 'ph2',
  olor_cat = 'ph2'
)

# communities across soil type 
##tmp = filter_data(input_frar, 'soil', NA)


input_frar$map_loaded$soil2 = as.character(input_frar$map_loaded$soil)
input_frar$map_loaded$soil2[is.na(input_frar$map_loaded$soil2)] = 'blank'

input_frar$map_loaded$pH2 = as.character(input_frar$map_loaded$pH)
input_frar$map_loaded$pH2[is.na(input_frar$map_loaded$pH)] = 'blank'

input_frar$map_loaded$MeOH2 = as.character(input_frar$map_loaded$MeOH_presence)
input_frar$map_loaded$MeOH2[is.na(input_frar$map_loaded$MeOH_presence)] = 'blank'

input_frar$map_loaded$pH_plate2 = as.character(input_frar$map_loaded$plate_pH)
input_frar$map_loaded$pH_plate2[is.na(input_frar$map_loaded$plate_pH)] = 'blank'

input_frar$map_loaded$pH_soil2 = as.character(input_frar$map_loaded$soil_Ph)
input_frar$map_loaded$pH_soil2[is.na(input_frar$map_loaded$soil_Ph)] = 'blank'


input_frar$map_loaded$rep2 = as.character(input_frar$map_loaded$rep)
input_frar$map_loaded$rep2[is.na(input_frar$map_loaded$rep)] = 'blank'

adonis(formula = dm ~ input_frar$map_loaded$soil2 + input_frar$map_loaded$pH2, na.rm = T)


adonis(formula = dm ~ input_frar$map_loaded$soil2 + input_frar$map_loaded$MeOH2, na.rm = T)


adonis(formula = dm ~ input_frar$map_loaded$soil2 + input_frar$map_loaded$MeOH2, na.rm = T)


adonis((formula = dm ~ input_frar$map_loaded$pH_plate2 + input_frar$map_loaded$pH_soil2))

adonis((formula = dm ~ input_frar$map_loaded$rep2 + input_frar$map_loaded$soil2))


plot_ordination(
  input = input_frar,
  ordination_axes = ord,
  shape_cat = 'MeOH2',
  color_cat = 'rep2'
)





## How many samples of each type?
table(input_frar$map_loaded$soil)





## REMOVING BLANKS / things you don't want

working_dat = filter_data(input = input_frar, filter_cat = 'soil', filter_vals = 'MeOH_presence')

## what are the most abundant OTUs?
return_top_taxa(input = working_dat, number_taxa = 5)
working_dat

# How many OTUs are there in total?
nrow(working_dat$data_loaded)
# head(working_dat$data_loaded)

# Diversity across sample types
plot_diversity(input = working_dat, variable = 'soil', 'richness')

working_dat$map_loaded$rich = calc_diversity(tax_table = working_dat$data_loaded,
                                             metric = 'richness')

tapply(working_dat$map_loaded$rich,
       working_dat$map_loaded$soil2,
       FUN = mean)



# Phylum level taxonomy and plot
taxa_smry = summarize_taxonomy(input = working_dat, level = 2)
plot_taxa_bars(
  tax_table = taxa_smry,
  metadata_map = working_dat$map_loaded,
  type_header = 'InsideOutside',
  num_taxa = 6
)

plot_ts_heatmap(
  tax_table = taxa_smry,
  metadata_map = working_dat$map_loaded,
  min_rel_abund = 0.02,
  type_header = 'InsideOutside'
)


#####################################################################################

map <- read.csv("Actual_data/Mapping_file.csv")
OTU_table <- read.csv("Actual_data/OTU_table.csv")
head(OTU_table)
row.names(OTU_table) <- OTU_table$OTU_ID

## find which samples have a higher OTU counts than 500 for the swab blank samples

## swab blank 1
OTU_SB1 <- which(OTU_table$swab_blank1 > 500)
str(OTU_SB1)
SB1OTUs <- OTU_table[OTU_SB1,]
head(SB1OTUs)
data.frame(SB1OTUs)
write.csv(SB1OTUs, file = "")

## swab blank 2
OTU_SB2 <- which(OTU_table$swab_blank2 > 500)
SB2OTUs <- OTU_table[OTU_SB2,]
SB2OTUs

## make it a function
?function(){}

OTU_counter <- function(sample_name, data, sample, count_min, new_filename){
  sample_name <- which(data$sample > count_min)
  new_filename <- data[sample_name,]
  print(new_filename)
  return(new_filename)
}

OTU_counter(
  sample_name = OTU_SBtwo,
  data = OTU_table,
  sample = OTU_table$swab_blank2,
  count_min = 500,
  new_filename = "SBtwo"
)

for (variable in vector) {
  
}



## swab blank 2
OTU_SB2 <- which(OTU_table$swab_blank2 > 500)
SB2OTUs <- OTU_table[OTU_SB2,]
SB2OTUs
## swab blank 3
OTU_SB3 <- which(OTU_table$swab_blank3 > 500)
SB3OTUs <- OTU_table[OTU_SB3,]
SB3OTUs
## swab blank 4
OTU_SB4 <- which(OTU_table$swab_blank4 > 500)
SB4OTUs <- OTU_table[OTU_SB4,]
SB4OTUs
## swab blank 5
OTU_SB5 <- which(OTU_table$swab_blank5 > 500)
SB5OTUs <- OTU_table[OTU_SB5,]
SB5OTUs

## NTC - no template controls
## NTC1
OTU_NTC1 <- which(OTU_table$NTC1 > 500)
NTC1 <- OTU_table[OTU_NTC1,]
NTC1
## NTC2
OTU_NTC2 <- which(OTU_table$NTC2 > 500)
NTC2 <- OTU_table[OTU_NTC2,]
NTC2
## NTC4
OTU_NTC4 <- which(OTU_table$NTC4 > 500)
NTC4 <- OTU_table[OTU_NTC4,]
NTC4

## Now the empty cells
## NTC1
OTU_empty1 <- which(OTU_table$empty_cell1 > 500)
Empty_ind1 <- OTU_table[OTU_empty1,]
Empty_ind1

