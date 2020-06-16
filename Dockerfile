FROM gcr.io/google.com/cloudsdktool/cloud-sdk

WORKDIR /workspace
COPY app.sh /workspace

RUN apt update && apt install -y netcat

ENTRYPOINT while true; do nc -v -k -l -p $PORT -e /workspace/app.sh; done
