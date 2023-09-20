FROM alpine:3.8

# Root location
ARG ROOT_FOLDER=/webui
ARG MANIFEST_VERSION=1.0

# Create "META-INF/MANIFEST.MF" file
RUN mkdir -p ${ROOT_FOLDER}/META-INF
RUN echo "Manifest-Version: ${MANIFEST_VERSION}" > ${ROOT_FOLDER}/META-INF/MANIFEST.MF
RUN echo "Date-Timestamp: `date +'%Y-%m-%dT%H:%M:%S%z'`" >> ${ROOT_FOLDER}/META-INF/MANIFEST.MF

# Copy web app files
COPY ./src/ ${ROOT_FOLDER}/

# Set working directory
WORKDIR ${ROOT_FOLDER}

