#http://qiita.com/yu4u/items/55fc44ac2ee75346823a
# sudo nvidia-docker build -t cuda:8.0-cudnn5-devel-tf1.2 .
# sudo nvidia-docker run -it -v ~:/share:rw -p 9999:9999 cuda:8.0-cudnn5-devel-tf1.2


FROM nvidia/cuda:8.0-cudnn5-runtime-ubuntu16.04


RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils vim net-tools

RUN apt-get install -y --no-install-recommends build-essential git wget
RUN apt-get install -y --no-install-recommends python-pip python-dev

RUN pip install --upgrade pip setuptools
RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.2.1-cp27-none-linux_x86_64.whl
#RUN pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.2.1-cp27-none-linux_x86_64.whl
RUN pip install jupyter matplotlib sklearn scipy pillow
RUN jupyter notebook --allow-root --generate-config
RUN echo "c.NotebookApp.ip = '*'" >> ~/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.port = 9999" >> ~/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py

# コンテナ容量節約のため
RUN rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

ENTRYPOINT ["/bin/bash"]

#sudo nvidia-docker start e44955be8c6f
#sudo nvidia-docker attach e44955be8c6f
##jupyter notebook --no-browser --allow-root
##cd /share/tmp/tensorflow/; jupyter notebook --no-browser --allow-root
#sudo docker ps -a
#nvidia-smi -q
