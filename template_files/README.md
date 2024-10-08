# $Project

**Attention**: The code in this repository is not fully tested, documented, or supported by SingleStore. Visit the [SingleStore Forums](https://www.singlestore.com/forum/) to ask questions about this repository.

## Introduction

This repository is intended to get you started quickly on building a new extension for SingleStoreDB.

## Contents
Currently, this extension provides the following <UDFs/UDAFs/TVFs>:

### `UDF-1`
UDF-1 Description. More Details to be found in [Create WASM UDFs](https://docs.singlestore.com/cloud/reference/code-engine-powered-by-wasm/create-wasm-udfs/).

### `UDAF-1`
UDAF-1 Description. More Details to be found in [Create WASM UDAFs](https://docs.singlestore.com/cloud/reference/sql-reference/procedural-sql-reference/create-aggregate/#wasm-based-udafs).

### `TVF-1`
TVF-1 Description. More Details to be found in [Create WASM TVFs](https://docs.singlestore.com/cloud/reference/code-engine-powered-by-wasm/create-wasm-tvfs/).

## Deployment to SingleStoreDB

### Using HTTP Link (recommended)
* The SingleStore Cluster has to be able to connect to this repository
There should already be a pre-built `.tar` file in the root directory of this repository called `extension.tar`.  If there is not, or you need to re-package it, please consult the [packaging](#packaging) steps below.

```sql
CREATE EXTENSION dynamojson FROM HTTP 'https://github.com/singlestore-extensions/singlestore-extension-template/-/raw/main/extension.tar';
```
* Verify the Extension `SHOW EXTENSIONS;`
* Verify the Functions `SHOW FUNCTIONS;`

### Using a Client
There should already be a pre-built Wasm file in the root directory of this
repository, called `extension.wasm`.  If there is not, or you need to rebuild
it, please consult the [build](#building) steps below.

To install these functions using the SingleStore/MySQL client, use the following commands.
They assume you have built the Wasm module and your current directory is the
root of this repository.  Please be sure to replace `$DBUSER`, `$DBHOST`,
`$DBPORT`, and `$DBNAME` with, respectively, your database username, hostname,
port, and the name of the database where you want to deploy the functions.
The `-p` option will prompt you for a password.

```bash
singlestore -u $DBUSER -h $DBHOST -P $DBPORT -D $DBNAME -p < load_extension.sql
```

```bash
mysql -u $DBUSER -h $DBHOST -P $DBPORT -D $DBNAME -p < load_extension.sql
```

## Usage Example

This template prints a simple hello world as a UDF.
```sql
select hello();
```
And here is the result:
```console
+-----------+
| hello     |
+-----------+
| world     |
+-----------+
1 row in set (0.04 sec)
```

## Building

### Compilation

To build this project, you will need to ensure that you have the
[WASI SDK](https://github.com/WebAssembly/wasi-sdk/releases) installed.  Please
set the environment variable `WASI_SDK_PATH` to its top-level directory.

If you change the `extension.wit` file, you will need to regenerate the ABI
wrappers.  To do this, make sure you have the wit-bindgen program installed. 
Currently, SingleStoreDB only supports code generated using 
[wit-bindgen v0.2.0](https://github.com/bytecodealliance/wit-bindgen/releases/tag/v0.2.0).

To compile:
```
make release
```

### Cleaning

To remove just the Wasm file:
```
make clean
```

To remove all generated files:
```
make distclean
```

## Packaging
