RUN for i in 1 2 3 4 5; do \
    mvn -B -ntp clean package -DskipTests && exit 0; \
    echo "Maven download failed. Retrying in 30 seconds..."; \
    sleep 30; \
done; \
exit 1