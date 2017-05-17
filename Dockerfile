FROM jupyter/base-notebook

MAINTAINER Pawel T.  Jochym <pawel.jochym@ifj.edu.pl>

USER root

RUN apt-get update
RUN apt-get -y install git

USER jovyan

RUN conda config --add channels conda-forge
RUN conda config --add channels jochym
RUN conda install -y scipy numpy matplotlib ase spglib nglview elastic phonopy
RUN conda install -y jupyter_contrib_nbextensions 
RUN conda install -y -c damianavila82 rise
RUN conda update -y --all
RUN conda clean -tipsy

RUN git clone https://github.com/jochym/abinitio-workshop.git /home/jovyan/work
RUN cd /home/jovyan/work && git submodule init && git submodule update

USER root

RUN chown -R jovyan:users /home/jovyan/work

# Add dependencies
RUN sed 's/main/main contrib non-free/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install abinit povray imagemagick && apt-get clean

# Non-essential dependencies
#RUN apt-get install -y htop abinit-doc pandoc texlive-latex-recommended texlive-fonts-recommended texlive-latex-extra && apt-get clean

# Extra dependencies
#RUN echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list.d/debian-multimedia.list
#RUN apt-get install -y --force-yes deb-multimedia-keyring
#RUN apt-get update
#RUN apt-get install -y ffmpeg && apt-get clean

