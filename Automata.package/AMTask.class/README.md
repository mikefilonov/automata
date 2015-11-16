I'm an abstract RSTask which implements basic contiuation start/stop routinres. Most of methods should be called by RSExectionLoop in continuation call style.

Tied to a RSTaskManager instances through manager instance variable. Uses #addPendingTask:  withState:  withCondition:  of manager as a callback to notify manager before sleep.