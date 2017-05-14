FROM jupyter/scipy-notebook

MAINTAINER Pawel T.  Jochym <pawel.jochym@ifj.edu.pl>

RUN conda config --add channels conda-forge
RUN conda config --add channels jochym
RUN conda install -y ase spglib nglview elastic phonopy
RUN conda install -y -c damianavila82 rise
RUN conda update -y --all

#RUN git clone https://github.com/jochym/abinitio-workshop.git /home/jovyan/work
#RUN cd /home/jovyan/work && git submodule init && git submodule update
COPY . /home/jovyan/work

USER root

# Add port for presentations
EXPOSE 8000
# Add dependencies
RUN sed 's/main/main contrib non-free/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install abinit abinit-doc povray imagemagick && apt-get clean

# Non-essential dependencies
RUN apt-get install -y pandoc texlive-latex-recommended texlive-fonts-recommended texlive-latex-extra && apt-get clean


# Extra dependencies
#RUN echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list.d/debian-multimedia.list
#RUN apt-get install -y --force-yes deb-multimedia-keyring
#RUN apt-get update
#RUN apt-get install -y ffmpeg && apt-get clean

