FROM node:18
WORKDIR /app

COPY package.json package.json
COPY package-lock.json package-lock.json

RUN npm ci

COPY . .
RUN npm run build

CMD ["sh", "-c", "cp -r /app/build/* /static/ && echo 'Frontend build copied to volume'"]
