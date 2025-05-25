RUN = docker-compose up -d  --build

CLEAN = docker-compose down  --rmi all

CLEAN_ALL = docker system prune -af ; clear;

all :
	cd srcs && $(RUN)

down:
	cd srcs && $(CLEAN)

clean:
	cd srcs && $(CLEAN_ALL)
re : down all

#go