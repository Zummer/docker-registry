init: docker-down-clear docker-pull docker-build docker-up
up: docker-up
down: docker-down

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build

password:
	docker run --rm registry:2 htpasswd -Bbn ${LOGIN} ${PASSWORD} > htpasswd

deploy:
	ssh ${HOST} -p ${PORT} 'rm -rf registry && mkdir registry'
	scp -P ${PORT} docker-compose-production.yml ${HOST}:registry/docker-compose.yml
	scp -P ${PORT} -r docker ${HOST}:registry/docker
	scp -P ${PORT} ${HTPASSWD_FILE} ${HOST}:registry/htpasswd
	ssh ${HOST} -p ${PORT} 'cd registry && echo "COMPOSE_PROJECT_NAME=site" >> .env'
	ssh ${HOST} -p ${PORT} 'cd registry && docker-compose pull'
	ssh ${HOST} -p ${PORT} 'cd registry && docker-compose up --force-recreate --remove-orphans -d'
