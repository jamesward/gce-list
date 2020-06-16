FROM gcr.io/google.com/cloudsdktool/cloud-sdk

WORKDIR /workspace
COPY app.sh /workspace

RUN apt update && apt install -y ncat

ENTRYPOINT while true; do ncat -v -k -l $PORT -e /workspace/app.sh; done
