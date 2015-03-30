all: build

build: resource
	@sudo docker build --tag=${USER}/archiva:2.2.0 .

resource:
	@ ./prep.sh
	
