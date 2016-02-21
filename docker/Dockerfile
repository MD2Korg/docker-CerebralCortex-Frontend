# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-full:0.9.18
# Or, instead of the 'full' variant, use one of these:
#FROM phusion/passenger-ruby19:<VERSION>
#FROM phusion/passenger-ruby20:<VERSION>
#FROM phusion/passenger-ruby21:<VERSION>
#FROM phusion/passenger-ruby22:<VERSION>
#FROM phusion/passenger-jruby90:<VERSION>
#FROM phusion/passenger-nodejs:<VERSION>
#FROM phusion/passenger-customizable:<VERSION>

# Set correct environment variables.
ENV HOME /root


# Install bundle of gems
WORKDIR /tmp
ADD cerebralcortex/Gemfile /tmp/
ADD cerebralcortex/Gemfile.lock /tmp/
RUN bundle install


RUN rm -f /etc/service/nginx/down

RUN rm -f /etc/nginx/sites-enabled/default
ADD cerebralcortex.conf /etc/nginx/sites-enabled/cerebralcortex.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf
# RUN mkdir /home/app/cerebralcortex
ADD cerebralcortex /home/app/cerebralcortex
RUN chown app:app -R /home/app/cerebralcortex
# VOLUME ["/home/app/cerebralcortex"]

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# If you're using the 'customizable' variant, you need to explicitly opt-in
# for features. Uncomment the features you want:
#
#   Build system and git.
#RUN /pd_build/utilities.sh
#   Ruby support.
#RUN /pd_build/ruby1.9.sh
#RUN /pd_build/ruby2.0.sh
#RUN /pd_build/ruby2.1.sh
#RUN /pd_build/ruby2.2.sh
#RUN /pd_build/jruby9.0.sh
#   Python support.
# RUN /pd_build/python.sh
#   Node.js and Meteor support.
#RUN /pd_build/nodejs.sh

# ...put your own build instructions here...
# RUN apt-get update \
# && apt-get upgrade -y \
# && apt-get install -y ruby2.3 ruby2.3-dev \
# && ruby-switch --set ruby2.3 \
# && apt-get clean \
# && rm -rf /var/lib/apt/lists/*

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
