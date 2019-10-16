<img src="icon.png" align="right" />

# Beautiful plots [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome#readme)
> Aren't you tired of not being able to plot correctly?

##Incorporating plots in your pipeline is now easier than ever! 

My personal experience with R has been a love-hate relationship. Every time I wanted to plot something I was either frustrated with how long each individual had to be adjusted to the scripts that I had for plotting, or I was amazed by how diverse plots I could produce! 

Well, I've decided to start sharing my scripts that are tailor-made to be in your pipeline!

##How to use
Well, the trickiest part is to set up a `Settings` file for your script. So let's get that out of the way!

###Settings
Just make a `.txt` file and inside write your configuration. Place it in the directory with the example inputs, or you could use one that it's provided. 

1. Colors in HTML format (ex. #FFFFFF,#000000,...)
2. Name of the exported file
3. (Pie chart only) Plot title to be placed on top.

Now that this is done, navigate to the location of the `heat_map.R` script and simply write the following line in your terminal.

`Rscript heat_map.R -s example_inputs/Settings.txt -f example_inputs/Input.csv`

That's it! Now a beautiful plot will be created in your current directory. Exactly as per your specifications!
