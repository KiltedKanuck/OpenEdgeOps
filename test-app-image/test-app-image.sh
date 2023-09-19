echo "##teamcity[testStarted name='Test_MasterSample_DataObject']"

# Run Test using NodeJS
# export PATH=$PATH:/tools/linuxx86_64/nodejs/node-v6.9.1/bin
nvm use 6.9.1
npm install

node --version
npm --version
npm run test:rest

echo "##teamcity[testFinished name='Test_MasterSample_DataObject']"