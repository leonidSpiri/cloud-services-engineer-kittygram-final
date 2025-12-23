FROM node:18 AS build
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build


FROM alpine:3.20
WORKDIR /app

# React build artifacts
COPY --from=build /app/build ./build

# At runtime this container just copies the build to the shared volume `static`.
# The gateway (Nginx) serves the files from there.
CMD ["sh", "-c", "cp -r /app/build/. /static/ && echo 'Frontend static copied to /static' && tail -f /dev/null"]
