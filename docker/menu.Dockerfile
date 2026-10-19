
FROM node:20-bookworm-slim

WORKDIR /app

# Install menu service dependencies
COPY menuService/package.json menuService/package-lock.json ./
RUN npm ci --omit=dev

# Copy menu service source
COPY menuService/ ./

# Copy runtime files used by start.js
COPY build/ /build/
COPY data/ /data/

ENV NODE_ENV=production
ENV PORT=3003

EXPOSE 3003

CMD ["npm", "start"]
