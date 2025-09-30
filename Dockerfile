# Start from official Playwright image (with Node & browsers preinstalled)
FROM mcr.microsoft.com/playwright:v1.53.0-jammy

# Install OpenJDK 11
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    rm -rf /var/lib/apt/lists/* && \
    update-ca-certificates -f

# Set JAVA_HOME environment variable
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-arm64/

# Set PATH to include JAVA_HOME/bin
ENV PATH $JAVA_HOME/bin:$PATH

# Install Allure CLI globally
RUN npm install -g allure-commandline --save-dev

# Ensure Playwright browsers are installed inside the image
RUN npx playwright install --with-deps

# Verify installations (optional)
RUN java -version && node -v && npx playwright --version && allure --version

# Set default working directory
WORKDIR /app

# Keep container alive in CI (GitHub Actions will exec into it)
CMD ["sleep", "infinity"]