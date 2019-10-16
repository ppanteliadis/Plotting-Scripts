#!/usr/bin/env Rscript
# File: pie_chart.R
# Author: Ioannis-Pavlos Panteliadis <ppanteliad@gmail.com>
# Last Updated: 10/16/2019
# 
# 
# Brief: Script to create beautiful pie charts

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

# Read the data
data <- read.csv(opt$file, header = T)

# Read and parse the settings
settings <- processFile(opt$settings)

palette <- strsplit(settings[1], ",")[[1]]
plot_name <- settings[2]
title <- settings[3]


# Check if the number of palette colors is the same as the number of groups
if (nrow(data) != length(palette)) {
    stop("The number of palette colors must be the same as the number of groups", call.=FALSE)
}


png(plot_name, width = 500, height = 500)
# Create a basic bar
ggplot(data, aes(x="", y=value, fill=group)) + geom_bar(stat="identity", width=1) +
    
    # Convert to pie (polar coordinates) and add labels
    coord_polar("y", start=0) + geom_text(aes(label = paste0(percent(value/sum(data$value), 1))), position = position_stack(vjust = 0.5)) + 
    
    # Add color scale (hex colors)
    scale_fill_manual(values=c(palette)) +
    
    # Remove labels and add title
    labs(x = NULL, y = NULL, fill = NULL) +
    ggtitle(title) +
    
    # Tidy up the theme
    theme_classic() + theme(axis.line = element_blank(),
                            axis.text = element_blank(),
                            axis.ticks = element_blank())

invisible(dev.off())