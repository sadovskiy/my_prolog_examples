/******************************************************************************

	Demonstration of storege/11

  Storage/11 gives portable full information of the memory state


 อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
  Date Modified,บ By,  บ  Comments.
 อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
                บ      บ
******************************************************************************/

GOAL
	storage(UsedStack,FreeStack,
	UsedGStack,FreeGStack,
	UsedHeap,FreeHeap,NoOfHeapFreeSpaces,
	UsedTrail,AllocatedTrail,
	SystemFreeMem,NoOfBPoints),

	writef("UsedStack=%,FreeStack=%,\nUsedGStack=%,FreeGStack=%,\nUsedHeap=%,FreeHeap=%,NoOfHeapFreeSpaces=%,\nUsedTrail=%,AllocatedTrail=%,\nSystemFreeMem=%,\nNoOfBPoints=%\n",
	UsedStack,FreeStack,
	UsedGStack,FreeGStack,
	UsedHeap,FreeHeap,NoOfHeapFreeSpaces,
	UsedTrail,AllocatedTrail,
	SystemFreeMem,NoOfBPoints),

	nl,nl,nl,
	storage.
