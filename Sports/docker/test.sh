cd ./tests

# downlad goss and dgoss
# export GOSS_DST=.
# export GOSS_VER=v0.3.16
# curl -fsSL https://goss.rocks/install | sh

# export GOSS_PATH=./goss
export GOSS_OPTS="--format junit"
echo "Running Goss Tests"
dgoss run -it ${APP_NAME}:${APP_VERSION} /bin/sh > unitTestReport.xml
