--[[
	@desc: Modul inicjacji polaczenia z baza MySQL, oraz kilka funkcji do jej oblusgi
	@file: s_db.lua
	@author: l0nger <l0nger.programmer@gmail.com>
	@link package: https://github.com/l0nger/PolishRP
	@licence: GPLv2
	
	(c) <2014>, <l0nger.programmer@gmail.com>
--]]

local ALIVE_TIME_REPEAT = 45000 -- czas (ms) do sprawdzenia polaczenia z baza danych
local SQL_USER = "username"
local SQL_PASSWD = "password"
local SQL_DB = "database"
local SQL_HOST = "host"
local SQL_PORT = tonumer(get("port") or 3306)

local db_handler=nil
local root=getRootElement()

-- -------------------------------------------------------

local function connectWithDB()
	db_handle=mysql_connect(SQL_HOST, SQL_USER, SQL_PASSWD, SQL_DB, SQL_PORT
	if not db_handler then
		outputServerLog("Brak polaczenia z baza danych!")
	else 
		outputServerLog("Polaczono z baza danych!")
	end
end

local function keepAliveDB()
	if not mysql_ping(db_handler) then
		connectWithDB()
		-- jakies informacje o zerwaniu polaczenia?
	end
end

function getHandler()
	return db_handler
end

function insertID()
	mysql_insert_id(db_handler)
end

function affectedRows()
	return mysql_affected_rows(db_handler)
end

function query(str)
	local res = mysql_query(db_handler, str)
	if res then 
		mysql_free_result(result) 
	end
	return
end

function escapeString(val)
	return mysql_escape_string(db_handler, val)
end

-- -------------------------------------------------------

addEventHandler("onResourceStart", getResourceRootElement(), 
	function()
		connectWithDB()
		setTimer(keepAliveDB, ALIVE_TIME_REPEAT, 0)
end)
