FROM node:19.2-alpine3.16 as deps
# cd /app
WORKDIR /app
# Dest /app
COPY package.json ./
# Install dependencies
RUN npm install


FROM node:19.2-alpine3.16 as test
# cd /app
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . . 
RUN npm run test


FROM node:19.2-alpine3.16 as prod-deps
# cd /app
WORKDIR /app
# Dest /app
COPY package.json ./
# Install dependencies
RUN npm install --prod


#FROM --platform=$BUILDPLATFORM node:19.2-alpine3.16 as runner
FROM node:19.2-alpine3.16 as runner
# cd /app
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY app.js ./ 
COPY tasks/ ./tasks
CMD ["node", "app.js"]
