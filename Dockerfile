FROM debian

LABEL project    "{PROJECT}"
LABEL module     "{APP}"

LABEL created_at "{CREATED_AT}"
LABEL updated_at "{UPDATED_AT}"

MAINTAINER {AUTHOR} <{AUTHOR}@yfcloud.com>

ADD {APP} /{PROJECT}/{APP}/

WORKDIR /{PROJECT}/{APP}/

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
 echo Asia/Shanghai > /etc/timezone

VOLUME     [ "/{PROJECT}/{APP}/var/" ]

EXPOSE     9091

#CMD ["-h"]

ENTRYPOINT [ "./{APP}" ]

