#!/bin/bash

# Build script for Doug Owings' dissertation: Indeterminacy and Logical Atoms
# 
# texlive packages:
#     texlive
#     texlive-latex-extra
#     texlive-humanities
#     texlive-fonts-extra
#     texlive-music
#     texlive-bibtex-extra
#     texlive-pictures

echo "Cleaning"
rm -fr log output &&
mkdir log output &&
echo -n "Building dissertation ." &&
latex -interaction=nonstopmode -halt-on-error -output-directory=log -draftmode src/tex/dissertation >/dev/null &&
echo -n "." &&
bibtex log/dissertation >/dev/null &&
echo -n "." &&
latex -interaction=nonstopmode -halt-on-error -output-directory=log -draftmode src/tex/dissertation >/dev/null &&
echo -n "." &&
latex -interaction=nonstopmode -halt-on-error -output-directory=log -draftmode src/tex/dissertation >/dev/null &&
echo -n ". " &&
latex -interaction=nonstopmode -halt-on-error -output-directory=log -output-format=pdf src/tex/dissertation | grep -F 'Output written' | grep -o '(.*)' &&
echo -n "Building prospectus ." &&
latex -interaction=nonstopmode -halt-on-error -output-directory=log -draftmode src/tex/prospectus >/dev/null &&
echo -n "." &&
bibtex log/prospectus >/dev/null &&
echo -n "." &&
latex -interaction=nonstopmode -halt-on-error -output-directory=log -draftmode src/tex/prospectus >/dev/null &&
echo -n ". " &&
latex -interaction=nonstopmode -halt-on-error -output-directory=log -output-format=pdf src/tex/prospectus | grep -F 'Output written' | grep -o '(.*)' &&
echo -n "Building abstract ." &&
latex -interaction=nonstopmode -halt-on-error -output-directory=log -draftmode src/tex/abstract >/dev/null &&
echo -n ". " &&
latex -interaction=nonstopmode -halt-on-error -output-directory=log -output-format=pdf src/tex/abstract | grep -F 'Output written' | grep -o '(.*)' &&
echo -n "Building defense ." &&
latex -interaction=nonstopmode -halt-on-error -output-directory=log -draftmode src/tex/defense >/dev/null &&
echo -n ". " &&
latex -interaction=nonstopmode -halt-on-error -output-directory=log -output-format=pdf src/tex/defense | grep -F 'Output written' | grep -o '(.*)' &&
mv log/*.pdf output && 
echo -e "\n---------------------------------------" &&
echo -e "build succeeded\n\n`ls output/*.pdf`" &&
echo -e "---------------------------------------" || echo "build failed. see log directory for errors."