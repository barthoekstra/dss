# DSS (Data Science Stack)

This docker image runs Python 3 using Miniconda and [Jupyter Notebook](http://jupyter.org/). The following packages are pre-installed:
* [numpy](http://www.numpy.org/)
* [scipy](https://www.scipy.org/)
* [matplotlib](https://matplotlib.org/)
* [seaborn](https://seaborn.pydata.org/)
* [pandas](https://pandas.pydata.org/)
* [statsmodels](http://www.statsmodels.org/)
* [scikit-learn](http://scikit-learn.org/)
* [scikit-image](http://scikit-image.org/)
* [tensorflow](https://www.tensorflow.org/)
* [bokeh](https://bokeh.pydata.org/)
* [cython](http://cython.org/)
* [sympy](http://www.sympy.org/)
* [patsy](https://patsy.readthedocs.io/)
* [numba](https://numba.pydata.org/)

## How to use DSS
Assuming you have already [installed Docker](https://docs.docker.com/engine/installation/):
1. Download (pull) the image from the [Docker Hub](https://hub.docker.com) registry: `docker pull barthoekstra/dss`.
2. Navigate to a folder you want to store your project files in, using `cd`.
3. Run the Docker image: `docker run -it -p 8888:8888 -v $PWD:/tmp -w /tmp barthoekstra/dss`. This command mounts your present working directory (`$PWD`) into the Docker container's `/tmp` folder using `-v`, which makes all the files in your `$PWD` available to the Docker container in the `/tmp` folder. It then sets that folder to be the container's working directory using `-w /tmp` and maps [port](https://en.wikipedia.org/wiki/Port_(computer_networking)) 8888 on the Docker container to port 8888 on the host machine (your computer), using `-p 8888:8888`. You will see why that's useful in the next step.
4. The output of the `docker run` command should now show a URL to copy-paste. Open this URL — including the token — in your browser and your data science environment should be working. Did you notice the :8888 in the url? This is the [port](https://en.wikipedia.org/wiki/Port_(computer_networking)) you have defined in step 3.
5. Create a new Jupyter Python 3 Notebook: New (top right) > Python 3. This file will be stored in your `$PWD`, the working directory on your host which you have set in step 3.
6. (Do whatever you want to use the data science stack for).
7. Quit the Docker container by pressing `CTRL-C` twice in the Terminal/CMD window.
