# Install dependencies only when needed
FROM node:alpine AS deps
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk update && apk add --no-cache libc6-compat && apk add git
WORKDIR /app
COPY package.json ./
RUN yarn install --immutable


# Rebuild the source code only when needed
FROM node:alpine AS builder
# add environment variables to client code
ARG NEXT_PUBLIC_BACKEND_URL
ARG NEXT_PUBLIC_META_API_KEY


ENV NEXT_PUBLIC_BACKEND_URL=$NEXT_PUBLIC_BACKEND_URL
ENV NEXT_PUBLIC_META_API_KEY=$NEXT_PUBLIC_META_API_KEY

WORKDIR /app
COPY . .
COPY --from=deps /app/node_modules ./node_modules
ARG NODE_ENV=production
RUN echo ${NODE_ENV}
RUN NODE_ENV=${NODE_ENV} yarn build

# Development image
FROM builder AS development
ENV NODE_ENV=development
RUN echo ${NODE_ENV}
RUN yarn install
CMD ["yarn", "dev"]

# Production image
FROM node:alpine AS production
ENV NODE_ENV=production
WORKDIR /app
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
COPY --from=builder /app/next.config.js ./next.config.js
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/pages ./pages

USER nextjs

# Expose
EXPOSE 3000

# Next.js collects completely anonymous telemetry data about general usage.
# Learn more here: https://nextjs.org/telemetry
# Uncomment the following line in case you want to disable telemetry.
ENV NEXT_TELEMETRY_DISABLED 1
CMD ["yarn", "start"]
