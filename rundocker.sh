#!/bin/bash
#To get image:
#docker pull bogden/wellcome

docker run -d -p 127.0.0.1:5000-5001:5000-5001 -e BACKEND_PORT=5000 -e FRONTEND_PORT=5001 -e BACKEND_ADDR=127.0.0.1 -t bogden/wellcome

#For debugging:
#docker run -it -p 127.0.0.1:5000-5001:5000-5001 -e BACKEND_PORT=5000 -e FRONTEND_PORT=5001 -e BACKEND_ADDR=127.0.0.1 -t bogden/wellcome /bin/bash
#or
#docker -it exec <image name> /bin/bash # docker ps will list images. Tab completion is your friend.
