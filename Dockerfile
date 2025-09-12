# Use Ruby 3.1 with Node.js
FROM ruby:3.1-bullseye

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    yarn \
    imagemagick \
    libvips42 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gemfile and install Ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy package.json and install Node dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy application code
COPY . .

# Precompile assets
RUN RAILS_ENV=production bundle exec rails assets:precompile

# Expose port
EXPOSE 3000

# Start command
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
