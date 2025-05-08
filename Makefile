.PHONY: setup-env create-env install-deps activate-msg

VENV_DIR := .venv

setup-env: create-env install-deps activate-msg

create-env:
	@echo "📦 Creating virtual environment at $(VENV_DIR)..."
	@python3 -m venv $(VENV_DIR)

install-deps:
	@echo "📥 Installing dependencies..."
	@. $(VENV_DIR)/bin/activate && pip install --upgrade pip \
	&& pip install -r requirements.txt -r requirements-dev.txt

activate-msg:
	@echo ""
	@echo "✅ Environment setup complete."
	@echo "👉 To activate it, run:"
	@echo "   source $(VENV_DIR)/bin/activate"
	@echo ""


# Run linter
lint:
	ruff check .

# Run tests inside venv or container
test-venv:
	PYTHONPATH=. ./.venv/bin/pytest tests/

test-docker:
	docker run image-to-text pytest tests/

# Build Docker image
build:
	docker build -t image-to-text .

# Run locally
run:
	docker run -p 5000:5000 image-to-text

# Stop any container with this image
stop:
	docker ps -q --filter ancestor=image-to-text | xargs -r docker stop

# Clean unused docker resources
clean:
	docker system prune -af
