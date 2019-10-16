#!/usr/bin/env Rscript
# File: utils.R
# Author: Ioannis-Pavlos Panteliadis <ppanteliad@gmail.com>
# Last Updated: 10/16/2019
# 
# 
# Brief: Util functions and packages for the plot scripts

######################################
# Library invocations and package installs (if needed)
######################################
if (!require("ggplot2", quietly=TRUE)) {
    install.packages("ggplot2")
    library("ggplot2")
}

if (!require("optparse", quietly=TRUE)) {
    install.packages("optparse")
    library("optparse")
}

if (!require("stringr", quietly=TRUE)) {
    install.packages("stringr")
    library("stringr")
}

######################################
# Function declarations
######################################
percent <- function(x, digits = 2, format = "f", ...) {
    paste0(formatC(100 * x, format = format, digits = digits, ...), "%")
}

# Helper function to open the respective Settings file.
processFile <- function(filepath) {
    
    settings <- c()
    
    con = file(filepath, "r")
    while ( TRUE ) {
        line = readLines(con, n = 1)
        if ( length(line) == 0 ) {
            break
        }

        settings <- c(settings, line)
    }
    
    close(con)
    
    return (settings);
}

rotate <- function(x) t(apply(x, 2, rev))   # found the stackoverflow post that this code is from: http://stackoverflow.com/questions/16496210/rotate-a-matrix-in-r



######################################
# This part is common for all the scripts and should be executed beforehand
######################################
usage <- "usage: %prog -s <settings_file> -f <data_file>"
option_list = list(
    make_option(c("-s", "--settings"), type="character", default=NULL, 
                help="Settings file for the plot", metavar="character"),
    make_option(c("-f", "--file"), type="character", default=NULL, 
                help="File containing the .csv to plot with a header", metavar="character")
);

opt_parser <- OptionParser(usage=usage, option_list=option_list)
opt <- parse_args(opt_parser)

# Sanity checks before going to the main plotting script
if (is.null(opt$settings)){
    print_help(opt_parser)
    stop("At least one settings file must be supplied.", call.=FALSE)
}

if (is.null(opt$file)){
    print_help(opt_parser)
    stop("At least one .csv file must be supplied.", call.=FALSE)
}

