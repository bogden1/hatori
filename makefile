SHELL := bash
STATEFILE := huge-data/debates/topic_state_100
DOCSFILE  := huge-data/debates/mc-20170814-stemmed.txt
ABS_STATEFILE := $(abspath $(STATEFILE))
ABS_DOCSFILE := $(abspath $(DOCSFILE))

assets: serv/generate_assets.py $(ABS_STATEFILE) $(ABS_DOCFILE) | serv/data docs/cloud
	(cd serv; python3 generate_assets.py -s $(ABS_STATEFILE) -d $(ABS_DOCSFILE))

front-build: page-build-front page-build-graph page-build-home page-build-map page-build-topic

page-build-%:
	(cd docs/page/$*; make)

web: back-end front-end

back-end:
	(cd serv; python run_server.py > back_stdout &)

front-end:
	(activate hatori-frontend; twistd -n -o web --path docs/ --listen tcp:5001:interface=127.0.0.1 &)
	#(cd docs; python3 -m http.server -b 127.0.0.1 5001 > front_stdout &)

$(ABS_STATEFILE): $(ABS_STATEFILE).gz
	(cd $(dir $@); gunzip -k $<)

serv/data:
	mkdir $@

docs/cloud:
	mkdir $@
