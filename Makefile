VER=$(shell git rev-parse --short HEAD)

build:
	cd rate-limit-filter && cargo +nightly build --target=wasm32-unknown-unknown --release 

deploy:
	docker-compose up --build --remove-orphans

# shows only the logs related to WASM filter/singleton 
deploy-filtered:
	docker-compose up --build --remove-orphans | grep "\[wasm\]\|Starting"

run: build deploy

run-filtered: build deploy-filtered

clean:
	cargo clean

build-web:
	cd web && docker build -t khulnasoft/image-hub-web:latest -t khulnasoft/image-hub-web:$(VER) .

build-api:
	cd api && docker build -t khulnasoft/image-hub-api:latest -t khulnasoft/image-hub-api:$(VER) .

build-envoy:
	cd rate-limit-filter && docker build -t khulnasoft/image-hub-envoy:latest -t khulnasoft/image-hub-envoy:$(VER) .

dev-run-api: build-api deploy

dev-run-web: 
	cd web && yarn serve

image-push-latest:
	docker push khulnasoft/image-hub-web:latest
	docker push khulnasoft/image-hub-api:latest
	docker push khulnasoft/image-hub-envoy:latest

image-push-version:
	docker push khulnasoft/image-hub-web:$(VER)
	docker push khulnasoft/image-hub-api:$(VER)
	docker push khulnasoft/image-hub-envoy:$(VER)
