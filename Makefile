.PHONY: run

run: ## Run container 
	docker run -w /app -v $(HOME)/.aws:/root/.aws -v `pwd`:/app hashicorp/packer:light



