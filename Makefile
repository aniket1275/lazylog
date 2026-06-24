.PHONY: help fmt check lint test build run rust_run ci

PYTHON_DIR := apps/ai-service
BACKEND_PKG := backend

help:
	@echo "Available commands:"
	@echo "  make fmt       - format Rust and Python code"
	@echo "  make check     - verify formatting"
	@echo "  make lint      - run linters"
	@echo "  make test      - run tests"
	@echo "  make build     - build workspace"
	@echo "  make run       - fmt + lint + check + run backend"
	@echo "  make rust_run  - fmt + lint + run backend"
	@echo "  make ci        - full CI pipeline"

fmt:
	cargo fmt --all
#   cd $(PYTHON_DIR) && black .

check:
	cargo fmt --all --check
	cd $(PYTHON_DIR) && black --check .
	cd $(PYTHON_DIR) && ruff check .

lint:
	cargo clippy --workspace --all-targets --all-features -- -D warnings
#   cd $(PYTHON_DIR) && ruff check .

test:
	cargo test --workspace

build:
	cargo build --workspace

rust_run: fmt lint
	cargo run -p $(BACKEND_PKG)

run: fmt check lint
	cargo run -p $(BACKEND_PKG)

ci: check lint test build