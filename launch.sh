(cd serv; HOST=0.0.0.0 PORT=${BACKEND_PORT:-5000} python3 run_server.py&)
sed -i "s#^const ENDPOINT = \"http://localhost:5000/\"#const ENDPOINT = \"http://${BACKEND_ADDR:-localhost}:${BACKEND_PORT:-5000}/\"#" docs/page/topic/src/index.js
(cd docs/page/topic && npx webpack --config webpack.config.js)
twistd -n -o web --path docs/ --listen tcp:${FRONTEND_PORT:-5001}
