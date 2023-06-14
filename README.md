# cvz
An experimental CV template based on [themagicalmammal](https://github.com/themagicalmammal/Resume).
I needed a way to create CV easy hence the name `cvz`. I wanted to have the flexability to change my cv without being worried about it getting messy every time that I change it.
Also it would be nice to have one template to create coverletter as well as a resume but I did not want to have two different latex projects.

### this project is not so much different from the work of [themagicalmammal](https://github.com/themagicalmammal/Resume).

### The most important different is that you can create multiple pdf files by runnig the render_separate.sh script in a neat and clear way.

## Usage
Download all files. make any change you need to the cv tex files located in the cv directory.
Run the  `render_separate.sh` script to create your pdf files without worring about all the anoying auxiulary files created by latex.
If you need to chaeck the log files, you can navegate to the `aux` directory and find the log file you are looking for.

## Requirements
- zsh
- texlive
