# docker_meritrank

docker_meritrank is a project that provides a Dockerized environment for building and running the `pg_meritrank` PostgreSQL extension developed in Rust. It simplifies the setup process and allows for easy development and testing of the extension in a containerized environment.

## Features

- Provides a Dockerfile and Docker Compose configuration for building and running the `pg_meritrank` extension.
- Sets up the necessary dependencies, including Rust, PostgreSQL, and the required development libraries.
- Handles the installation and initialization of the `pg_meritrank` extension inside the Docker container.
- Includes a sample script (`first_run.sh`) that automates the setup process and creates the necessary database objects.

## Usage

To get started with docker_meritrank, follow these steps:

1. Clone the repository:

   ```shell
   git clone https://github.com/vsradkevich/docker_meritrank.git
   ```

2. Build the Docker image:

   ```shell
   docker build -t my_pg_meritrank_image .
   ```

3. Run a container:

   ```shell
   docker run -it --name my_pg_meritrank_container my_pg_meritrank_image /bin/bash
   ```

4. Inside the container, navigate to the `/app/pg_meritrank`

## Installation

### Prerequisites

- Docker: [Install Docker](https://docs.docker.com/get-docker/)
- Git: [Install Git](https://git-scm.com/downloads)

### Clone the Repository

```shell
git clone https://github.com/vsradkevich/docker_meritrank.git
```

### Build the Docker Image

```shell
cd docker_meritrank
docker build -t my_pg_meritrank_image .
```

### Memory Requirements for Building the Project

Please note that building the `pg_meritrank` project may require additional memory resources, especially due to the `pgx-pg-sys` dependency. During the build process, this dependency can consume around 7 GB of memory. Therefore, it is recommended to allocate sufficient memory to Docker or adjust the swap file size to accommodate this resource-intensive operation.

In case you encounter any errors during the build process, such as out-of-memory errors or compilation failures related to memory constraints, it is highly likely that the available memory resources are insufficient. In such cases, you may need to increase the memory limit for Docker or adjust the swap file size accordingly.

Once the project is successfully built, you can revert the memory allocation back to its original configuration. It is important to keep this in mind to avoid any performance or resource-related issues during the build process.

Make sure to monitor the build process closely and allocate appropriate memory resources to ensure a smooth and error-free build experience.

Remember, adjusting the memory resources in Docker or the swap file size is crucial when building projects with resource-intensive dependencies like `pgx-pg-sys`.

### Run a Container

```shell
docker run -it --name my_pg_meritrank_container my_pg_meritrank_image /bin/bash

```

### Build and Run the pg_meritrank Extension

Inside the container, navigate to the `/app/pg_meritrank` directory:

```shell
cd /app/pg_meritrank
```

Build and run the pg_meritrank extension:

```shell
cargo build
cargo pgx test
cargo pgx install
```

## Usage

Once the extension is installed, you can use the pg_meritrank functions in your PostgreSQL database. For example:

```sql
-- Enable the pg_meritrank extension in your database
CREATE EXTENSION IF NOT EXISTS pg_meritrank;

-- Use MeritRank
```

For more information on the available functions and usage, please refer to the project documentation.

## Contributing

Contributions are welcome! If you have any bug reports, feature requests, or would like to contribute code, please open an issue or submit a pull 
request on the project repository.

## License

This project is licensed under the [MIT License](https://github.com/vsradkevich/docker_meritrank/blob/main/LICENSE).

## License

`pg_meritrank` is actively maintained by [Vladimir Radkevich](https://github.com/vsradkevich). Feel free to reach out if you have any questions or need assistance.

Enjoy using `pg_meritrank` for calculating and ranking merits in your PostgreSQL database!