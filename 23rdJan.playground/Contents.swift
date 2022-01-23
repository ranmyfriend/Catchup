import Foundation

//Concurrency in Swift

//Only 1 will get executed after that qos moved to overcommit state. If you wish to call a sync inside async, create a new dispatch queue and call it inside async

/*
 overcommit" Periodic crashes are occurring in areas where a frequent number of dispatches to the Default QOS queue are occuring. A search about this identifier generally says that there are too many items submitted to this queue and that iOS will not run the method, and that it can lead to a crash.
 */

//https://stackoverflow.com/questions/27948618/consistent-dispatch-queue-com-apple-root-default-qos-overcommit-crash

/*
 once you run too many tasks at the same time in the same queue, then the OS notifies you that it cannot perform all this tasks at the same time in the same priority (there is a limit to the size of the stack for each queue), there for it says "OverCommit", which means you have over committed the queue (in your case the "Default-QOS" queue) and it exits since it cannot receive more tasks at this time and execute them at the fashion you want.
 */

let queue = DispatchQueue(label: "iOS.iOSAcademy.Queue")

queue.async {
    print("1")
    queue.sync {
        print("2")
        queue.async {
            print("3")
        }
    }
}

queue.async {
    print("4")
}

queue.async {
    print("5")
}
