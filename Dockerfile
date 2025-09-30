# Base Playwright image (Ubuntu 22.04 Jammy, v1.55.0)
FROM mcr.microsoft.com/playwright:v1.55.0-jammy

# Install Java 17 JDK
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    rm -rf /var/lib/apt/lists/*

# Dynamically resolve JAVA_HOME and persist it for all shells
RUN export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java)))) && \
    echo "export JAVA_HOME=$JAVA_HOME" >> /etc/profile && \
    echo "export PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile && \
    echo "JAVA_HOME=$JAVA_HOME" >> /etc/environment

# Install Allure CLI globally
RUN npm install -g allure-commandline

# Verify installations (optional, safe to remove in prod to keep image smaller)
RUN bash -lc "java -version && node -v && npx playwright --version && allure --version"

# Set workdir
WORKDIR /app

# Keep container alive in CI/CD (overridden by CMD in pipeline/test run)
CMD ["sleep", "infinity"]