tmux new -s rover_testing \; \
  send-keys 'rosrun rosserial serial_node.py/dev/ttyACM0' C-m \;\
  split-window -h \; \
  send-keys 'rosrun planner_urc root_controller.py' C-m \;\
  split-window -v \; \
  send-keys 'rosrun planner_urc temp_planner.py' C-m \;\
  split-window -h \; \
  send-keys 'rosrun planner urc aurco.py' C-m \;\
  select-pane -t 1 \; \
  split-window -h \; \
  send-keys 'rostopic echo /rover' C-m \;\
  select-pane -t 0 \; \
  split-window -v \; \
  send-keys 'rosrun planner_urc follow_gate.py' C-m \;\
  split-window -h \; \
  send-keys 'rosrun planner_urc follow_tag.py' C-m \;\
  select-pane -t 0 \; \
  split-window -h \; \
  send-keys 'rosrun planner_urc search_tag.py' C-m \;\
  neww\;\
  send-keys 'rosserial perm' C-m \;\
  split-window -h \; \
  send-keys 'rosservice call /zed2i/zed_node/set_pose 0 0 0 0 0 0' C-m \;\
  split-window -v \; \
  send-keys 'rosrun pointcloud_to_laserscan pointcloud_to_laserscan_node' C-m \;\
  select-pane -t 0 \; \
  split-window -v \; \
  send-keys 'roslaunch zed_wrapper zed2i.launch' C-m \;\
