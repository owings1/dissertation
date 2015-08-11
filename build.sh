#!/bin/bash

# Build script for Doug Owings' dissertation: Indeterminacy and Logical Atoms
# 
# This script has only been tested on mac OS 10.10.3 using texlive.
#
# texlive packages:
#     texlive
#     texlive-latex-extra
#     texlive-humanities
#     texlive-fonts-extra
#     texlive-music
#     texlive-bibtex-extra
#     texlive-pictures


sub_latex_draft() {
    latex -interaction=nonstopmode -halt-on-error -output-directory=log -draftmode "$1" > /dev/null &&
    echo -n '.'
}

sub_latex_final() {
    latex -interaction=nonstopmode -halt-on-error -output-directory=log -output-format=pdf "$1" | grep -F 'Output written' | grep -o '(.*)'
}

sub_bibtex() {
    bibtex "$1" > /dev/null &&
    echo -n '.'
}

do_clean() {
    echo "[CLEAN]:"
    rm -rfv log output
}

do_init() {
    echo "[INIT]:"
    mkdir -pv log output
}

do_latex_build_with_bib() {
    echo -n "[BUILD ${1}]: ."
    sub_latex_draft "src/tex/$1" &&
    sub_bibtex "log/$1"          &&
    sub_latex_draft "src/tex/$1" &&
    sub_latex_draft "src/tex/$1" &&
    sub_latex_final "src/tex/$1"
}

do_latex_build_no_bib() {
    echo -n "[BUILD ${1}]: ."
    sub_latex_draft "src/tex/$1" &&
    sub_latex_final "src/tex/$1"
}

do_post_build() {
    mv log/*.pdf output
}

do_print_success() {
    echo -e "\n---------------------------------------" &&
    echo -e "build succeeded\n\n`ls output/*.pdf`" &&
    echo -e "---------------------------------------"
}

do_print_failure() {
    echo "build failed. see log directory for errors."
    return 1
}

do_clean                               &&

do_init                                &&

do_latex_build_with_bib  dissertation  &&

do_latex_build_with_bib  prospectus    &&

do_latex_build_no_bib    abstract      &&

do_latex_build_no_bib    defense       &&

do_post_build                          &&

do_print_success                       ||

do_print_failure