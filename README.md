# SQLite LMS

A comprehensive **Learning Management System (LMS)** database built with SQLite, designed to streamline training and knowledge management at Conpec.

## Overview

This project provides a complete relational database schema for managing educational content, user data, and learning activities. It includes table definitions, data management operations, and query structures to support core LMS functionality.

## Project Structure

- **`db/database-settings/`** - Database initialization and configuration
  - `create-tables.sql` - Table schema definitions
  - `pragma.sql` - SQLite performance and behavior settings
  - `triggers.sql` - Database triggers for data integrity and auto-update

- **`db/inserts/`** - Data insertion scripts
  - `insert.sql` - Initial mock data population

- **`db/updates-and-deletes/`** - Data modification scripts
  - `updates.sql` - Record update operations
  - `deletes.sql` - Data deletion operations

- **`db/views-and-selects/`** - Query and view definitions
  - `views.sql` - Database views for data abstraction
  - `selects.sql` - Query scripts for data retrieval

## Development

This project uses the **SQLite3 Editor** VS Code extension for enhanced database visualization and query execution. Each SQL file includes header comments for extension compatibility and better organization.

## Usage

Execute the SQL files in the following order for proper setup:
1. Run scripts in `database-settings/` to initialize the database
2. Execute `inserts/insert.sql` to populate initial data
3. Use `views-and-selects/` for querying and managing data
4. Apply `updates-and-deletes/` scripts as needed for data modifications