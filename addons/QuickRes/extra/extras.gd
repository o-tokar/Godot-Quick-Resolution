class_name Extras
## Safety signal's connection.
static func connect_once(s: Signal, fn: Callable):
	if not s.is_connected(fn):
		s.connect(fn)


static func disconnect_all(s: Signal):
	var connections = s.get_connections()
	for i in range(connections.size()):
		connections[i].signal.disconnect(connections[i].callable)
		# print(c.callable.hash())
