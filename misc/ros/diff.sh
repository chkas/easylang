ls [1-9A-Z]*| while read n; do basename $n .el ; done | tr "_" " " | sort > /tmp/ros_files.txt
./tasks.py | tr / + |  sort > /tmp/ros_tasks.txt 
diff /tmp/ros_*

