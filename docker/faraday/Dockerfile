FROM python:3-slim

RUN apt-get update && apt-get install -y curl wget zsh pandoc
RUN curl -s https://api.github.com/repos/infobyte/faraday/releases/latest \
                       | grep '/faraday-server_amd64.deb' \
                       | cut -d : -f 2,3 \
                       | tr -d '\" ' | wget -qi - -O faraday-server_amd64.deb

RUN dpkg -i faraday-server_amd64.deb && rm faraday-server_amd64.deb

USER user
WORKDIR /app

#COPY server.docker.ini server.docker.ini
#COPY --chown=user:user entrypoint.sh entrypoint.sh
#RUN chmod +x entrypoint.sh
#
#ENV POSTGRES_URL "postgresql+psycopg2://faraday:faraday@postgres/faraday"
#ENV SECRET_KEY "MyVeryVeryLongSecretKey"
#ENV AGENT_TOKEN "MyVeryVeryLongAgentToken"
#
#EXPOSE 5985 6985
#
#ENTRYPOINT ["./entrypoint.sh"]
#CMD ["faraday-server"]
