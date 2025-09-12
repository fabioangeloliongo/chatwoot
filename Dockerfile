# Use Ruby 3.4 with Node.js
FROM ruby:3.4-bullseye

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    imagemagick \
    libvips42 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Set working directory
WORKDIR /app

# Copy Gemfile and install Ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install pnpm
RUN npm install -g pnpm

# Copy package.json and install Node dependencies
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# Copy application code
COPY . .

# Precompile assets
RUN RAILS_ENV=production VITE_RUBY_SKIP_COMPATIBILITY_CHECK=1 bundle exec rails assets:precompile

# Expose port
EXPOSE 3000

# Start command
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
