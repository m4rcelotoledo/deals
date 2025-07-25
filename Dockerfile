# TO USE: skygvinn/alpine3.14-ruby3.4-node20-yarn1.22:v1.0

FROM ruby:3.4.4-alpine3

LABEL name="Alpine3.14-Ruby-3.4-Node20-Yarn1.22" \
      version="1.0" \
      author="Marcelo Toledo, aka Skygvinn"

RUN apk add --update --no-cache \
    bash \
    build-base \
    coreutils \
    git \
    nodejs \
    npm \
    postgresql-dev \
    tzdata \
    yarn \
    zsh && \
    gem update --system && \
    gem install bundler && \
    gem cleanup

RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN echo "HISTSIZE=5000" >> ~/.zshrc
RUN echo "HISTFILESIZE=5000" >> ~/.zshrc
RUN echo "alias reload='source ~/.zshrc'" >> ~/.zshrc
RUN echo "alias rails='bundle exec rails'" >> ~/.zshrc
RUN echo "alias vim='vi'" >> ~/.zshrc
RUN echo "/bin/zsh" >> ~/.zshrc

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
