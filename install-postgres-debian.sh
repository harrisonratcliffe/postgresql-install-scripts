#!/usr/bin/env bash
set -euo pipefail

# Prompt for version
read -p "Enter PostgreSQL major version to install (e.g. 12, 13, 14): " PGVERSION

# Install prerequisites
apt-get update
apt-get install -y wget gnupg2 lsb-release ca-certificates

# Add the PostgreSQL APT repository
echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
  > /etc/apt/sources.list.d/pgdg.list
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc \
  | apt-key add -

# Install PostgreSQL
apt-get update
apt-get install -y postgresql-${PGVERSION} postgresql-client-${PGVERSION}

# Enable & start
systemctl enable postgresql
systemctl start postgresql

echo "PostgreSQL ${PGVERSION} installed and running."
