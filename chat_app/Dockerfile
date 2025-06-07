FROM elixir:1.15-alpine

RUN apk add --no-cache \
    build-base \
    npm \
    git \
    python3 \
    inotify-tools \
    postgresql-client \
    bash

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./

RUN mix deps.get

COPY . .

RUN mix deps.compile

RUN if [ -f "assets/package.json" ]; then \
        cd assets && npm install; \
    else \
        echo "No assets/package.json found, skipping npm install"; \
    fi

WORKDIR /app

EXPOSE 4000

ENV MIX_ENV=dev

CMD ["mix", "phx.server"]