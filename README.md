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

#### simple-pull

Simple pull moves data from a MySQL table to HDFS.  Use the `sqoop/simple-pull/simple-pull-sqoop.sh` scropt to run the job.
The data is written out to `/user/cloudera/simple_pull`.

###### Customer

|Column Name       |Data Type    |Size |
|------------------|-------------|:---:|
|id                |INT          |     |
|first_name        |varchar      |45   |
|last_name         |varchar      |45   |
|street_address_1  |varchar      |45   |
|street_address_2  |varchar      |45   |
|city              |varchar      |45   |
|state             |varchar      |2    |
|aip               |varchar      |8    |

The table and schema are created using `/simple_pull/simple_pull.sql`.