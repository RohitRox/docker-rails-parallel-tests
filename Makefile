cleanup:
	sh ./docker/cleanup.sh
build:
	docker-compose build
server:
	docker-compose run --service-ports --rm app bundle exec rails s -p 3000 -b 0.0.0.0
console:
	docker-compose run --rm app rails c
ssh:
	docker-compose run --rm app /bin/bash
setup:
	docker-compose build
	docker-compose run --rm app rake db:setup
	docker-compose run --rm app rake db:test:prepare
specs:
	docker-compose run --rm app rspec
