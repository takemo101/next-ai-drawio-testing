# next-ai-draw-io Docker management
# Usage: just up [port] or just down

# Default port
default_port := "3000"

# Initialize .env from template
init:
    @if [ -f .env ]; then echo ".env already exists. Remove it first if you want to reinitialize."; exit 1; fi
    cp .env.example .env
    @echo "Created .env - edit it to set your API key"

# Start Docker container
up port=default_port:
    docker run -d -p {{port}}:3000 --name next-ai-drawio --env-file .env ghcr.io/dayuanjiang/next-ai-draw-io:latest
    @echo "Started on http://localhost:{{port}}"

# Stop and remove container
down:
    docker stop next-ai-drawio && docker rm next-ai-drawio

# View logs
logs:
    docker logs -f next-ai-drawio

# Restart container
restart port=default_port: down
    just up {{port}}

# Pull latest image
pull:
    docker pull ghcr.io/dayuanjiang/next-ai-draw-io:latest

# Remove image completely
clean: down
    docker rmi ghcr.io/dayuanjiang/next-ai-draw-io:latest
