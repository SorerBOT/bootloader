# bootloader
This is a Legacy BIOS bootloader. The general goal is to slowly turn this into a self-hosting OS.


## Where are we ATM?

* 32-bit Protected Mode
* Functional textual VGA driver, including a custom printf function

In greater detail, the bootloader already reaches 32-bit Protected Mode, but it does not fully adhere to the MBR standard just yet. My aim is to rush-through stages, such as 16-bit Real Mode, and only return to them once I encounter issues in Protected / Long Modes, this is because its my first bootloader and I feel like this is the most pedagogical approach, at least for me.  
