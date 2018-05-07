Demonstrates infinite blocking behavior with `Zlib::Reader#gets_to_end`.

## `hexdump -C data.bin`

```
00000000  78 9c 34 c9 d1 0a 40 40  10 05 d0 7f b9 cf bb 65  |x.4...@@.......e|
00000010  45 6a 7e 45 d2 60 42 ad  a5 35 48 9b 7f e7 c5 db  |Ej~E.`B..5H.....|
00000020  a9 93 a0 a0 70 78 6f b0  ff 58 37 90 cb 0c 06 50  |....pxo..X7....P|
00000030  c2 24 1c b5 13 d6 76 0e  2a f1 64 0f 2a 5c 5e 7e  |.$....v.*.d.*\^~|
00000040  df 6a e4 5e 40 35 46 56  b9 f8 b6 5b 1c ec c2 73  |.j.^@5FV...[...s|
00000050  b0 99 d3 0a cd f3 bc 00  00 00 ff ff              |............|
0000005c
```

## lldb thread backtrace

```
(lldb) run
Process 15924 launched: '/home/lune/git/zlib-freeze/run' (x86_64)
Process 15924 stopped
* thread #1, name = 'run', stop reason = signal SIGSTOP
    frame #0: 0x00007ffff74d7988 libpthread.so.0`__libc_read + 72
libpthread.so.0`__libc_read:
->  0x7ffff74d7988 <+72>: cmpq   $-0x1000, %rax            ; imm = 0xF000
    0x7ffff74d798e <+78>: ja     0x7ffff74d79c4            ; <+132>
    0x7ffff74d7990 <+80>: movl   %r8d, %edi
    0x7ffff74d7993 <+83>: movq   %rax, 0x8(%rsp)
(lldb) thread backtrace
* thread #1, name = 'run', stop reason = signal SIGSTOP
  * frame #0: 0x00007ffff74d7988 libpthread.so.0`__libc_read + 72
    frame #1: 0x00005555555ad242 run`*IO::FileDescriptor+@IO::FileDescriptor#unbuffered_read<Slice(UInt8)>:Int32 at file_descriptor.cr:183
    frame #2: 0x00005555555ad8dc run`*IO::FileDescriptor+@IO::Buffered#fill_buffer:Slice(UInt8) at buffered.cr:206
    frame #3: 0x00005555555ae781 run`*IO::FileDescriptor+@IO::Buffered#peek:Slice(UInt8) at buffered.cr:81
    frame #4: 0x00005555555d7e8c run`*Flate::Reader#read<Slice(UInt8)>:Int32 at reader.cr:66
    frame #5: 0x00005555555d70a8 run`*Zlib::Reader#read<Slice(UInt8)>:Int32 at reader.cr:65
    frame #6: 0x00005555555d6eef run`*Zlib::Reader@IO#gets_to_end:String at io.cr:560
    frame #7: 0x0000555555580b5d run`__crystal_main at run.cr:4
    frame #8: 0x000055555558dbe6 run`*_crystal_main<Int32, Pointer(Pointer(UInt8))>:Nil at main.cr:11
    frame #9: 0x00005555555e1b96 run`*Crystal::main_user_code<Int32, Pointer(Pointer(UInt8))>:Nil at main.cr:112
    frame #10: 0x00005555555e1a52 run`*Crystal::main<Int32, Pointer(Pointer(UInt8))>:Int32 at main.cr:101
    frame #11: 0x000055555558bb16 run`main at main.cr:135
    frame #12: 0x00007ffff68b7f4a libc.so.6`__libc_start_main + 234
    frame #13: 0x000055555558039a run`_start + 42
```
