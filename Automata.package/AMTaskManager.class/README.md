I'm an abstact RSTaskManager  class for managing pending tasks and resuming them.

My responsibilities are:
- define "condition" interface;
- manage a list of Tasks;
- event management;
- resuming pending task.

I include execution loop object (RSExecutionLoop) which is responsible to execute and resume continuations of Tasks.

For a customg event management subclass me and reimplement #addPendingTask:withState:withCondition:
which is a callback used in Task to save it's state before serialization of it's state.