ARG RUBY_VERSION=3.2.2

FROM ruby:$RUBY_VERSION-slim

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libvips gnupg2 curl git

# Ensure node.js 20 is available for apt-get
ARG NODE_MAJOR=20
RUN apt-get update && \
    mkdir -p /etc/apt/keyrings && \
    curl --fail --silent --show-error --location https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

# Install node and yarn
RUN apt-get update -qq && apt-get install -y nodejs && npm install -g yarn

# Mount $PWD to this workdir
WORKDIR /rails

# Ensure gems are installed on a persistent volume and available as bins
VOLUME /bundle
RUN bundle config set --global path '/bundle'
ENV PATH="/bundle/ruby/$RUBY_VERSION/bin:${PATH}"

# install libpq-dev for PGSQL
RUN apt update -qq && apt install -y libpq-dev
RUN gem update --system && gem install foreman

# Install Rails
RUN gem install rails

# Ensure binding is always 0.0.0.0, even in development, to access server from outside container
ENV BINDING="0.0.0.0"

# Overwrite ruby image's entrypoint to provide open cli
ENTRYPOINT [""]
