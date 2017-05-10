## Install the necessary packages

install.packages('devtools')
library(devtools)
devtools::install_github('leffj/mctoolsr')

# load mctoolsr
library(mctoolsr)

install.packages("vegan")
library(vegan)

## some of the necessary packages did not install properly, thus here are some extra.
# install.packages('curl')
# library(curl)
# install.packages("biomformat")

# source("https://bioconductor.org/biocLite.R")
# biocLite("BiocInstaller")



## load the data: both the mapping file, which contains the factors that we want to look at, and the taxonomic identifiers (OTUs)
mapfp = "Final_Project/data_files/Mapping_file.txt"
tabfp = "Final_Project/data_files/otu_table_wTax_noChloroMito.txt"
## combine these data sets so that they can be worked with together
input_f = load_taxa_table(tab_fp = tabfp, map_fp = mapfp)
## see what's in it
head(input)
#see what we did.
str(input)

### Filter out chloroplast and mitochondrial sequences
input_f = filter_taxa_from_input(input = input, taxa_to_remove = 'Chloroplast')
input_f = filter_taxa_from_input(input = input, taxa_to_remove = 'mitochondria')

## it's okay if this doesn't run, it just means they don't exist in the file already - tis a good thing!

## Decide the rarifying depth 

  #Returning numbers of sequences per sample to see where a good rarifying depth might be
hist(sort(colSums(input_f$data_loaded)), breaks = 100, xlim = c(1,9000))
## it's okay if this doesn't run, it just means they don't exist in the file already


## rarify to 5000  
sort(colSums(input$data_loaded))
input_frar = single_rarefy(input = input, depth = 5000)

## REMOVING BLANKS/ things you don't want, like NAs if present
working_dat = filter_data(input = input_frar, filter_cat = 'blank', filter_vals = 'NA')

## what are the most abundant OTUs?
return_top_taxa(input = working_dat, number_taxa = 10)


## How many OTUs are there in total
nrow(working_dat$data_loaded)

## head(wroking_dat$data_loaded   <- get different num of otus B/C rarifying pulls out random ones
## (beware of rerunning the rarifaction since it changes what you have)

#################################################################################################

## Phylum level taconomy and plot
taxa_smry = summarize_taxonomy(input=working_dat, level = 6) ##levels can decided how finely you want to look at the data (phylum level, order level, class level, etc)

#################################################################################################

## heat map

plot_ts_heatmap(
  tax_table = taxa_smry,
  metadata_map = working_dat$map_loaded,
  min_rel_abund = 0.02,
  type_header = 'blank'
)

## Richness across sample types

plot_diversity(input = working_dat, variable = 'blank', 'richness')
working_dat$map_loaded$rich = calc_diversity(tax_table = working_dat$data_loaded, 
                                             metric = 'richness')
## average diversity between the two types
tapply(working_dat$map_loaded$rich, working_dat$map_loaded$blank, FUN = mean)

#################################################################################################

## create disimilarity matrix
dm = vegdist(t(input_frar$data_loaded), ord_type = 'pcoa')
dm
## calculate oridnation axes
ord <- calc_ordination(dm = dm, ord_type = 'PCoA')
ord
## plot the ordination
## Convert num to categorical
input_frar$map_loaded$blank = as.factor(input_frar$map_loaded$blank)

## store the plot in a variabe
at1 <- plot_ordination(
  input = input_frar,
  ordination_axes = ord,
  color_cat = 'blank'
  #shape_cat = '', ## for extra factors if needed
)

## load gg_plot2
library(ggplot2)
### to add elipses to the plot here
at1 + stat_ellipse(mapping = aes(color = working_dat$map_loaded$blank))

#################################################################################################

# Run PERMANOVA to test for significant differences in the composition of 
# communities across inside and outside 
adonis(formula = dm ~ input_frar$map_loaded$blank)

#################################################################################################

# taxa driving differences across sample types (produce types in this case)
ts = summarize_taxonomy(input = input_frar, level = 5)
ts
outfp = 'taxa_driving_difs_withthe5.csv'

taxa_summary_by_sample_type(
  taxa_smry_df = ts,
  metadata_map = input_frar$map_loaded,
  type_header = 'blank',
  filter_level = 0.01, ## must have an abundance of at least 1%
  test_type = 'MW', # 'KW' for >2 sample types, 'MW' for 2 sample types
  out_fp = outfp
)






