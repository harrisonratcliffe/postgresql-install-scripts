# PostgreSQL Installation and Setup on CentOS/AlmaLinux

This repository contains:

- **install-pg.sh**: A Bash script that installs PostgreSQL (prompting for the desired major version), initializes the database, and starts the service.
- **README.md**: Basic usage instructions for installing PostgreSQL, creating a database and user, granting permissions, and allowing remote access.

---

## Prerequisites

- A server running CentOS 8 / AlmaLinux 8 (or compatible EL‑8 distribution).
- Root or sudo privileges.
- Internet access to download the PostgreSQL repository package.

---

## Installation

1. Make the install script executable:
   ```bash
   chmod +x install-centos.sh
   ```
2. Run the script as root (it will prompt for the PostgreSQL major version, e.g. 13, 14, 15, etc.):
   ```bash
   sudo ./install-pg.sh
   ```
3. The script will:
   - Install the PGDG repository.
   - Disable the built‑in PostgreSQL module.
   - Install `postgresql<version>-server` and `postgresql<version>-contrib`.
   - Initialize the database cluster.
   - Enable and start the PostgreSQL service.

---

## Creating a User and Database

Switch to the `postgres` user and run the following commands (replace `myapp_user`, `StrongPasswordHere`, and `myapp_db` with your own values):

```bash
sudo su - postgres
psql -c "CREATE USER myapp_user WITH PASSWORD 'StrongPasswordHere';"
psql -c "CREATE DATABASE myapp_db OWNER myapp_user;"
# (If needed) Grant all privileges:
psql -c "GRANT ALL PRIVILEGES ON DATABASE myapp_db TO myapp_user;"
exit
```

---

## Allowing Remote Access

1. **Edit `postgresql.conf`** (usually in `/var/lib/pgsql/<version>/data/`):
   ```conf
   listen_addresses = '*'
   ```
2. **Edit `pg_hba.conf`** and add a line to allow your client IP (e.g. `203.0.113.45`):
   ```conf
   host    myapp_db    myapp_user    203.0.113.45/32    md5
   ```
3. Reload or restart PostgreSQL:
   ```bash
   sudo systemctl reload postgresql-<version>
   # or
   sudo systemctl restart postgresql-<version>
   ```

You can now connect remotely:

```bash
psql -h <server_ip> -U myapp_user -d myapp_db
```

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
