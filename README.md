# Lua 5.1.5.0 Sandbox
Runs Lua scripts under a modified environment that support a few Luau functions which blocks and logs suspicious & malicious functions. This project should not be deemed 100% safe & reliable for it was developed for testing and exemplary purposes.
## Download
- ### [7.6.2022] [Exunys Sandbox V1.0](https://github.com/Exunys/Lua-Sandbox/releases/download/v1/Sandbox.rar)
## Information
You need [Lua 5.1.5.0](https://github.com/Exunys/Lua-5.1) to run the sandbox.
## Preview
![image](https://user-images.githubusercontent.com/76539058/209443815-aa248ed5-1a7e-4833-a45b-c46b70544f2a.png)
```txt

 • Exunys Sandbox (Sandboxed & Logged @12/24/22 17:01:40)

~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~

 [+] (3) [loadstring] called with {
	String = [=[
		local Test = 5
		print("Test", Test)
		return true
	]=],
	Chunk = nil
 }

 [+] (9) [require] called with {
	Module = 123456789
 }

 [+] (10) [require] called with {
	Module = 987654321
 }

 [+] (20) [setmetatable] called with {
	Table = {
		[1] = "Test"
 	},
	Metatable = {
		["__newindex"] = "function: 0000000000B242F0 [undefined / closure (anonymous function)]"
 	}
 }

 [+] (22) [rawset] called with {
	Table = {
		[1] = "Test"
 	},
	Index = 1,
	Value = "Test2"
 }

 [+] (24) [rawget] called with {
	Table = {
		[1] = "Test2"
 	},
	Index = 1
 }

 [+] (28) [collectgarbage] called with {
	Operation = "count",
	Arguments = {
		[1] = "No Arguments..."
 	}
 }

 [+] (32) [math] new index {
	Table = {
		["log"] = "function: 0000000000A5E870 [undefined / closure (anonymous function)]",
		["max"] = "function: 0000000000A5E780 [undefined / closure (anonymous function)]",
		["acos"] = "function: 0000000000A5DA30 [undefined / closure (anonymous function)]",
		["huge"] = 1.#INF,
		["ldexp"] = "function: 0000000000A5E390 [undefined / closure (anonymous function)]",
		["pi"] = 3.1415926535898,
		["cos"] = "function: 0000000000A5E3C0 [undefined / closure (anonymous function)]",
		["tanh"] = "function: 0000000000B20760 [undefined / closure (anonymous function)]",
		["pow"] = "function: 0000000000A5E7E0 [undefined / closure (anonymous function)]",
		["deg"] = "function: 0000000000A5E1B0 [undefined / closure (anonymous function)]",
		["tan"] = "function: 0000000000B20370 [undefined / closure (anonymous function)]",
		["cosh"] = "function: 0000000000A5E480 [undefined / closure (anonymous function)]",
		["sinh"] = "function: 0000000000A5E660 [undefined / closure (anonymous function)]",
		["random"] = "function: 0000000000A5E5D0 [undefined / closure (anonymous function)]",
		["randomseed"] = "function: 0000000000A5E240 [undefined / closure (anonymous function)]",
		["frexp"] = "function: 0000000000A5E6C0 [undefined / closure (anonymous function)]",
		["ceil"] = "function: 0000000000A5E720 [undefined / closure (anonymous function)]",
		["floor"] = "function: 0000000000A5E300 [undefined / closure (anonymous function)]",
		["rad"] = "function: 0000000000A5E4B0 [undefined / closure (anonymous function)]",
		["abs"] = "function: 0000000000A5D6A0 [undefined / closure (anonymous function)]",
		["sqrt"] = "function: 0000000000B202E0 [undefined / closure (anonymous function)]",
		["modf"] = "function: 0000000000A5E5A0 [undefined / closure (anonymous function)]",
		["asin"] = "function: 0000000000A5D550 [undefined / closure (anonymous function)]",
		["min"] = "function: 0000000000A5E7B0 [undefined / closure (anonymous function)]",
		["mod"] = "function: 0000000000A5E810 [undefined / closure (anonymous function)]",
		["fmod"] = "function: 0000000000A5E810 [undefined / closure (anonymous function)]",
		["log10"] = "function: 0000000000A5E6F0 [undefined / closure (anonymous function)]",
		["atan2"] = "function: 0000000000A5D730 [undefined / closure (anonymous function)]",
		["exp"] = "function: 0000000000A5E750 [undefined / closure (anonymous function)]",
		["sin"] = "function: 0000000000B201C0 [undefined / closure (anonymous function)]",
		["atan"] = "function: 0000000000A5E900 [undefined / closure (anonymous function)]"
 	},
	Index = "Test",
	Value = "function: 0000000000B24EF0 [undefined / closure (anonymous function)]"
 }

 [+] (41) Potential crash attempt with [os.date] {
	Format = "%v",
	Time = nil
 }

 [+] (45) [os.execute] called with {
	Command = "echo os.execute check failed"
 }

 [+] (47) Attempted to terminate program with [os.exit] {
	Code = nil
 }

 [+] (49) [os.tmpname] called

 [+] (51) [string.dump] called with {
	Function = "dump"
 }

 [+] (55) [hookfunction] called with {
	Old Function = "hookfunction",
	New Function = "hookfunction"
 }

 [+] (87) new index in the global environment {
	Index = nil,
	Value = "Test"
 }

```
