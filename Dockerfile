# Start from official Playwright image
FROM mcr.microsoft.com/playwright:v1.53.0-jammy

# Install OpenJDK (example: Java 17)
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:${PATH}"

# Verify installations (optional)
RUN java -version && node -v && npx playwright --version

# Set default working directory
WORKDIR /app

# Copy project files if you want to package code into the image
# COPY . .

# Default command
CMD ["bash"]