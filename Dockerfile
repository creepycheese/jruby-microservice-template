FROM jruby:9.1.9.0
MAINTAINER Evgeniy Burdaev inqify@gmail.com

RUN apt-get update && apt-get install -y tar curl openssh-client libxml2-dev libxslt-dev libpq-dev \
 postgresql-client postgresql-contrib postgresql git \
 && apt-get autoremove -y && apt-get clean

ADD . /app
WORKDIR /app
CMD chmod +x entrypoint.sh

RUN echo gem: --no-document >> /etc/gemrc

RUN gem update --system
RUN gem install bundler
RUN bundle install

CMD ./entrypoint.sh
