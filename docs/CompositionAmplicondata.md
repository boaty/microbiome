<!--
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteIndexEntry{microbiome tutorial - composition}
  %\usepackage[utf8]{inputenc}
  %\VignetteEncoding{UTF-8}  
-->

Also see [phyloseq barplot
examples](http://joey711.github.io/phyloseq/plot_bar-examples.html).

Read example data from a [diet swap
study](http://dx.doi.org/10.1038/ncomms7342):

    # Example data
    library(microbiome)
    library(dplyr)
    data("DynamicsIBD")
    ps1 <- DynamicsIBD
    colnames(tax_table(ps1))

As you can see the taxonomic classification is just lablled as "Rank1"
... "Rank7". We need to change this to proper designation and also do
some formatting of the data. This can be a useful example for
understanding simple file processing in R.

    # First change the column names of the taxonomy table in phyloseq to following:

    colnames(tax_table(ps1)) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species" )

    tax_table(ps1)[tax_table(ps1)[,"Kingdom"]== "NA", "Kingdom" ] <- "Unidentified_Kingdom"

    tax_table(ps1)[tax_table(ps1)[,"Phylum"]== "p__", "Phylum" ] <- "p__Unidentified_Phylum"

    # make a dataframe for taxonomy information.

    taxic <- as.data.frame(ps1@tax_table) 
    otu.df <- abundances(ps1)

    # make a dataframe for OTU information.
    otu.df <- as.data.frame(otu.df)

    # check the rows and columns
    # head(otu.df) 

    # Add the OTU ids from OTU table into the taxa table at the end.
    taxic$OTU <- row.names.data.frame(otu.df) 

    # You can see that we now have extra taxonomy levels.
    colnames(taxic)

    # convert it into a matrix.
    taxmat <- as.matrix(taxic)

    # convert into phyloseq compaitble file.
    new.tax <- tax_table(taxmat)  

    # incroporate into phyloseq Object
    tax_table(ps1) <- new.tax 

    # To speed up the example we will use only those OTUs that are detected 100 times and present in 50% of the samples.

    pseq2 <- core(ps1, detection = 100, prevalence = .5)

### Composition barplots

Same with compositional (relative) abundances; for each sample (left),
or averafged by group (right).

    # Try another theme
    # from https://github.com/hrbrmstr/hrbrthemes
    library(hrbrthemes)
    library(gcookbook)
    library(tidyverse)

    # Limit the analysis on core taxa and specific sample group
    p <- plot_composition(pseq2,
                  taxonomic.level = "Genus",
                          sample.sort = "ibd_subtype",
                          x.label = "ibd_subtype",
                          transform = "compositional") +
         guides(fill = guide_legend(ncol = 1)) +
         scale_y_percent() +
         labs(x = "Samples", y = "Relative abundance (%)",
                                       title = "Relative abundance data",
                                       subtitle = "Subtitle",
                                       caption = "Caption text.") + 
         theme_ipsum(grid="Y")
    print(p)  

    # Averaged by group
    p <- plot_composition(pseq2,
                          average_by = "ibd_subtype", transform = "compositional", taxonomic.level = "Genus")
    print(p)

    # Improve the plotting
    tax_table(pseq2)[tax_table(pseq2)[,"Family"]== "f__", "Family" ] <- "f__Unclassified Family"

    # We will also remove the "f__" patterns for cleaner labels
    tax_table(pseq2)[,colnames(tax_table(pseq2))] <- gsub(tax_table(pseq2)[,colnames(tax_table(pseq2))],pattern="[a-z]__",replacement="")

    p2 <- plot_composition(pseq2, taxonomic.level = "Family", transform = "compositional", average_by = "ibd_subtype") + theme(legend.position = "bottom") + theme_bw() + theme(axis.text.x = element_text(angle = 90)) + ggtitle("Relative abundance") + scale_fill_brewer(palette = "Set3")

    print(p2)

### Plot taxa prevalence

We use the Dynamics IBD data set from [Halfvarson J., et al. Nature
Microbiology, 2017](http://www.nature.com/articles/nmicrobiol20174) as
downloaded from [Qiita ID
1629](https://qiita.ucsd.edu/study/description/1629). This function
allows you to have an overview of OTU prevalences alongwith their
taxonomic affiliations. This will aid in checking if you filter OTUs
based on prevalence, then what taxonomic affliations will be lost.

    # We will use the ps1 object we created previously.
    print(ps1)
    # Use sample and taxa subset to speed up example
    p0 <- subset_samples(ps1, sex == "male" & timepoint == 1)

    # For the available taxonomic levels
    plot_taxa_prevalence(p0, "Phylum")