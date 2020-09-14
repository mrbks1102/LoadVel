FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
  apt-get update && apt-get install -y google-chrome-stable
RUN mkdir /RoadVel
WORKDIR /RoadVel
COPY Gemfile /RoadVel/Gemfile
COPY Gemfile.lock /RoadVel/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /RoadVel

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
