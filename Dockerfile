FROM andrewosh/binder-base

MAINTAINER Andrew Osheroff <andrewosh@gmail.com>

USER root

# Add Julia dependencies
RUN apt-get update
RUN apt-get install -y povray imagemagick && apt-get clean

USER main

conda config --add channels conda-forge
conda config --add channels jochym
conda env create -n binder ase python=3.5

