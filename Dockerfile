FROM andrewosh/binder-base

MAINTAINER Pawel T.  Jochym <pawel.jochym@ifj.edu.pl>

USER root

# Add dependencies
RUN sed 's/main/main contrib non-free/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y imagemagick povray abinit abinit-doc && apt-get clean

USER main

RUN conda config --add channels conda-forge
RUN conda config --add channels jochym
RUN conda create -y -n binder ase spglib jupyter
#RUN conda install -y -n python3 ase spglib
RUN conda env list

RUN echo "export PATH=/home/main/anaconda2/envs/binder/bin/:$PATH" >> ~/.binder_start
RUN /bin/bash -c "source activate binder && jupyter kernelspec install-self --user"

ADD repo $HOME/notebooks

USER root
RUN chown -R main:main $HOME/notebooks

USER main
RUN find $HOME/notebooks -name '*.ipynb' -exec ipython trust {} \;

WORKDIR $HOME/notebooks
