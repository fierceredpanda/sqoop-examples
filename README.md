# sqoop-examples

### Environment
---

##### MySQL

I set up this test using [MySQL 5.7.13](http://dev.mysql.com/downloads/) along with [MySQL Workbench 6.3.7](http://dev.mysql.com/downloads/workbench/). I am using the `sqoop` user with `dude001` as the password.

##### Cloudera

For the Hadoop environment I am using [Cloudera Quick Start](http://www.cloudera.com/downloads/quickstart_vms/5-7.html) for CDH 5.7.
I used [VirtualBox 5.1.2](https://www.virtualbox.org/wiki/Downloads) to manage the VM.

To create a shared folder to the VM follow these instructions:

1. Within VirtualBox, go to: Machine > Settings > Shared Folders
2. For “Folder Path”, click the icon to browse for the folder you want to share.
3. For “Folder Name”, enter a name to describe the share.
4. Create an empty folder on the VM to use as the mount.
5. Run the following command to mount the share to the folder you created: `sudo mount -t vboxsf folder_name <path_to_mount_point> <folder_name>`

Instructions pulled from [here](http://stackoverflow.com/questions/23514244/share-folders-from-the-host-mac-os-to-a-guest-linux-system-in-virtualbox).

### Sqoop Jobs
---

#### simple-import

Simple import moves data from a MySQL table to HDFS.  Use the `sqoop/simple-import/simple-import.sh` scropt to run the job. The data is written out to `/user/cloudera/simple_import`.

###### Customer

|Column Name       |Data Type    |Size |
|------------------|-------------|:---:|
|id                |integer      |     |
|first_name        |varchar      |45   |
|last_name         |varchar      |45   |
|street_address_1  |varchar      |45   |
|street_address_2  |varchar      |45   |
|city              |varchar      |45   |
|state             |varchar      |2    |
|zip               |varchar      |8    |

The table and schema are created using `/simple_import/simple_import.sql`.

#### simple-export

Simple import moves data from HDFS back to MySQL.  It should be run after the `simple-import` as it moves the data back from HDFS to a similar table.  Use `sqoop/simple-export/simple-export.sh` to execute the job.  You can use the DataLoader (mentioned below) to load more data.

###### Customer-Export

|Column Name       |Data Type    |Size |
|------------------|-------------|:---:|
|id                |integer      |     |
|first_name        |varchar      |45   |
|last_name         |varchar      |45   |
|street_address_1  |varchar      |45   |
|street_address_2  |varchar      |45   |
|city              |varchar      |45   |
|state             |varchar      |2    |
|zip               |varchar      |8    |

The table and schema are created using `/simple_export/simple_export.sql`.

#### incremental pulls
---

##### DataLoader

Dataloader is a useful utility that can be used to populate fake data into a table. Take a look at [database-tools](https://github.com/fierceredpanda/database-tools).

##### append

The append pull creates a Sqoop job that pulls from the `log_records` table based off of the id.  Create the table by running the `sqoop/incremental-pull/append.sql`' file. Use the `sqoop/incremental-pull/append.sh` script to run the job.

Additional executions of the job can be executed with `sqoop job --exec append-job`. The job can be removed with `sqoop job --delete append-job`.

###### Log Records

|Column Name       |Data Type    |Size |
|------------------|-------------|:---:|
|id                |integer      |     |
|system            |varchar      |45   |
|log_detail        |varchar      |45   |
|create_date       |timestamp    |     |

##### lastmodified

The last modified pull creates a Sqoop job that pulls from the `movie-reviews` table based off of the last modified date.  Before running the job use the `sqoop/incremental-pull/lastmodified.sql` script to create and populate the table. Use the `sqoop/incramental-pull/lastmodified.sh` script to run the job.

Additional executions of the job can be executed with `sqoop job --exec lastmodified-job`.  Use the `sqoop/incremental-pull/lastmodified-update.sh` script to update some of the pre-existing rows between each run. The job can be removed with `sqoop job --delete lastmodified-job`. 

###### Movie Reviews

|Column Name       |Data Type    |Size |
|------------------|-------------|:---:|
|name              |varchar      |45   |
|rotten_tomatoes   |int          |     |
|create_date       |timestamp    |     |
|modify_date       |timestamp    |     |
