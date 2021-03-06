# DSS (Data Science Stack)

This Docker image runs Python 3 using Miniconda and [Jupyter Notebook](http://jupyter.org/). The following packages are pre-installed:
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
5. Create a new Jupyter Python 3 Notebook: New (top right) > Python 3. This file will be stored in your `$PWD`, the working directory on your host which you have set in step 3, in this case your current working directory.
6. (Do whatever you want to use the data science stack for).
7. Quit the docker container by pressing `CTRL-C` twice in the Terminal/CMD window.

## How does this work?
The [Docker documentation](https://docs.docker.com/get-started/#a-brief-explanation-of-containers) describes a Docker image and container as follows:
> An **image** is a lightweight, stand-alone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files.

> A **container** is a runtime instance of an image—what the image becomes in memory when actually executed. It runs completely isolated from the host environment by default, only accessing host files and ports if configured to do so.

In the case of this Docker image, the 'piece of software' is a Jupyter Notebook environment running Python 3 and a bunch of packages related to data science. The contents and configuration of the image are described in this repository's [Dockerfile](https://github.com/barthoekstra/dss/blob/master/Dockerfile) (have a look to see at what lines, for example, the packages are installed). Whenever the Dockerfile in this repository gets updated (i.e. the updated file is pushed to the repository), [Docker Hub](https://hub.docker.com) will initiate an automatic 'build' of this Dockerfile and turn it into an image, which can then be downloaded using `docker pull barthoekstra/dss`. Beware, the `docker pull` command pulls the docker image from the Docker Hub repository, not from this GitHub repository with the same name.

## Build your own image
It is possible to build your own image from a Dockerfile, without using Docker Hub. Make sure you have cloned this repository somewhere locally on your system (or at least have a valid Dockerfile stored somewhere), navigate to the folder these files are stored in (using `cd`) and then run the following command: `docker build -t imagename .`, where you replace `imagename` with your desired name. The `.` is added to make Docker build an image from the Dockerfile in the current directory (which you have moved to). Once all build steps are completed, you can run your Docker image (i.e. run a container) using the same command listed above (see [How to use DSS](https://github.com/barthoekstra/dss#how-to-use-dss) bullet 3), but by changing `barthoekstra/dss` into the `imagename` you have just defined.

## Install additional packages / Execute commands in the container
Let's say we need to scrape data from a website using the [BeautifulSoup4](https://www.crummy.com/software/BeautifulSoup/) package, but it is not yet installed in the Docker container/image. There are two ways to install it:
1. You install it by adding it in the right section of the Dockerfile and afterwards you rebuild the new image from this file.
2. You install the package in a running container.

The first is straightforward, and explained above, the latter is a bit more complicated:
1. Make sure your container is running using the `docker run` command listed above (see [How to use DSS](https://github.com/barthoekstra/dss#how-to-use-dss)).
2. Run the `docker ps` command in your Terminal/CMD window. This lists all the containers you have ever started on your system. If you're new to Docker and have not played around with it before, this should only show 1 container, the one we have created in the former steps. So, the only listed `IMAGE` should be `barthoekstra/dss`. The last column contains a generic name assigned to this container, such as `hardcore_khorana`.
3. Access the Terminal/CMD window (shell) of the running Docker container using the following command: `docker exec -it hardcore_khorana bash` (replacing `hardcore_khorana` with the name listed in the last column shown by the `docker ps` command). If this worked, you should see that you are now 'logged in' to the container with a root user account (you should see something like `root@b40faa2af75`) and the working directory has changed to the value set when starting the container (in this case `\tmp`).
4. Now simply install the BeautifulSoup4 package using the `conda` command: `conda install beautifulsoup4`.

Similarly, all tasks that require access to the container while it is running can be executed by first logging in to the container shell using `docker exec -it [containername] bash`.
