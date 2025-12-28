# Build

```
docker buildx build --platform linux/amd64 -t test-vanity -f .\Dockerfile .
```

# Run

```
docker run --rm --gpus all test-vanity -C TRX TEST
```