FROM jupyter/base-notebook

MAINTAINER Pawel T.  Jochym <pawel.jochym@ifj.edu.pl>

USER root

RUN apt-get update
RUN apt-get -qy upgrade
RUN apt-get -qy install git apt-utils
RUN apt-get -qy install povray imagemagick && apt-get clean

# Non-essential dependencies
RUN apt-get install -qy htop pandoc 
RUN apt-get install -qy texlive-latex-recommended texlive-fonts-recommended texlive-latex-extra && apt-get clean

# Extra dependencies
RUN apt-get update
RUN apt-get install -y ffmpeg && apt-get clean

RUN apt-get clean

# Conda deps
USER jovyan
RUN conda install mamba
RUN mamba config --add channels jochym
RUN mamba install -y scipy numpy matplotlib ase spglib nglview elastic phonopy
RUN mamba install -y jupyter_contrib_nbextensions 
RUN mamba install -y -c damianavila82 rise
RUN mamba install -y vpython
RUN mamba install -y abinit
RUN mamba update -y --all
RUN mamba clean -y --all

# Materials
USER root
COPY . /home/jovyan/work
RUN chown -R jovyan:users /home/jovyan/work

# Update submodules
USER jovyan
RUN cd /home/jovyan/work && git submodule init && git submodule update



