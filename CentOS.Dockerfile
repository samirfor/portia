FROM centos:7

ADD . /app

RUN /app/provision.sh \
        install_deps \
        install_splash \
        install_python_deps \
        configure_nginx \
        cleanup

ENV PYTHONPATH /app/slybot:/app/slyd

EXPOSE 9001

WORKDIR /app/slyd

# TODO(dangra): fix handling of nginx service, it won't be restarted in case if crashed.
CMD systemctl start nginx; bin/slyd -p 9002 -r /app/slyd/dist
