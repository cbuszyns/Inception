NAME= inception

$(NAME): run

run:
	@nohup gnome-terminal -- sudo docker compose -f ./srcs/docker-compose.yml up --build 2> /dev/null
down:
	sudo docker compose -f ./srcs/docker-compose.yml down

vclean:
	sudo docker volume rm -f srcs_wordpress_data
	sudo docker volume rm -f srcs_mariadb_data

iclean:
ifneq (,$(wildcard ./nohup.out))
	rm nohup.out
endif

	sudo docker image rm i-mariadb:1.0.0
	sudo docker image rm i-nginx:1.0.0
	sudo docker image rm i-wordpress:1.0.0

clean: vclean iclean

fclean: down clean

re: fclean run
