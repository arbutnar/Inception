COMPOSE_FILE = ./srcs/docker-compose.yml

all:
	@sudo docker-compose -f $(COMPOSE_FILE) build
	@sudo docker-compose -f $(COMPOSE_FILE) up -d

stop:
	@sudo docker stop $$(sudo docker ps -qa)

clean:
	@sudo docker-compose -f $(COMPOSE_FILE) down
	-@sudo docker rmi -f $$(sudo docker images -qa) 2>/dev/null
	-@sudo docker volume rm $$(sudo docker volume ls -q) 2>/dev/null
	@sudo rm -rf /home/arbutnar/data/wordpress/*
	@sudo rm -rf /home/arbutnar/data/mariadb/*
	@sudo docker system prune -f


re: clean all
