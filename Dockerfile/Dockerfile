FROM centos:latest
RUN yum install python3  python3-devel   gcc-c++ -y && \
    python3 -m pip install --upgrade --force-reinstall pip && \
    yum install sudo -y && \
    yum install --assumeyes  python3-pip && \
    pip install keras && \
    pip install tensorflow --no-cache-dir  tensorflow && \
    pip install --upgrade pip tensorflow && \
    pip3 install flask && \
    pip3 install joblib && \
    pip3 install sklearn && \
    pip3 install pillow && \
    mkdir  /brain_tumor &&  \
    mkdir /brain_tumor/templates

COPY  brain_tumor_40.h5    /brain_tumor
COPY  app.py  /brain_tumor
COPY  myform.html  /brain_tumor/templates
COPY  results.html   /brain_tumor/templates
EXPOSE  4444
WORKDIR  /brain_tumor
CMD export FLASK_APP=app.py
CMD export export LC_ALL=en_US.utf-8
CMD export export LANG=en_US.utf-8
ENTRYPOINT flask  run --host=0.0.0.0    --port=4444
