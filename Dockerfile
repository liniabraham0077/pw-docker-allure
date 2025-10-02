FROM registry.access.redhat.com/ubi9/ubi:latest

# Install Java 21, Node.js 20, and Playwright dependencies
RUN dnf -y update && \
    dnf -y module enable nodejs:20 && \
    dnf -y install java-21-openjdk java-21-openjdk-devel nodejs npm git wget unzip \
       libXcomposite libXcursor libXdamage libXext libXi libXtst cups-libs libXScrnSaver \
       libXrandr alsa-lib atk at-spi2-atk pango gtk3 \
       libdrm libgbm libxshmfence mesa-libgbm && \
    dnf clean all

# Set Java environment
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install Playwright and Browsers
RUN npm install -g playwright && \
    npx playwright install chromium firefox webkit

# Install Allure commandline
RUN npm install -g allure-commandline --save-dev

# Set working directory
WORKDIR /app

# Create a script to print versions of tools
RUN echo '#!/bin/bash' > /usr/local/bin/print-versions && \
    echo 'echo "Java: $(java -version 2>&1 | head -n1)"' >> /usr/local/bin/print-versions && \
    echo 'echo "Node: $(node -v)"' >> /usr/local/bin/print-versions && \
    echo 'echo "NPM: $(npm -v)"' >> /usr/local/bin/print-versions && \
    echo 'echo "Playwright: $(playwright --version)"' >> /usr/local/bin/print-versions && \
    echo 'echo "Allure: $(allure --version)"' >> /usr/local/bin/print-versions && \
    chmod +x /usr/local/bin/print-versions

# Default CMD keeps container alive
CMD ["sleep", "infinity"]