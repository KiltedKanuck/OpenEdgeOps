echo "Starting test of Services of the Sample Sports App!"

# Run Test using NodeJS
export PATH=$PATH:/home/ubuntu/.nvm/versions/node/v6.9.1/bin/
npm install

node --version
npm --version

echo "Waiting for the application to come up."
sleep 45s
npm run test:rest

echo "Starting test of Services of the Sample Sports App Complete!"