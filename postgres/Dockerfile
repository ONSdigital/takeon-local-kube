FROM postgres:11.5-alpine
EXPOSE 5432
WORKDIR /takeon-db
COPY . /takeon-db
RUN chmod +x /takeon-db/entry.sh
USER postgres
