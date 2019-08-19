FROM node:lts-slim

# Install native dependencies for puppeteer
RUN apt-get update && \
    apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
    libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
    libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
    libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
    fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont \
    ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget && \
    wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb && \
    dpkg -i dumb-init_*.deb && rm -f dumb-init_*.deb && \
    apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Install native dependencies for K8s plugins
# Install kubectl, kubeadm and helm
ENV KUBERNETES_VERSION="1.15.0"
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl
RUN curl -L https://git.io/get_helm.sh | bash

COPY package.json .
COPY install.js .

RUN node install.js

# Install puppeteer so it's available in the container.
RUN groupadd -r user && useradd -r -g user -G audio,video user \
    && mkdir -p /home/user/Downloads \
    && chown -R user:user /home/user    

# Run everything after as non-privileged user.
USER user

# Verify installation of K8s CLI tools
RUN kubectl version --client
RUN helm version -c

ENTRYPOINT ["dumb-init", "--"]