ifneq (,$(wildcard ./.env))
include .env
export
ENV_FILE_PARAM = --env-file .env

endif

build-dev:
	docker compose up --build -d --remove-orphans api client-dev nginx-dev monseen-db redis celery_worker flower monseen-db   celery_beat

build-prod:
	docker compose up --build -d --remove-orphans api nginx monseen-db redis celery_worker flower monseen-db  

up:
	docker compose up -d

down:
	docker compose down

show-logs:
	docker compose logs -f

migrate:
	docker compose exec api python3 manage.py migrate

makemigrations:
	docker compose exec api python3 manage.py makemigrations

superuser:
	docker compose exec api python3 manage.py createsuperuser

collectstatic:
	docker compose exec api python3 manage.py collectstatic --no-input --clear

down-v:
	docker compose down -v

volume:
	docker volume inspect realestate_postgres_data

cephusestate-db:
	docker compose exec -it cephusestate-db psql --username=postgres --dbname=cephusdb

test:
	docker compose exec api pytest -p no:warnings --cov=.

test-html:
	docker compose exec api pytest -p no:warnings --cov=. --cov-report html

flake8:
	docker compose exec api flake8 .

black-check:
	docker compose exec api black --check --exclude=migrations .

black-diff:
	docker compose exec api black --diff --exclude=migrations .

black:
	docker compose exec api black --exclude=migrations .

isort-check:
	docker compose exec api isort . --check-only --skip env --skip migrations

isort-diff:
	docker compose exec api isort . --diff --skip env --skip migrations

isort:
	docker compose exec api isort . --skip env --skip migrations
