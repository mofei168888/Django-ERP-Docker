FROM daocloud.io/python:2-onbuild

MAINTAINER Robin<robin.chen@b-uxin.com>

ENV LANG C.UTF-8


RUN apt-get update
RUN apt-get install -y python && \
     apt-get install -y python-pip

RUN pip install --upgrade pip

#创建并管理Python运行的环境
RUN pip install virtualenv

RUN virtualenv -p /usr/bin/python2.7 env
#使用bash命令集

RUN ["/bin/bash","-c","source env/bin/activate"]

RUN  mkdir -p /erp

WORKDIR /erp

COPY /DiangoERP /erp
COPY base.txt /erp
COPY requirements.txt /erp

#安装Python程序运行的依赖库
RUN cd /erp && pip install -r base.txt
RUN cd /erp && pip install -r requirements.txt


EXPOSE 80


ENTRYPOINT ["python", "/erp/manage.py run 0.0.0.0:80"]