postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=tsakalos -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=tsakalos --owner=tsakalos simple_bank

dropdb:
	docker exec -it postgres12 dropdb --username=tsakalos simple_bank

migrateup:
	migrate -path db/migration "postgresql://tsakalos:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://tsakalos:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgress createdb dropdb migrateup migratedown sqlc test
