#!/bin/bash

#5001 in the front end. To listen elsewhere e.g. example.com:4321:5001.
#5000 is the back end. To listen elsewhere e.g. example.com:1234:5000. HOWEVER, a backend location of 127.0.0.1:5000 is baked into the front end.

docker run -d -p 127.0.0.1:5000:5000 -p 127.0.0.1:5001:5001 hatori

#for debugging
#docker run -it -p 127.0.0.1:5000:5000 -p 127.0.0.1:5001:5001 hatori /bin/bash
