FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /blog
COPY Gemfile /blog/Gemfile
COPY Gemfile.lock /blog/Gemfile.lock
RUN bundle install
COPY . /blog

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
