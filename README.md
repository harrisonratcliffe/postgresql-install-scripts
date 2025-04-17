# PostgreSQL Linux Installation Scripts

This repository contains:

- **install-pg-centos.sh**: A Bash script for CentOS/AlmaLinux 8 (EL8) that installs PostgreSQL, initializes the database cluster, and starts the service.
- **install-pg-ubuntu.sh**: A Bash script for Debian/Ubuntu that installs PostgreSQL, initializes the database cluster, and starts the service.
- **README.md**: This documentation file.

---

## Prerequisites

- A server running one of:
  - CentOS 8 / AlmaLinux 8 (or compatible EL‑8 distribution).
  - Ubuntu 18.04+ or Debian 9+.
- Root or sudo privileges.
- Internet access to download PostgreSQL repository packages.

---

## Installation

### CentOS/AlmaLinux

1. Make the CentOS install script executable:
   ```bash
   chmod +x install-pg-centos.sh
   ```
2. Run the script as root (it will prompt for PostgreSQL major version, e.g., 13, 14, 15):
   ```bash
   sudo ./install-pg-centos.sh
   ```

The `install-pg-centos.sh` script performs:

- Adds the PGDG YUM repository.
- Disables the built-in PostgreSQL module.
- Installs `postgresql<version>-server` and `postgresql<version>-contrib`.
- Initializes the database cluster.
- Enables and starts the PostgreSQL service.

### Debian/Ubuntu

1. Make the Debian/Ubuntu install script executable:
   ```bash
   chmod +x install-pg-debian.sh
   ```
2. Run the script as root (it will prompt for PostgreSQL major version, e.g., 13, 14, 15):
   ```bash
   sudo ./install-pg-debian.sh
   ```

The `install-pg-debian.sh` script performs:

- Adds the PGDG APT repository.
- Updates the package list.
- Installs `postgresql-<version>` and `postgresql-contrib`.
- Enables and starts the PostgreSQL service.

---

## Creating a User and Database

Switch to the `postgres` system user and run:

```bash
sudo su - postgres
psql -c "CREATE USER myapp_user WITH PASSWORD 'StrongPasswordHere';"
psql -c "CREATE DATABASE myapp_db OWNER myapp_user;"
# (If needed) Grant privileges:
psql -c "GRANT ALL PRIVILEGES ON DATABASE myapp_db TO myapp_user;"
exit
```

Replace `myapp_user`, `StrongPasswordHere`, and `myapp_db` with your own values.

---

## Allowing Remote Access

1. Edit `postgresql.conf` (usually in `/var/lib/pgsql/<version>/data/` on CentOS or `/etc/postgresql/<version>/main/` on Debian/Ubuntu):
   ```conf
   listen_addresses = '*'
   ```
2. Edit `pg_hba.conf` and append a line for your client IP (e.g., `203.0.113.45`):
   ```conf
   host    myapp_db    myapp_user    203.0.113.45/32    md5
   ```
3. Reload or restart PostgreSQL:
   ```bash
   sudo systemctl reload postgresql-<version>
   # or restart:
   sudo systemctl restart postgresql-<version>
   ```

You can now connect remotely:

```bash
psql -h <server_ip> -U myapp_user -d myapp_db
```

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
