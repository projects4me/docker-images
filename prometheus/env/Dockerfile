FROM danlynn/ember-cli:4.1.1-node_16.13

WORKDIR /prometheus

# Update package list and install Apache2
RUN apt-get update \
    && apt-get install -y apache2 \
    && rm -rf /var/lib/apt/lists/*

# Expose port 80 (default port for Apache)
EXPOSE 80

# Install bower
RUN npm install bower

# Create virtual host for ember.js dist
COPY ./apache.conf /etc/apache2/sites-available/

RUN echo "Listen 4000" >> /etc/apache2/ports.conf \
    && cd /etc/apache2/sites-available \
    && a2ensite apache.conf \
    && a2enmod rewrite

# Restart apache
RUN service apache2 restart

# Start Apache2 in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]