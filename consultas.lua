local cjson = require "cjson"
local globals = require "medicamentos.globals"
local util = require "medicamentos.util"
--local inspect = require "inspect"

local _E = {
	["dependencias"] = {
		validacion = {},
		getData = function (reg) 
			return ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["dependenciasxId"] = {
		validacion = {},
		getData = function (reg) 
			return reg.institucionId or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["almacenes"] = {
		validacion = {},
		getData = function (reg) 
			return ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["proveedores"] = {
		validacion = {},
		getData = function (reg) 
			return ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["proveedoresxInstitucion"] = {
		validacion = {},
		getData = function (reg) 
			
			return reg.institucionId or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["medicamentos"] = {
		validacion = {},
		getData = function (reg) 
			return ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["clues"] = {
		validacion = {},
		getData = function (reg) 
			return ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["cluesPorInstitucion"] = {
		validacion = {institucionId = {lbl = "Identificador institución", req = true}},
		getData = function (reg) 
			return reg.institucionId or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["contratosPorInstitucion"] = {
		validacion = {institucionId = {lbl = "Identificador institución", req = true}},
		getData = function (reg) 
			return reg.institucionId or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["medicamentosPorContrato"] = {
		validacion = {contratoId = {lbl = "Identificador contrato", req = true}},
		getData = function (reg) 
			return reg.contratoId or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["causasRechazo"] = {
		validacion = {},
		getData = function (reg) 
			return ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},-- HU58-AIJR-INICIO
	["causasEdicion"] = {
		validacion = {},
		getData = function (reg) 
			return ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["cantidadPendiente"] = {
		validacion = {},
		getData = function (reg) 
			ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::ID::::::::::::::"))
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.iOrdenSuministro or ngx.null
		end,
		getResponse = function(tranDB)
			ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			if tranDB.cantidad_pendiente_orden then
				return true,nil,nil,nil,tranDB.cantidad_pendiente_orden
			elseif tranDB[1] and  tranDB[1].cantidad_pendiente_orden then
				return true,nil,nil,nil,tranDB[1].cantidad_pendiente_orden
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["estatusOrdenSuministro"] = {
		validacion = {},
		getData = function (reg) 
			ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::estatus::::::::::::::"))
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.iOrdenSuministro or ngx.null
		end,
		getResponse = function(tranDB)
			ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			if tranDB.estatus then
				return true,nil,nil,nil,tranDB.estatus
			elseif tranDB[1] and  tranDB[1].estatus then
				return true,nil,nil,nil,tranDB[1].estatus
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["actualizarRemision"] = {
		validacion = {},
		getData = function (reg) 
			ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::XXX4444444XXX::::::::::::::"))
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.cantidadEntregar or ngx.nul, reg.codigoBarras or ngx.nul, reg.codigoBarrasColectivo or ngx.nul, reg.codigoBarrasGeneral or ngx.nul, reg.dimensionesEnvaseColectivoAlto or ngx.nul, reg.dimensionesEnvaseColectivoAncho or ngx.nul, reg.dimensionesEnvaseColectivoProfundidad or ngx.nul, reg.fechaCaducidad or ngx.nul, reg.fechaFabricacion or ngx.nul, reg.lote or ngx.nul, reg.marcaMedicamento or ngx.nul, reg.pesoEnvaseColectivo or ngx.nul, reg.procedenciaMedicamento or ngx.nul, reg.unidadesEnvaseColectivo or ngx.nul, reg.usuarioEdita or ngx.nul, reg.motivosEdicion or ngx.nul, reg.idOrdenRemision or ngx.nul	
		end,
		getResponse = function(tranDB)
			local ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
			if (tranDB.affected_rows ~= nil and tranDB.affected_rows  >= 0) or (tranDB[1] and tranDB[1].affected_rows ~= nil and tranDB[1].affected_rows >= 0) then
				ok = true
				idTran = tranDB.affected_rows or tranDB[1] and tranDB[1].affected_rows
				heIdEvent = globals.messages.SERVICE_SUCCESSFUL.idEvent
				heEvent = globals.messages.SERVICE_SUCCESSFUL.event
				statusResp = 200
			else
				ok = false
				jsonResp = {codigo=globals.messages.DATABASE_NO_RESULTS.code,mensaje=globals.messages.DATABASE_NO_RESULTS.message}
				heIdEvent = globals.messages.DATABASE_NO_RESULTS.idEvent
				heEvent = globals.messages.DATABASE_NO_RESULTS.event
				statusResp = 404
			end
			return ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
		end
	},
	["actualizacionEstatusOSprogramada"] = {
		validacion = {},
		getData = function (reg) 
			ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::XXXrrrrrrrXXX::::::::::::::"))
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.idsOS or ngx.nul
		end,
		getResponse = function(tranDB)
			local ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
			if (tranDB.affected_rows ~= nil and tranDB.affected_rows  >= 0) or (tranDB[1] and tranDB[1].affected_rows ~= nil and tranDB[1].affected_rows >= 0) then
				ok = true
				idTran = tranDB.affected_rows or tranDB[1] and tranDB[1].affected_rows
				heIdEvent = globals.messages.SERVICE_SUCCESSFUL.idEvent
				heEvent = globals.messages.SERVICE_SUCCESSFUL.event
				statusResp = 200
			else
				ok = false
				jsonResp = {codigo=globals.messages.DATABASE_NO_RESULTS.code,mensaje=globals.messages.DATABASE_NO_RESULTS.message}
				heIdEvent = globals.messages.DATABASE_NO_RESULTS.idEvent
				heEvent = globals.messages.DATABASE_NO_RESULTS.event
				statusResp = 404
			end
			return ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
		end
	},
	["actualizacionEstatusOSautorizada"] = {
		validacion = {},
		getData = function (reg) 
			ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::XXX333XXX::::::::::::::"))
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.idsOS or ngx.nul	
		end,
		getResponse = function(tranDB)
			local ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
			if (tranDB.affected_rows ~= nil and tranDB.affected_rows  >= 0) or (tranDB[1] and tranDB[1].affected_rows ~= nil and tranDB[1].affected_rows >= 0) then
				ok = true
				idTran = tranDB.affected_rows or tranDB[1] and tranDB[1].affected_rows
				heIdEvent = globals.messages.SERVICE_SUCCESSFUL.idEvent
				heEvent = globals.messages.SERVICE_SUCCESSFUL.event
				statusResp = 200
			else
				ok = false
				jsonResp = {codigo=globals.messages.DATABASE_NO_RESULTS.code,mensaje=globals.messages.DATABASE_NO_RESULTS.message}
				heIdEvent = globals.messages.DATABASE_NO_RESULTS.idEvent
				heEvent = globals.messages.DATABASE_NO_RESULTS.event
				statusResp = 404
			end
			return ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
		end
	},
	["secuenciaTareaGlobal"]={
		validacion = {},
		getData = function (reg) 
			return ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB then
				return true,nil,nil,nil,tranDB
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["insertTareaTMP"] = {
		validacion = {},
		getData = function (reg) 
			ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::FFFFFF:::::::::::::"))
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.secuenciaTablaTareaTMP or ngx.nul, reg.id or ngx.nul		
		end,
		getResponse = function(tranDB)
			local ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
			if (tranDB.affected_rows ~= nil and tranDB.affected_rows  >= 0) or (tranDB[1] and tranDB[1].affected_rows ~= nil and tranDB[1].affected_rows >= 0) then
				ok = true
				idTran = tranDB.affected_rows or tranDB[1] and tranDB[1].affected_rows
				heIdEvent = globals.messages.SERVICE_SUCCESSFUL.idEvent
				heEvent = globals.messages.SERVICE_SUCCESSFUL.event
				statusResp = 200
			else
				ok = false
				jsonResp = {codigo=globals.messages.DATABASE_NO_RESULTS.code,mensaje=globals.messages.DATABASE_NO_RESULTS.message}
				heIdEvent = globals.messages.DATABASE_NO_RESULTS.idEvent
				heEvent = globals.messages.DATABASE_NO_RESULTS.event
				statusResp = 404
			end
			return ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
		end
	},
	["tareaAgrupada"] = {
		validacion = {},
		getData = function (reg) 
			ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::ID7777::::::::::::::"))
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.iOrdenSuministro or ngx.null
		end,
		getResponse = function(tranDB)
			ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			local ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
			jsonResp=tranDB.idtareaagrupaos
			if tranDB.idtareaagrupaos then
				return true,nil,nil,nil,tranDB.idtareaagrupaos
			elseif tranDB[1] and  tranDB[1].idtareaagrupaos then
				return true,nil,nil,nil,tranDB[1].idtareaagrupaos
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
   },
   ["tareaPorIds"] = {
	validacion = {},
	getData = function (reg) 
		ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::ID88888::::::::::::::"))
		ngx.log(ngx.DEBUG,(require "inspect")(reg))
		return reg.idTareaAgrupada or ngx.null
	end,
	getResponse = function(tranDB)
		ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
		local ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
		jsonResp=tranDB.idos
		if tranDB.idos then
			return true,nil,nil,nil,tranDB.idos
		elseif tranDB[1] and  tranDB[1].idos then
			return true,nil,nil,nil,tranDB[1].idos
		else
			return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
		end
	end
},
["cantidadTareaTotal"] = {
	validacion = {},
	
	getData = function (reg) 
		ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::ID88888::::::::::::::"))
		ngx.log(ngx.DEBUG,(require "inspect")(reg.idOS))
		return reg.idOS or ngx.null
	end,
	getResponse = function(tranDB)
		ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::ID99999a::::::::::::::"))
		ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
		ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::ID9999b::::::::::::::"))
		local ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
		if tranDB  then
			return true,nil,nil,nil,tranDB
		elseif tranDB[1] and  tranDB[1] then
			return true,nil,nil,nil,tranDB[1]
		else
			return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
		end
	end
},
["cerrarTareaBandejaOrdenRemision"] = {
	validacion = {},
	getData = function (reg) 
		ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::XXX333XXX::::::::::::::"))
		ngx.log(ngx.DEBUG,(require "inspect")(reg))
		return  reg.idOS or ngx.null
	end,
	getResponse = function(tranDB)
		local ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
		if (tranDB.affected_rows ~= nil and tranDB.affected_rows  >= 0) or (tranDB[1] and tranDB[1].affected_rows ~= nil and tranDB[1].affected_rows >= 0) then
			ok = true
			idTran = tranDB.affected_rows or tranDB[1] and tranDB[1].affected_rows
			heIdEvent = globals.messages.SERVICE_SUCCESSFUL.idEvent
			heEvent = globals.messages.SERVICE_SUCCESSFUL.event
			statusResp = 200
		else
			ok = false
			jsonResp = {codigo=globals.messages.DATABASE_NO_RESULTS.code,mensaje=globals.messages.DATABASE_NO_RESULTS.message}
			heIdEvent = globals.messages.DATABASE_NO_RESULTS.idEvent
			heEvent = globals.messages.DATABASE_NO_RESULTS.event
			statusResp = 404
		end
		return ok, idTran, jsonResp, heIdEvent, heEvent, statusResp
	end
},-- HU58-AIJR-FIN
["institucionPorUsuario"] = {
		validacion = {usuario = {lbl = "Usuario", len = "255", req = true}},
		getData = function (reg) 
			return reg.usuario or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.institucionId then
				return true,nil,nil,nil,tranDB.institucionId
			elseif tranDB[1] and  tranDB[1].institucionId then
				return true,nil,nil,nil,tranDB[1].institucionId
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["proveedorPorUsuario"] = {
		validacion = {usuario = {lbl = "Usuario", len = "255", req = true}},
		getData = function (reg) 
			return reg.usuario or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.institucionId then
				return true,nil,nil,nil,tranDB.proveedorId
			elseif tranDB[1] and  tranDB[1].proveedorId then
				return true,nil,nil,nil,tranDB[1].proveedorId
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["institucionPorJWT"] = {
		validacion = {},
		getData = function (reg)
			return ngx.var.http_institucionid or ngx.null, ngx.var.http_userid or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.institucionId then
				return true,nil,nil,nil,tranDB.institucionId
			elseif tranDB[1] and  tranDB[1].institucionId then
				return true,nil,nil,nil,tranDB[1].institucionId
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["proveedoresOrdenes"] = {
		validacion = {institucionId = {lbl = "Identificador institución", req = true}},
		getData = function (reg) 
			return reg.institucionId or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["almacenesOrdenes"] = {
		validacion = {institucionId = {lbl = "Identificador institución", req = true}, proveedorId = {lbl = "Identificador de proveedor", req = true}},
		getData = function (reg) 
			return reg.institucionId or ngx.null, reg.proveedorId or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["proveedoresOrdenesInstitucion"] = {
		validacion = {},
		getData = function (reg) 
			return reg.usuario or ngx.var.http_user or ngx.var.remote_user or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["almacenesOrdenesInstitucion"] = {
		validacion = {proveedorId = {lbl = "Identificador de proveedor", req = true}},
		getData = function (reg) 
			return reg.usuario or ngx.var.http_user or ngx.var.remote_user or ngx.null, reg.proveedorId or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesSuministroInstitucion"] = {
		validacion = {proveedorId = {lbl = "Identificador de proveedor", req = true}, almacenEntregaId = {lbl = "Identificador almacén de entrega", req = true}, estatus = {lbl = "Estatus"}},
		getData = function (reg) 
			return reg.usuario or ngx.var.http_user or ngx.var.remote_user or ngx.null, reg.proveedorId or ngx.null, reg.almacenEntregaId or ngx.null, reg.estatus or 1
		end,
		getResponse = function(tranDB)
			if tranDB.id_orden_suministro then
				return true,nil,nil,nil,tranDB.id_orden_suministro
			elseif tranDB[1] and  tranDB[1].id_orden_suministro then
				return true,nil,nil,nil,tranDB[1].id_orden_suministro
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesSuministroPorEstatus"] = {
		validacion = {institucionId = { lbl = "Identificador institución", req = true}, proveedorId = {lbl = "Identificador de proveedor", req = true}, almacenEntregaId = {lbl = "Identificador almacén de entrega", req = true}, estatus = {lbl = "Estatus", req = true}},
		getData = function (reg) 
			return reg.institucionId or ngx.null, reg.proveedorId or ngx.null, reg.almacenEntregaId or ngx.null, reg.estatus or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id_orden_suministro then
				return true,nil,nil,nil,tranDB.id_orden_suministro
			elseif tranDB[1] and  tranDB[1].id_orden_suministro then
				return true,nil,nil,nil,tranDB[1].id_orden_suministro
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesSuministroPorIds"] = {
		validacion = {ids = {lbl = "Ids",  req = true}},
		getData = function (reg) 
			ngx.log(ngx.DEBUG,(require "inspect")("::::::::::::::or4::::::::::::::"))
					ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.ids or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id_orden_suministro then
				return true,nil,nil,nil,tranDB.id_orden_suministro
			elseif tranDB[1] and  tranDB[1].id_orden_suministro then
				return true,nil,nil,nil,tranDB[1].id_orden_suministro
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesSuministroPorFiltros"] = {
		validacion = {numeroOrdenSuministro = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Número de orden de reposición o suministro", len = 100}, contratoId = {lbl = "Identificador del contrato"}, fechaExpedicionOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden inicial", len = 10}, fechaExpedicionOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden final", len = 10}, fechaEntregaOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden inicial", len = 10}, fechaEntregaOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden final", len = 10}, proveedorId = {lbl = "Identificador del proveedor"}, medicamentoId = {lbl = "Identificador medicamento"}, almacenEntregaId = {lbl = "Identificador del almacén de entrega"}, institucionId = {lbl = "Identificador institución"}},
		getData = function (reg) 
			return reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and reg.fechaExpedicionOrdenFinal ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.pagina and reg.pagina ~= ngx.null and ((reg.registrosPagina or 10) * (reg.pagina - 1)) or 0 
		end,
		getResponse = function(tranDB)
			if tranDB and tranDB[1] and tranDB[1][1] and tranDB[1][1].total_registros and tranDB[1][1].total_registros > 0 then
				return true,nil,nil,nil,tranDB[1][1].total_registros
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesSuministroPorFiltrosSinRemision"] = {
		validacion = {numeroOrdenSuministro = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Número de orden de reposición o suministro", len = 100}, contratoId = {lbl = "Identificador del contrato"}, fechaExpedicionOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden inicial", len = 10}, fechaExpedicionOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden final", len = 10}, fechaEntregaOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden inicial", len = 10}, fechaEntregaOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden final", len = 10}, proveedorId = {lbl = "Identificador del proveedor"}, medicamentoId = {lbl = "Identificador medicamento"}, almacenEntregaId = {lbl = "Identificador del almacén de entrega"}, institucionId = {lbl = "Identificador institución"}},
		getData = function (reg)
			return reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and reg.fechaExpedicionOrdenFinal ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.pagina and reg.pagina ~= ngx.null and ((reg.registrosPagina or 10) * (reg.pagina - 1)) or 0
		end,
		getResponse = function(tranDB)
			if tranDB and tranDB[1] and tranDB[1][1] and tranDB[1][1].total_registros and tranDB[1][1].total_registros > 0 then
				return true,nil,nil,nil,tranDB[1][1].total_registros
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesSuministroPorFiltroProgramada"] = {
		validacion = {numeroOrdenSuministro = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Número de orden de reposición o suministro", len = 100}, contratoId = {lbl = "Identificador del contrato"}, fechaExpedicionOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden inicial", len = 10}, fechaExpedicionOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden final", len = 10}, fechaEntregaOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden inicial", len = 10}, fechaEntregaOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden final", len = 10}, proveedorId = {lbl = "Identificador del proveedor"}, medicamentoId = {lbl = "Identificador medicamento"}, almacenEntregaId = {lbl = "Identificador del almacén de entrega"}, institucionId = {lbl = "Identificador institución"}},
		getData = function (reg)
			return reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and reg.fechaExpedicionOrdenFinal ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.pagina and reg.pagina ~= ngx.null and ((reg.registrosPagina or 10) * (reg.pagina - 1)) or 0
		end,
		getResponse = function(tranDB)
			if tranDB and tranDB[1] and tranDB[1][1] and tranDB[1][1].total_registros and tranDB[1][1].total_registros > 0 then
				return true,nil,nil,nil,tranDB[1][1].total_registros
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesSuministroPorFiltroParcialmente"] = {
		validacion = {numeroOrdenSuministro = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Número de orden de reposición o suministro", len = 100}, contratoId = {lbl = "Identificador del contrato"}, fechaExpedicionOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden inicial", len = 10}, fechaExpedicionOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden final", len = 10}, fechaEntregaOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden inicial", len = 10}, fechaEntregaOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden final", len = 10}, proveedorId = {lbl = "Identificador del proveedor"}, medicamentoId = {lbl = "Identificador medicamento"}, almacenEntregaId = {lbl = "Identificador del almacén de entrega"}, institucionId = {lbl = "Identificador institución"}},
		getData = function (reg)
			return reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and reg.fechaExpedicionOrdenFinal ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.pagina and reg.pagina ~= ngx.null and ((reg.registrosPagina or 10) * (reg.pagina - 1)) or 0
		end,
		getResponse = function(tranDB)
			if tranDB and tranDB[1] and tranDB[1][1] and tranDB[1][1].total_registros and tranDB[1][1].total_registros > 0 then
				return true,nil,nil,nil,tranDB[1][1].total_registros
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesSuministroPorFiltroRecibida"] = {
		validacion = {numeroOrdenSuministro = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Número de orden de reposición o suministro", len = 100}, contratoId = {lbl = "Identificador del contrato"}, fechaExpedicionOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden inicial", len = 10}, fechaExpedicionOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden final", len = 10}, fechaEntregaOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden inicial", len = 10}, fechaEntregaOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden final", len = 10}, proveedorId = {lbl = "Identificador del proveedor"}, medicamentoId = {lbl = "Identificador medicamento"}, almacenEntregaId = {lbl = "Identificador del almacén de entrega"}, institucionId = {lbl = "Identificador institución"}},
		getData = function (reg)
			return reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and reg.fechaExpedicionOrdenFinal ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.pagina and reg.pagina ~= ngx.null and ((reg.registrosPagina or 10) * (reg.pagina - 1)) or 0
		end,
		getResponse = function(tranDB)
			if tranDB and tranDB[1] and tranDB[1][1] and tranDB[1][1].total_registros and tranDB[1][1].total_registros > 0 then
				return true,nil,nil,nil,tranDB[1][1].total_registros
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesSuministroPorFiltroRechazo"] = {
		validacion = {numeroOrdenSuministro = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Número de orden de reposición o suministro", len = 100}, contratoId = {lbl = "Identificador del contrato"}, fechaExpedicionOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden inicial", len = 10}, fechaExpedicionOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden final", len = 10}, fechaEntregaOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden inicial", len = 10}, fechaEntregaOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden final", len = 10}, proveedorId = {lbl = "Identificador del proveedor"}, medicamentoId = {lbl = "Identificador medicamento"}, almacenEntregaId = {lbl = "Identificador del almacén de entrega"}, institucionId = {lbl = "Identificador institución"}},
		getData = function (reg)
			return reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and reg.fechaExpedicionOrdenFinal ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, reg.estatus and reg.estatus ~= ngx.null and reg.estatus or 1, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.pagina and reg.pagina ~= ngx.null and ((reg.registrosPagina or 10) * (reg.pagina - 1)) or 0
		end,
		getResponse = function(tranDB)
			if tranDB and tranDB[1] and tranDB[1][1] and tranDB[1][1].total_registros and tranDB[1][1].total_registros > 0 then
				return true,nil,nil,nil,tranDB[1][1].total_registros
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesSuministroPorNumero"] = {
		validacion = {numeroOrdenSuministro = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Número de orden de reposición o suministro", len = 100}, institucionId = {lbl = "Identificador institución",  req = true}},
		getData = function (reg) 
			return reg.numeroOrdenSuministro or ngx.null, reg.institucionId or ngx.null, reg.numeroOrdenSuministro or ngx.null, reg.institucionId or ngx.null, reg.numeroOrdenSuministro or ngx.null, reg.institucionId or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.numero_orden_suministro then
				return true,nil,nil,nil,tranDB.numero_orden_suministro
			elseif tranDB[1] and  tranDB[1].numero_orden_suministro then
				return true,nil,nil,nil,tranDB[1].numero_orden_suministro
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["obtenerHorariosDisponibles"] = {
		validacion = {almacenId = { lbl = "Identificador almacén", req = true}, fecha = { lbl = "Fecha", req = true}},
		getData = function (reg) 
			return reg.fecha and reg.fecha:sub(1,10) or ngx.null, reg.almacenId or ngx.null, reg.fecha and reg.fecha:sub(1,10) or ngx.null, reg.fecha and reg.fecha:sub(1,10) or ngx.null, reg.almacenId or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB and tranDB[1] and tranDB[1].value then
				return true,nil,nil,nil,tranDB[1].value
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["medicamentosPorContratoJSON"] = {
		validacion = {},
		getData = function (reg) 
			return ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB and tranDB[1] and tranDB[1].contrato then
				return true,nil,nil,nil,tranDB[1].contrato
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesRemisionPorIds"] = {
		validacion = {ids = {lbl = "Ids",  req = true}, fechaHoraEntrega = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4} [0-9]{1,2}[:][0-9]{1,2}[:]?[0-9]{0,4}.*$", lbl= "Fecha y hora de entrega", req = false}},
		getData = function (reg) 
			ngx.log(ngx.DEBUG,(require "inspect")("::::::::::111:::::::::::::"))
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.ids or ngx.null, os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaHoraEntrega))
		end,
		getResponse = function(tranDB)
			if tranDB.id_orden_remision then
				return true,nil,nil,nil,tranDB.id_orden_remision
			elseif tranDB[1] and  tranDB[1].id_orden_remision then
				return true,nil,nil,nil,tranDB[1].id_orden_remision
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesRemisionRecibidas"] = {
		validacion = {ids = {lbl = "Ids",  req = true}, fechaHoraEntrega = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4} [0-9]{1,2}[:][0-9]{1,2}[:]?[0-9]{0,4}.*$", lbl= "Fecha y hora de entrega", req = true}},
		getData = function (reg) 
			return reg.ids or ngx.null, os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaHoraEntrega))
		end,
		getResponse = function(tranDB)
			if tranDB.id_orden_remision then
				return true,nil,nil,nil,tranDB.id_orden_remision
			elseif tranDB[1] and  tranDB[1].id_orden_remision then
				return true,nil,nil,nil,tranDB[1].id_orden_remision
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesRemisionPorNumero"] = {
		validacion = {numeroOrdenRemision = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;#% ]*$", lbl = "Número de orden de remisión", len = 100,  req = true}},
		getData = function (reg) 
			return reg.numeroOrdenRemision or ngx.null, reg.idAlmacen or ngx.null, reg.idDependencia or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id_orden_remision then
				return true,nil,nil,nil,tranDB.id_orden_remision
			elseif tranDB[1] and  tranDB[1].id_orden_remision then
				return true,nil,nil,nil,tranDB[1].id_orden_remision
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesRemisionJSON"] = {
		validacion = {ids = {lbl = "Ids",  req = true}, fechaHoraEntrega = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4} [0-9]{1,2}[:][0-9]{1,2}[:]?[0-9]{0,4}.*$", lbl= "Fecha y hora de entrega", req = true}},
		getData = function (reg) 
			return reg.ids or ngx.null, os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaHoraEntrega))
		end,
		getResponse = function(tranDB)
			if tranDB.numeroOrdenSuministro then
				return true,nil,nil,nil,tranDB.numeroOrdenSuministro
			elseif tranDB[1] and  tranDB[1].numeroOrdenSuministro then
				return true,nil,nil,nil,tranDB[1].numeroOrdenSuministro
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesRemisionPorEnvio"] = {
		validacion = {numeroEnvio = {lbl = "Número de envío",  req = true}},
		getData = function (reg) 
			ngx.log(ngx.DEBUG,(require "inspect")("::::::::::---------:::::::::::::"))
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.numeroEnvio or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id_orden_remision then
				return true,nil,nil,nil,tranDB.id_orden_remision
			elseif tranDB[1] and  tranDB[1].id_orden_remision then
				return true,nil,nil,nil,tranDB[1].id_orden_remision
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesRemisionRecibidasPorEnvio"] = {
		validacion = {numeroEnvio = {lbl = "Número de envío",  req = true}},
		getData = function (reg) 
			return reg.numeroEnvio or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id_orden_remision then
				return true,nil,nil,nil,tranDB.id_orden_remision
			elseif tranDB[1] and  tranDB[1].id_orden_remision then
				return true,nil,nil,nil,tranDB[1].id_orden_remision
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesRemisionPorEnvioJSON"] = {
		validacion = {numeroEnvio = {lbl = "Número de envío",  req = true}},
		getData = function (reg) 
			return reg.numeroEnvio or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.numeroOrdenSuministro then
				return true,nil,nil,nil,tranDB.numeroOrdenSuministro
			elseif tranDB[1] and  tranDB[1].numeroOrdenSuministro then
				return true,nil,nil,nil,tranDB[1].numeroOrdenSuministro
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["numeroEnvio"] = {
		validacion = {numeroEnvio = {lbl = "Número de envío",  req = true}},
		getData = function (reg) 
			return reg.numeroEnvio or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.count and tranDB.count > 0 then
				return true,nil,nil,nil,tranDB.count
			elseif tranDB[1] and  tranDB[1].count and  tranDB[1].count >0 then
				return true,nil,nil,nil,tranDB[1].count
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["ordenesSuministroJSON"] = {
		validacion = {ids = {lbl = "Ids"}, numeroOrdenSuministro = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Número de orden de reposición o suministro", len = 100}, contratoId = {lbl = "Identificador del contrato"}, fechaExpedicionOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden inicial", len = 10}, fechaExpedicionOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden final", len = 10}, fechaEntregaOrdenInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden inicial", len = 10}, fechaEntregaOrdenFinal = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden final", len = 10}, proveedorId = {lbl = "Identificador del proveedor"}, medicamentoId = {lbl = "Identificador medicamento"}, almacenEntregaId = {lbl = "Identificador del almacén de entrega"}, institucionId = {lbl = "Identificador institución"}, estatus = {lbl="Estatus"}},
		getData = function (reg)
			--  Para sustituir en consulta coalesce(%s, 1)
			local status
			if reg.estatus and reg.estatus ~= ngx.null then
				status = "{"..reg.estatus.."}"
			else
				status = "{1}"
			end
			return reg.ids or ngx.null, reg.ids or ngx.null, reg.numeroOrdenSuministro or ngx.null, reg.contratoId or ngx.null, reg.fechaExpedicionOrdenInicial and reg.fechaExpedicionOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenInicial)) or ngx.null, reg.fechaExpedicionOrdenFinal and reg.fechaExpedicionOrdenFinal ~= ngx.null and reg.fechaExpedicionOrdenFinal ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrdenFinal)) or ngx.null, reg.fechaEntregaOrdenInicial and reg.fechaEntregaOrdenInicial ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenInicial)) or ngx.null, reg.fechaEntregaOrdenFinal and reg.fechaEntregaOrdenFinal ~= ngx.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrdenFinal)) or ngx.null, reg.proveedorId or ngx.null, reg.medicamentoId or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.institucionId or ngx.null, status
		end,
		getResponse = function(tranDB)
			if tranDB.numeroOrdenSuministro then
				return true,nil,nil,nil,tranDB.numeroOrdenSuministro
			elseif tranDB[1] and  tranDB[1].numeroOrdenSuministro then
				return true,nil,nil,nil,tranDB[1].numeroOrdenSuministro
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["enviosPorFiltros"] = {
		validacion = {almacenRecibeId = {lbl = "Identificador del almacén que recibe"}},
		getData = function (reg)
			ngx.log(ngx.DEBUG,(require "inspect")(reg))

			local almacenRecibeId = reg.almacenRecibeId or ngx.null
			local proveedorId = reg.proveedorId or ngx.null
			local numeroEnvio = reg.numeroEnvio or ngx.null
			local numeroRemision = reg.numeroRemision or ngx.null
			local clave = reg.clave or ngx.null
			local cantidadRecibida = reg.cantidadRecibida or ngx.null
			local fechaRecepcion = reg.fechaRecepcion or ngx.null
			local registrosPagina = reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10
			local pagina = reg.pagina and reg.pagina ~= ngx.null and ((reg.registrosPagina or 10) * (reg.pagina - 1)) or 0
			-- TODO: Add more parameter cantidad recibida bigint and date
			-- return reg.almacenRecibeId or ngx.null, reg.proveedorId or ngx.null, reg.proveedorId or ngx.null, reg.numeroEnvio or ngx.null, reg.almacenRecibeId or ngx.null, reg.proveedorId or ngx.null, reg.proveedorId or ngx.null, reg.numeroEnvio or ngx.null, reg.registrosPagina and reg.registrosPagina ~= ngx.null and reg.registrosPagina or 10, reg.pagina and reg.pagina ~= ngx.null and ((reg.registrosPagina or 10) * (reg.pagina - 1)) or 0
			return almacenRecibeId,proveedorId,proveedorId,numeroEnvio,numeroRemision,clave,cantidadRecibida,fechaRecepcion,
			almacenRecibeId,proveedorId,proveedorId,numeroEnvio,numeroRemision,clave,cantidadRecibida,fechaRecepcion,registrosPagina,pagina
		end,
		getResponse = function(tranDB)
			ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			if tranDB and tranDB[1] and tranDB[1][1] and tranDB[1][1].total_registros and tranDB[1][1].total_registros > 0 then
				return true,nil,nil,nil,tranDB[1][1].total_registros
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["caTiposDocumento"] = {
		validacion = {},
		getData = function (reg)
			return ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and  tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["documentosPorNumeroEnvio"] = {
		validacion = {},
		getData = function (reg)
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			local numeroEnvio = reg.numeroEnvio or ngx.null
			return numeroEnvio
		end,
		getResponse = function(tranDB)
			ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			if tranDB and tranDB[1] and tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["proveedorOrdenesByDepStatus"] = {
		validacion = {},
		getData = function (reg)
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			local status = reg.estatus or ngx.null
			local institutionId = reg.institucionId or ngx.null
			return status,institutionId
		end,
		getResponse = function(tranDB)
			ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			if tranDB and tranDB[1] and tranDB[1].proveedorId then
				return true,nil,nil,nil,tranDB[1].proveedorId
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["almacenOrdenesByStatusProv"] = {
		validacion = {},
		getData = function (reg)
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			local status = reg.estatus or ngx.null
			local providerId = reg.proveedorId or ngx.null
			return status,providerId
		end,
		getResponse = function(tranDB)
			ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			if tranDB and tranDB[1] and tranDB[1].almacenId then
				return true,nil,nil,nil,tranDB[1].almacenId
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
        ["exportacionReporteCapturista"] = {
                validacion = {},
                getData = function (reg)
                        ngx.log(ngx.DEBUG,(require "inspect")(reg))
                        ngx.log(ngx.DEBUG,(require "inspect")("hola"))
                        local anio = reg.fecha or ngx.null
                        local stringtoD = tostring(anio);
                        ngx.log(ngx.DEBUG,(require "inspect")(stringtoD))
                        local arrayS = util.split(stringtoD, "-")
                        ngx.log(ngx.DEBUG,(require "inspect")(arrayS[1]))
                        return arrayS[1];
                end,
                getResponse = function(tranDB)
                        ngx.log(ngx.DEBUG,(require "inspect")(tranDB[1]))
                        if tranDB  then
                                return true,nil,nil,nil,tranDB[1]
                        else
                                return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
                        end
                end
        },
}

return _E
