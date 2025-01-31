# Build directory
BUILD_DIR = _build

# Output executable in build directory
OUTPUT = $(BUILD_DIR)/program

CUSTOME_IMAGE_NAME = gcc-image
CONTAINER_NAME = gcc-container
IMAGE_NAME = ubuntu
SRC = main.c

# Create Docker image

build:
	#@echo "Building Docker image..."
	docker build -t $(CUSTOME_IMAGE_NAME) -f ./docker/Dockerfile .


run: $(BUILD_DIR)
	@echo "Compiling $(SRC) to $(OUTPUT)..."
	docker run --rm -v $(PWD):/app --name $(CONTAINER_NAME) $(IMAGE_NAME) gcc $(SRC) -o $(OUTPUT)
	@echo "Compilation complete. Output: $(OUTPUT)"

shell: build $(BUILD_DIR)
	@echo "Starting interactive shell..."
	docker run --rm -it -v $(PWD):/app --name $(CONTAINER_NAME) $(CUSTOME_IMAGE_NAME) /bin/bash