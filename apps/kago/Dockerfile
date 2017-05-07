FROM elixir:1.4.2-slim

ARG env=dev

ADD . /app
WORKDIR /app

ENV MIX_ENV=${env} PORT=4000
EXPOSE 4000

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix compile

CMD ["mix", "phx.server"]
