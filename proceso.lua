local cjson = require "cjson"
local util = require "medicamentos.util"
local globals = require "medicamentos.globals"

--Variables
local identidad = ngx.var.http_userid or ngx.var.remote_user
local detalle = ""
local heDetail = ""
local resHead = ""
local servicio = ""
local dbRes = ""
local tranBD = {}
local ok = false
local idTran = "0"
local ip = ngx.var.http_true_client_ip

-- Validar que sea un POST un JSON, devuelve el objeto JSON y el body del request original
local jsonReq, oriReqBody, oriReqHeaders, jsonResp, statusResp, heIdEvent, heEvent = util.getValidJSONreq()

local function procesoMedicamentos ()
	--Verificar nombre del servicio válido y obtener datos
	servicio = ngx.var.uri:match("^.*/(.-)$",1)
	ngx.log(ngx.DEBUG,servicio)
	local srv = (require "medicamentos.procesos")[servicio]

	if srv then
		--ngx.log(ngx.DEBUG,(require "inspect")(jsonReq))
		--Validar datos requeridos y formatos
		jsonResp, statusResp, heIdEvent, heEvent = util.validate(jsonReq,srv.validacion)
		--ngx.log(ngx.DEBUG,(require "inspect")(jsonResp), #jsonResp)
		if not jsonResp.codigo then
			--Ejecutar todos los pasos
			for _,paso in ipairs(srv.pasos) do
				if paso.enabled and paso.enabled(jsonResp) == true or paso.enabled == nil then
					if paso.tipo == "script" then
						ok, idTran, jsonResp, heIdEvent, heEvent, statusResp = paso.getResult(jsonReq)
					elseif paso.tipo == "datos" then
						--Generar transacci�n en BD
						local dbm = require "medicamentos.datos"
						local table = paso.getTable and paso.getTable(jsonReq) or jsonReq
						ok, tranBD, jsonResp, heIdEvent, heEvent, statusResp, heDetail = dbm.exec(paso.consulta,paso,table)
						if ok then
							ok, idTran, jsonResp, heIdEvent, heEvent, statusResp = paso.getResult(tranBD, jsonReq)
						end
					elseif paso.tipo == "servicio" then
						--Ejecutar servicio externo
						local http = require "resty.http"
						local httpc = http.new()
						httpc:set_timeout(50000)
						local okCon, errCon = httpc:connect("127.0.0.1", 80)
						if not okCon then
							ngx.log(ngx.ERR, errCon)
							jsonResp = {codigo=globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.code,mensaje=globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.message, detalle=errCon}
							heIdEvent = globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.idEvent
							heEvent = globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.event
							statusResp = 500
						else
							local res, errReq = httpc:request({
									path = paso.getPath(jsonReq),
									method = paso.getMethod(),
									body = paso.getBody(jsonReq),
									query = paso.getQuery(jsonReq),
									headers = paso.getHeaders()
								})
							--ngx.log(ngx.DEBUG,(require "inspect")(res))
							ok, idTran, jsonResp, heIdEvent, heEvent, statusResp = paso.getResult(res, jsonReq)
							if errReq then
								jsonResp.detalle = errReq
							end
							local okKA, errKA = httpc:set_keepalive()
							if not okKA then
								ngx.log(ngx.ERR, "Failed to set keepalive: "..errKA)
							end
						end
					elseif paso.tipo == "servicioMulti" then
						local detail, res, errReq, reqBody, reqHeaders, response
						--Ejecutar servicio externo
						for i,reg in ipairs(paso.getTable(jsonReq)) do
							local http = require "resty.http"
							local httpc = http.new()
							httpc:set_timeout(60000)
							local okCon, errCon = httpc:connect("127.0.0.1", 80)
							if not okCon then
								ngx.log(ngx.ERR, errCon)
								jsonResp = {codigo=globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.code,mensaje=globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.message, detalle=errCon}
								heIdEvent = globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.idEvent
								heEvent = globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.event
								statusResp = 500
							else
								ok, idTran, jsonResp, heIdEvent, heEvent, statusResp, detail = paso.getItemIsValid(reg,jsonReq,i)
								if ok then
									local reqPath = paso.getPath and paso.getPath(reg,jsonReq,i)
									reqBody = paso.getBody and paso.getBody(reg,jsonReq,i)
									reqHeaders = paso.getHeaders and paso.getHeaders(reg,jsonReq,i)
									local reqQuery = paso.getQuery and paso.getQuery(reg,jsonReq,i)
									res, errReq = httpc:request({
											path = reqPath,
											method = paso.getMethod(reg,jsonReq,i),
											body = reqBody,
											query = reqQuery,
											headers = reqHeaders
										})
									--ngx.log(ngx.DEBUG,(require "inspect")(res)) 
								end
								ok, idTran, jsonResp, heIdEvent, heEvent, statusResp, detail, response = paso.getItemResult(res, reg, jsonReq, idTran, jsonResp, heIdEvent, heEvent, statusResp, detail, response)
								if errReq then
									jsonResp.detalle = errReq
								end
								local okKA, errKA = httpc:set_keepalive()
								if not okKA then
									ngx.log(ngx.ERR, "Failed to set keepalive: "..errKA)
								end
							end
							local reqHEServicio = paso.getItemHE and paso.getItemHE(res,reg,jsonReq,jsonResp)
							-- if reqHEServicio then
							-- 	local he = require "he.historialEventos"
							-- 	local ins = require "inspect"
							-- 	local heData = "PATH:\n"..(ngx.var.request_uri or "").."\n\nREMOTE ADDRESS:\n"..(ngx.var.remote_addr or "").."\n\nCLIENT HEADERS:"..(reqHeaders and ins(reqHeaders) or "").."\n\nCLIENT REQUEST:\n"..((reqBody and ins(reqBody) or ""):sub(1,1000)).."\n\nRESPONSE:"..(response and ins(response) or "").."\n\nRESPONSE HEADERS:"..(res and res.headers and ins(res.headers) or "").."\n\nCLIENT RESPONSE:\n"..(jsonResp and ins(jsonResp) or "")..((detail ~= "" and ("\n\nDETALLE: "..detail)) or "")
							-- 	he.registrarEvento (heIdEvent, heEvent, idTran, reqHEServicio, globals.ID_EVENT_TRACKING, globals.EVENT_TRACKING_GROUP, identidad, detalle, ip, res and res.status or 500, ngx.var.request_time, heData)
							-- end
						end
						ok, idTran, jsonResp, heIdEvent, heEvent, statusResp = paso.getResult(jsonReq)
					elseif paso.tipo == "proxy" then
						--Ejecutar servicio externo
						local http = require "resty.http"
						local httpc = http.new()
						httpc:set_timeout(50000)
						local okCon, errCon = httpc:connect("127.0.0.1", 80)
						if not okCon then
							ngx.log(ngx.ERR, errCon)
							jsonResp = {codigo=globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.code,mensaje=globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.message, detalle=errCon}
							heIdEvent = globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.idEvent
							heEvent = globals.messages.EXTERNAL_SERVICE_NOT_RESPONDING.event
							statusResp = 500
						else
							local res, errReq = httpc:request({
									path = paso.getPath(jsonReq),
									method = paso.getMethod(),
									body = paso.getBody(jsonReq),
									query = paso.getQuery(jsonReq),
									headers = paso.getHeaders()
								})
							--ngx.log(ngx.DEBUG,(require "inspect")(res))
							if res and not errReq then
								ok = true
								jsonResp = nil
								heIdEvent = globals.messages.SERVICE_SUCCESSFUL.idEvent
								heEvent = globals.messages.SERVICE_SUCCESSFUL.event
								statusResp = res.status
								httpc:proxy_response(res,8192)
							else
								ok = false
								jsonResp = {codigo=globals.messages.EXTERNAL_SERVICE_ERROR.code,mensaje=globals.messages.EXTERNAL_SERVICE_ERROR.message, detalle=errCon}
								heIdEvent = globals.messages.EXTERNAL_SERVICE_ERROR.idEvent
								heEvent = globals.messages.EXTERNAL_SERVICE_ERROR.event
								statusResp = 500
							end
							if errReq then
								jsonResp.detalle = errReq
							end
							local okKA, errKA = httpc:set_keepalive()
							if not okKA then
								ngx.log(ngx.ERR, "Failed to set keepalive: "..(errKA or ""))
							end
						end
					end
				end
				if ok == false then break end
				jsonReq = jsonResp
			end
		end
	else
		jsonResp = {codigo=globals.messages.SERVICE_NOT_FOUND.code,mensaje=globals.messages.SERVICE_NOT_FOUND.message}
		heIdEvent = globals.messages.SERVICE_NOT_FOUND.idEvent
		heEvent = globals.messages.SERVICE_NOT_FOUND.event
		statusResp = 500
	end
end

if jsonReq then
	--Se llama la invocación para que en caso de error no controlado se pueda cachar.
	local stat, err = pcall(procesoMedicamentos)
	ngx.log(ngx.DEBUG,stat) 
	if not stat then
		jsonResp = {codigo=globals.messages.UNEXPECTED_ERROR.code,mensaje=globals.messages.UNEXPECTED_ERROR.message}
		heIdEvent = globals.messages.UNEXPECTED_ERROR.idEvent
		heEvent = globals.messages.UNEXPECTED_ERROR.event
		statusResp = 500
		heDetail = err
		ngx.log(ngx.ERR,err) 
	end
else
	heDetail = cjson.encode({mensaje = jsonResp.mensaje})
end

if tranBD then 
	local inspect = require "inspect"
	dbRes = inspect(tranBD)
end

if jsonResp then
	jsonResp = cjson.encode(jsonResp)
	--Response Headers
	ngx.header["Content-Type"] = "application/json; charset=UTF-8"

	-- Response
	ngx.status = statusResp
	ngx.print(jsonResp)
	-- Devolver respuesta sin esperar a HE
	ngx.eof()
end

-- Guardar historial de eventos
for k, v in pairs(ngx.resp.get_headers(0,true)) do
	resHead = resHead.."\n"..k.." - "..v
	--ngx.log(ngx.DEBUG,k," - ",v)
end

-- local he = require "he.historialEventos"
-- local heData = "PATH:\n"..(ngx.var.request_uri or "").."\n\nREMOTE ADDRESS:\n"..(ngx.var.remote_addr or "").."\n\nCLIENT HEADERS:"..(oriReqHeaders or "").."\n\nCLIENT REQUEST:\n"..oriReqBody:sub(1,1000).."\n\nDB RESPONSE:\n"..dbRes:sub(1,1000).."\n\nCLIENT RESPONSE HEADERS:"..resHead.."\n\nCLIENT RESPONSE:\n"..(jsonResp or "")..((heDetail ~= "" and ("\n\nDETALLE: "..heDetail)) or "")
-- he.registrarEvento (heIdEvent, heEvent, idTran, servicio, globals.ID_EVENT_TRACKING, globals.EVENT_TRACKING_GROUP, identidad, detalle, ip, statusResp, ngx.var.request_time, heData)
