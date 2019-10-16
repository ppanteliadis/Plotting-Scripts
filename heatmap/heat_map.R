#!/usr/bin/env Rscript
# File: heat_map.R
# Author: Ioannis-Pavlos Panteliadis <ppanteliad@gmail.com>
# Last Updated: 10/16/2019
# 
# 
# Brief: Script to create beautiful heatmaps

# If the script is executed from R studio, this will fail
# We use this in order to call utils package from anywhere. Just keep the file hierarchy!
getScriptPath <- function(){
    cmd.args <- commandArgs()
    m <- regexpr("(?<=^--file=).+", cmd.args, perl=TRUE)
    script.dir <- dirname(regmatches(cmd.args, m))
    if(length(script.dir) == 0) stop("can't determine script dir: please call the script with Rscript")
    if(length(script.dir) > 1) stop("can't determine script dir: more than one '--file' argument detected")
    return(script.dir)
}

source(paste0(getScriptPath(),'/', '../utils.r'))
source(paste0(getScriptPath(),'/',"heatmap3.R"))

# Open the data and do some preprocessing
data <- read.csv(opt$file, header = T, sep = ',', stringsAsFactors = TRUE)

rownames <- as.vector(data[,1])
colnames <- colnames(data)[c(2:ncol(data))]

data.to.plot <- as.vector(data)
data.to.plot <- data.to.plot[, -c(1)]

rownames(data.to.plot) <- rownames

# Read and parse the settings file
settings <- processFile('example_inputs/Settings.txt')

palette <- strsplit(settings[1], ",")[[1]]
plot_name <- settings[2]
       
my.palette <- colorRampPalette(palette)(n=length(palette))

png(filename = plot_name, width = 500, height = 500)
heatmap.3(data.to.plot,
		   Rowv = rownames(data.to.plot), 
		   Colv = colnames(data.to.plot), 
		   col = my.palette,
		   dendrogram = "none")
invisible(dev.off())

