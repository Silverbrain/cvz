# cvz
An experimental CV template based on [themagicalmammal](https://github.com/themagicalmammal/Resume).
I needed a way to create CV easy hence the name `cvz`. I wanted to have the flexibility to change my CV without being worried about it getting messy every time that I change it.
Also, it would be nice to have one template to create a cover letter as well as a resume but I did not want to have two different latex projects.

### This project is not so much different from the work of [themagicalmammal](https://github.com/themagicalmammal/Resume).

### The most important difference is that you can create multiple PDF files by running the render_separate.sh script in a neat and clear way.

## Usage
Download all files. make any changes you need to the cv tex files located in the cv directory.
Run the  `render_separate.sh` script to create your pdf files without worrying about all the annoying auxiliary files created by latex.
If you need to check the log files, you can navigate to the `aux` directory and find the log file you are looking for.

## Requirements
- zsh
- texlive
