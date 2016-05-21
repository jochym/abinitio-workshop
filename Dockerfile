FROM andrewosh/binder-base

MAINTAINER Andrew Osheroff <andrewosh@gmail.com>

USER root

# Add Julia dependencies
RUN apt-get update
RUN apt-get install -y imagemagick povray && apt-get clean

USER main

conda install --yes -c jochym ase
conda env list
