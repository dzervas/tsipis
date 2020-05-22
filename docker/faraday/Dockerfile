FROM python:3-slim

RUN pip install faradaysec

USER user
WORKDIR /app

COPY server.docker.ini server.docker.ini
COPY --chown=user:user entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

ENV POSTGRES_URL "postgresql+psycopg2://faraday:faraday@postgres/faraday"
ENV SECRET_KEY "MyVeryVeryLongSecretKey"
ENV AGENT_TOKEN "MyVeryVeryLongAgentToken"

EXPOSE 5985 6985

ENTRYPOINT ["./entrypoint.sh"]
CMD ["faraday-server"]
