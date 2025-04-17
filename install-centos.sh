#!/usr/bin/env bash
set -euo pipefail

# Ask which version to install
read -p "Enter PostgreSQL major version to install (e.g. 13, 14, 15): " PGVERSION

# 1. Install the PGDG repository
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-${ARCH:-x86_64}/pgdg-redhat-repo-latest.noarch.rpm

# 2. Disable the built‑in module (CentOS/AlmaLinux 8+)
dnf -qy module disable postgresql

# 3. Install PostgreSQL server and contrib
dnf install -y postgresql${PGVERSION}-server postgresql${PGVERSION}-contrib

# 4. Initialize the database
/usr/pgsql-${PGVERSION}/bin/postgresql-${PGVERSION}-setup initdb

# 5. Enable & start the service
systemctl enable postgresql-${PGVERSION}
systemctl start postgresql-${PGVERSION}

echo "PostgreSQL ${PGVERSION} installed and running."
