FROM continuumio/anaconda

RUN apt-get update && apt-get install -y g++ 
RUN conda install bcolz jupyter -y && \
  pip install keras==1.1.0 theano==0.8.2

RUN  mkdir /root/.keras
COPY keras.json /root/.keras

RUN  mkdir /notebooks
RUN  mkdir /data

EXPOSE 8888
# Volumes - data,notebooks, keras models?
VOLUME ["/notebooks"]
VOLUME ["/data"]
VOLUME ["/keras/models"]

# inherited
# ENTRYPOINT [ "/usr/bin/tini", "--" ]

# CMD [ "/bin/bash" ]
CMD [ "jupyter", "notebook", "--notebook-dir=/notebooks", "--ip='*'", "--port=8888", "--no-browser", "--allow-root" ]