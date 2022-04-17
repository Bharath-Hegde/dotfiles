tmux new -s aruco_testing \; \
  send-keys 'rosrun rosserial serial_node.py/dev/ttyACM0' C-m \;\
  split-window -h \; \
  send-keys 'roslaunch usb_cam usb_cam-test.launch' C-m \;\
  split-window -v \; \
  send-keys 'rosrun planner_urc search_tag.py' C-m \;\
  split-window -h \; \
  send-keys 'rosrun planner_urc aurco1.py' C-m \;\
  select-pane -t 1 \; \
  split-window -h \; \
  send-keys 'rosrun planner_urc control_gate.py' C-m \;\
  select-pane -t 0 \; \
  split-window -v \; \
  send-keys 'rosrun planner_urc follow_gate.py' C-m \;\
