os.execute("cls")

local select = select
local rawset, getfenv, setfenv, tostring, loadstring, assert, ioopen, ioread, iowrite, debuggetinfo, setmetatable, stringrep, osdate, ostime, next, pairs, stringfind, stringgsub, stringsub, stringlower, stringmatch = select(1, rawset, getfenv, setfenv, tostring, loadstring or load, assert, io.open, io.read, io.write, debug.getinfo, setmetatable, string.rep, os.date, os.time, next, pairs, string.find, string.gsub, string.sub, string.lower, string.match)
local LogProcess, AutoSubstituteSuspiciousLoops, WaitDurationMax = select(1, unpack(require(".\\Resources\\Config")))
local Environment = getfenv()

local LogFileName = "Log_"..tostring(ostime())..".txt"
local LogFile = (LogProcess and ioopen(".\\Logs\\"..LogFileName, "a+"))

if LogProcess then
	LogFile:write("\n • Exunys Sandbox (Sandboxed & Logged @"..osdate()..")\n\n"..stringrep("~=", 50).."~\n")
end

local function SetType(Value)
	if getfenv()[tostring(Value)] then
		return Value
	elseif type(Value) == "string" or type(Value) == "table" then
		if stringfind(tostring(Value), "\"") or stringfind(tostring(Value), "'") then
			return "[=[\n\t\t"..tostring(stringgsub(Value, "\n", "\n\t\t")).."\n\t]=]"
		else
			return "\""..tostring(Value).."\""
		end
	elseif type(Value) == "function" then
		return "\""..(debuggetinfo(2, "n").name and debuggetinfo(2, "n").name.."\"" or tostring(Value).." [undefined / closure (anonymous function)]\"")
	else
		return tostring(Value)
	end
end

local function GetArrayLength(Table)
	local Length = 0

	for _, _ in pairs(Table) do
		Length = Length + 1
	end

	return Length
end

local function DumpTable(Table)
	local Result, Key = "", 0

	table.foreach(Table, function(Index, Value)
		Key = Key + 1; Result = Result.."\t\t["..SetType(Index).."] = "..SetType(Value)..(Key ~= GetArrayLength(Table) and ",\n" or "\n")
	end)

	return Result
end

local function Log(Data)
	if LogProcess then
		LogFile:write(Data)
	end
end

--// Sandboxed Environment

Environment.collectgarbage = function(Operation, ...)
	local Arguments = ((...) ~= nil and {...}) or {"No Arguments..."}
	Log("\n [+] ("..debuggetinfo(2).currentline..") [collectgarbage] called with {\n\tOperation = "..SetType(Operation)..",\n\tArguments = {\n"..DumpTable(Arguments).." \t}\n }\n")

	if stringlower(Operation) == "count" then
        return (math.random(150000, 250000) / 10000)
    end
end

Environment.dofile = function(File)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [dofile] called with {\n\tFile = "..SetType(File).."\n }\n")
end

Environment.loadfile = function(File)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [loadfile] called with {\n\tFile = "..SetType(File).."\n }\n")
end

Environment.load = function(File, Chunk)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [load] called with {\n\tFile = "..SetType(File)..",\n\tChunk = "..SetType(Chunk).."\n }\n")
end

Environment.loadstring = function(String, Chunk)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [loadstring] called with {\n\tString = "..SetType(String)..",\n\tChunk = "..SetType(Chunk).."\n }\n")
	return function() end
end

Environment.require = function(Module)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [require] called with {\n\tModule = "..SetType(Module).."\n }\n")
end

Environment.rawequal = function(V1, V2)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [rawequal] called with {\n\tV1 = "..SetType(V1)..",\n\tV2 = "..SetType(V2).."\n }\n")
	return V1 == V2
end

Environment.rawset = function(Table, Index, Value)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [rawset] called with {\n\tTable = {\n"..DumpTable(Table).." \t},\n\tIndex = "..SetType(Index)..",\n\tValue = "..SetType(Value).."\n }\n")
	Table[Index] = Value
	return Table
end

Environment.rawget = function(Table, Index)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [rawget] called with {\n\tTable = {\n"..DumpTable(Table).." \t},\n\tIndex = "..SetType(Index).."\n }\n")
	return Table[Index]
end

Environment.setmetatable = function(Table, Metatable)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [setmetatable] called with {\n\tTable = {\n"..DumpTable(Table).." \t},\n\tMetatable = {\n"..DumpTable(Metatable).." \t}\n }\n")
	return Table
end

Environment.getmetatable = function(Object)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [getmetatable] called with {\n\tObject = "..SetType(Object).."\n }\n")
	return Object
end

Environment.getfenv = function(Stack)
	if Stack then
		Log("\n [+] ("..debuggetinfo(2).currentline..") [getfenv] called with {\n\tStack = "..SetType(Stack).."\n }\n")
	else
		return Environment
	end
end

Environment.setfenv = function(Stack, Environment)
	Environment = Environment or {"No Environment..."}
	Log("\n [+] ("..debuggetinfo(2).currentline..") [setfenv] called with {\n\tStack = "..SetType(Stack)..",\n\tEnvironment = {\n"..DumpTable(Environment).." \t}\n }")
	return setfenv(Environment, {})
end

setmetatable(Environment.coroutine, {__newindex = function(Table, Index, Value)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [coroutine] new index {\n\tTable = {\n"..DumpTable(Table).." \t},\n\tIndex = "..SetType(Index)..",\n\tValue = "..SetType(Value).."\n }\n")
	return Table
end})

setmetatable(Environment.package, {__newindex = function(Table, Index, Value)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [package] new index {\n\tTable = {\n"..DumpTable(Table).." \t},\n\tIndex = "..SetType(Index)..",\n\tValue = "..SetType(Value).."\n }\n")
	return Table
end})

setmetatable(Environment.string, {__newindex = function(Table, Index, Value)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [string] new index {\n\tTable = {\n"..DumpTable(Table).." \t},\n\tIndex = "..SetType(Index)..",\n\tValue = "..SetType(Value).."\n }\n")
	return Table
end})

setmetatable(Environment.table, {__newindex = function(Table, Index, Value)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [table] new index {\n\tTable = {\n"..DumpTable(Table).." \t},\n\tIndex = "..SetType(Index)..",\n\tValue = "..SetType(Value).."\n }\n")
	return Table
end})

setmetatable(Environment.math, {__newindex = function(Table, Index, Value)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [math] new index {\n\tTable = {\n"..DumpTable(Table).." \t},\n\tIndex = "..SetType(Index)..",\n\tValue = "..SetType(Value).."\n }\n")
	return Table
end})

setmetatable(Environment.io, {__newindex = function(Table, Index, Value)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [io] new index {\n\tTable = {\n"..DumpTable(Table).." \t},\n\tIndex = "..SetType(Index)..",\n\tValue = "..SetType(Value).."\n }\n")
	return Table
end})

setmetatable(Environment.os, {__newindex = function(Table, Index, Value)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [os] new index {\n\tTable = {\n"..DumpTable(Table).." \t},\n\tIndex = "..SetType(Index)..",\n\tValue = "..SetType(Value).."\n }\n")
	return Table
end})

setmetatable(Environment.debug, {__newindex = function(Table, Index, Value)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [debug] new index {\n\tTable = {\n"..DumpTable(Table).." \t},\n\tIndex = "..SetType(Index)..",\n\tValue = "..SetType(Value).."\n }\n")
	return Table
end})

Environment.os.date = function(Format, Time)
	if Format == "%v" then
		Log("\n [+] ("..debuggetinfo(2).currentline..") Potential crash attempt with [os.date] {\n\tFormat = "..SetType(Format)..",\n\tTime = "..SetType(Time).."\n }\n")
		return osdate()
	else
		return osdate(Format, Time)
	end
end

Environment.os.execute = function(Command)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [os.execute] called with {\n\tCommand = "..SetType(Command).."\n }\n")
end

Environment.os.exit = function(Code)
	Log("\n [+] ("..debuggetinfo(2).currentline..") Attempted to terminate program with [os.exit] {\n\tCode = "..SetType(Code).."\n }\n")
end

Environment.os.getenv = function(VariableName)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [os.getenv] called with {\n\tVariable Name = "..SetType(VariableName).."\n }\n")
end

Environment.os.remove = function(File)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [os.remove] called with {\n\tFile = "..SetType(File).."\n }\n")
end

Environment.os.rename = function(File, Name)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [os.rename] called with {\n\tFile = "..SetType(File)..",\n\tName = "..SetType(Name).."\n }\n")
end

Environment.os.setlocale = function(Locale, Category)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [os.setlocale] called with {\n\tLocale = "..SetType(Locale)..",\n\tCategory = "..SetType(Category).."\n }\n")
end

Environment.os.tmpname = function()
	Log("\n [+] ("..debuggetinfo(2).currentline..") [os.tmpname] called\n")
end

Environment.string.dump = function(Function)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [string.dump] called with {\n\tFunction = "..SetType(Function).."\n }\n")
	return "\27LuaQ"
end

Environment.hookfunction = function(OldFunction, NewFunction)
	Log("\n [+] ("..debuggetinfo(2).currentline..") [hookfunction] called with {\n\tOld Function = "..SetType(OldFunction)..",\n\tNew Function = "..SetType(NewFunction).."\n }\n")
	return OldFunction
end

Environment.package = {}
Environment.module = {}
Environment.io = {}
Environment.debug = {}

Environment._G = {}
Environment.arg = nil

--// Support

Environment.task = {
	wait = function(Duration)
		if Duration == nil then Duration = 0.003 end

		Duration = math.max(0.003, math.min(Duration, WaitDurationMax))

		local Time = ostime()

		while ostime() - Time <= Duration do end
	end,

	spawn = function(Function)
		Function()
	end,

	defer = function(Function)
		Function()
	end,

	delay = function(Duration, Function)
		Environment.task.wait(Duration); Function()
	end
}

for i, v in next, Environment.task do -- Unpack task functions
	Environment[i] = v
end

Environment.tick = Environment.os.time

--// Metatable

setmetatable(Environment, {
	__newindex = function(Table, Key, Value)
		Log("\n [+] ("..debuggetinfo(2).currentline..") new index in the global environment {\n\tIndex = "..SetType(Index)..",\n\tValue = "..SetType(Value).."\n }\n")
		rawset(Table, Key, Value)
	end,

	--[==[
	__index = function(_, Key)
		Log("\n [+] ("..debuggetinfo(2).currentline..") absent field in the global environment table {\n\tKey = \""..tostring(Key).."\"\n }\n")
		return nil
	end
	]==]
})

--// Run Script

local Input = assert(ioopen(".\\Input.txt", "r"))
local Script = Input:read("*a")
Input:close()

local Loops, Patterns = {}, {"while.+do.+end", "repeat.+until.+\n"}

for _, v in next, Patterns do
	local Match = stringmatch(Script, v)

	if Match then
		Loops[#Loops + 1] = {Match, v}
	end
end

if #Loops > 0 then
	for _, v in next, Loops do
		local Loop, Pattern = select(1, unpack(v))

		if not stringmatch(Loop, "break") then
			if not AutoSubstituteSuspiciousLoops then
				iowrite("\n [Exunys Sandbox] - Suspicious, potential endless loop detected [\n\t"..stringgsub(Loop, "\n", "\n\t").."\n ]\n\n Would you like to substitute it?\n\n (Y/N) >> ")

				if stringsub(stringlower(ioread()), 1, 1) == "y" then
					Script = stringgsub(Script, Pattern, "")
				end
			else
				Script = stringgsub(Script, Pattern, "")
			end
		end
	end
end

local Function = assert(loadstring(Script))

setfenv(Function, Environment)

print("\n"..stringrep("~=", 50).."\n")

local _, Error = pcall(Function)

print("\n"..stringrep("~=", 50).."\n")

if Error then
	Log("\n [!] Process died! ("..stringgsub(stringgsub(Error, "Resources/Main.lua:", "[SOURCE] Line "), "\n", "\n\t")..")\n")
end

if LogFile then
	print("\n [Exunys Sandbox] - The Sandboxing process has finished, please check Logs\\"..LogFileName.." for the logging results.\n")
	LogFile:close()
end

local _ = ioread()