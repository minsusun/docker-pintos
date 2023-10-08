# docker-pintos

- Dockerfile for using pintos project on docker.
- Designed for POSTECH [CSED312] Oprating System Lecture.
- Using `qemu` emulator
- Apple chip compatible (confirmed with M1 Pro 23.10.08)

### Individual Build
Download `Dockerfile`
```shell
cd <directory_to_Dockerfile>
docker build --tag pintos:qemu --platform linux/x86_64 .
```

### Pull form Docker Hub
```shell
docker pull minsusun/pintos:qemu
```

### Run
For people built docker image individually
```shell
docker run --rm -it pintos:qemu
```
For people pulled image from docker hub
```shell
docker run --rm -it minsusun/pintos:qemu
```

### Enjoy
enjoy pintos