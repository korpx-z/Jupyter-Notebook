FROM ubuntu:bionic

RUN apt update && \
  apt install -y openssh-server git vim autoconf g++ ca-certificates curl \
	wget python3 python3-pip nodejs npm libffi-dev sudo \
	software-properties-common net-tools dumb-init && \
	pip3 install Cython numpy && \
	pip3 install jupyter tornado==5 pandas && \
	python3 -m ipykernel install --user && \
	npm install -g configurable-http-proxy && \
	rm -rf /var/lib/apt/lists/*;

# Expose the 8888 port to view the Notebook in the browser
EXPOSE 8888
RUN echo "root:Docker!" | chpasswd

RUN jupyter notebook --generate-config && \
	echo "c.NotebookApp.allow_root=True" >>  /root/.jupyter/jupyter_notebook_config.py && \
        echo "c.NotebookApp.allow_origin = '*'" >>  /root/.jupyter/jupyter_notebook_config.py && \
        echo "c.NotebookApp.allow_remote_access = True" >> /root/.jupyter/jupyter_notebook_config.py

COPY configAndStart.sh /usr/bin/configAndStart.sh

ENTRYPOINT [ "dumb-init", "--", "/usr/bin/configAndStart.sh" ]
