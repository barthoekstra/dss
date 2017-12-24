FROM debian:sid

MAINTAINER Bart Hoekstra <barthoekstra@gmail.com>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion nano \
    && rm -rf /var/lib/apt/lists/*

# Install miniconda and useful data science packages
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.3.30-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && export PATH=/opt/conda/bin:$PATH && \
    conda update -y --all && \
    conda install -y numpy scipy matplotlib seaborn pandas statsmodels \
    scikit-learn scikit-image tensorflow bokeh cython sympy patsy numba \
    jupyter notebook && \
    conda clean -y -t

ENV PATH /opt/conda/bin:$PATH

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 8888

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
