# # Base image
# FROM node:20-alpine AS base
# WORKDIR /app

# # Copy package files
# COPY package.json .npmrc .env.production package-lock.json ./

# # Install production dependencies
# FROM base AS prod-deps
# RUN npm install --omit=dev

# # Install all dependencies for building
# FROM base AS build
# COPY . .
# RUN npm install
# RUN npm run build

# # Runtime image
# FROM node:20-alpine AS runtime
# WORKDIR /app

# # Copy production dependencies and build output
# COPY --from=prod-deps /app/node_modules ./node_modules
# COPY --from=build /app/dist ./dist

# # Set environment variables for runtime
# ENV HOST=0.0.0.0
# ENV PORT=4321
# EXPOSE 4321

# # Start the server
# CMD node ./dist/server/entry.mjs

FROM node:20-alpine AS base
WORKDIR /app

# By copying only the package.json and package-lock.json here, we ensure that the following `-deps` steps are independent of the source code.
# Therefore, the `-deps` steps will be skipped if only the source code changes.
COPY package.json ./

FROM base AS prod-deps
RUN npm install --omit=dev

FROM base AS build-deps
RUN npm install

FROM build-deps AS build
COPY . .
RUN npm run build

FROM base AS runtime
COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist

# ENV HOST=0.0.0.0
# ENV PORT=4321
# EXPOSE 4321
# CMD node ./dist/server/entry.mjs

CMD npm run preview
