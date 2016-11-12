FROM andrewosh/binder-base

MAINTAINER Daniel Margulies <daniel.margulies@gmail.com>

# Switch to root user for installation
USER root

# Enable neurodebian
# RUN curl -sSL http://neuro.debian.net/lists/jessie.de-md.full | tee /etc/apt/sources.list.d/neurodebian.sources.list && \
#    curl -sSL http://neuro.debian.net/lists/jessie.us-tn.full >> /etc/apt/sources.list.d/neurodebian.sources.list && \
#    apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9 && \
#    apt-get update -qq && \
#    apt-get install -y -qq fsl afni
# bash <(wget -q -O- http://neuro.debian.net/_files/neurodebian-travis.sh) &&
#  sudo apt-get -y update &&
# Update conda and install dependencies
# conda update anaconda --yes --quiet && \
# python -c "from matplotlib import font_manager" && \

RUN conda update conda --yes --quiet && \
    conda config --add channels conda-forge && \
    conda install --yes --quiet h5py \
                                ipython \
                                jupyter \
                                matplotlib \
                                networkx \
                                nibabel \
                                numpy \
                                pandas \
                                scikit-learn \
                                scipy \
                                seaborn \
                                && \    
    conda clean -ay && \
    pip install --upgrade --quiet pip && \
    pip install --upgrade --quiet gdist \
                                  surfdist \
                                  git+https://github.com/satra/mapalign \
                --ignore-installed && \
    apt-get clean remove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /boot /media /mnt /opt /srv

ENV SHELL /bin/bash

