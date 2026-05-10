# Ollama
Ollama is an open-source tool designed to run Large Language Models (LLMs) locally on your own computer.

I use ollama to run small models locally.

## Access

Through server terminal or [API](#api)

## Setup

*COMPLETED 10/04/2026*

[Install Podman and Quadlet support](../../../system/podman/README.md)

Create directory
```bash
mkdir ~/ollama
```

Create quadlet
```bash
sudo nano ~/.config/containers/systemd/ollama.container
```
```ini
[Unit]
Description=Ollama Local AI
After=network-online.target

[Container]
Image=docker.io/ollama/ollama:latest
ContainerName=ollama

PublishPort=11434:11434

Volume=%h/ollama:/root/.ollama

Memory=14g

# Allow Ollama to listen to external requests
Environment=OLLAMA_HOST=0.0.0.0

[Service]
Restart=always

[Install]
WantedBy=multi-user.target default.target
```

Reload daemons and start service
```bash
systemctl --user daemon-reload
systemctl --user start ollama.service
```

## How to use

Open ollama container terminal
```bash
podman exec -it ollama ollama
```

Load new models 
```bash
ollama list
ollama run <model_name>
```
- Replace ```<model_name>```, with models  available here: https://ollama.com/search

Remove model
```bash
ollama rm <model_name>
```

Run model
```bash
ollama run llama3.2:3b
```

Chat history is not saved

## API

Request loaded models
```bash
curl http://localhost:11434/api/tags
```

Send prompt
```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2:3b",
  "prompt": "Hello!",
  "stream": false
}'
```