local cjson = require "cjson"
local globals = require "medicamentos.globals"
local util = require "medicamentos.util"
--local inspect = require "inspect"

local _E = {
	["entregaConsumidorFinal"] = {
		validacion = {clues = {rgx = "^[a-zA-Z0-9\\-. ]*$", lbl = "Clave Unidad Médica", len = 30, req = true}, claveMedicamento = {rgx = "^[a-zA-Z0-9\\-. ]*$", lbl = "Clave medicamento", len = 100, req = true}, descripcionMedicamento = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Descripción medicamento", len = 300}, lote = {rgx = "^[a-zA-Z0-9\\-. ]*$", lbl = "Lote", len = 100}, fechaEntrega = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega", req = true}, cantidad = {rgx = "^[0-9]*$", lbl = "Cantidad", len = 4, req = true}, personaEntrega = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ\\-. ]*$", lbl = "Persona que entrega", len = 50, req = true}, personaReceta = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ\\-. ]*$", lbl = "Persona que receta", len = 60, req = true}, personaValida = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ\\-. ]*$", lbl = "Persona que valida", len = 60, req = true}, personaValida = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ\\-. ]*$", lbl = "Persona que valida", len = 60, req = true}, idEnvioInstitucion = {rgx = "^[a-zA-Z0-9\\-. ]*$", lbl = "Identificador institución", len = 100, req = true}},
		getData = function (reg) 
			return reg.clues, reg.claveMedicamento, reg.descripcionMedicamento or ngx.null, reg.lote or ngx.null, os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntrega)), reg.cantidad, reg.personaEntrega or ngx.null, reg.personaReceta or ngx.null, reg.personaValida or ngx.null, reg.idEnvioInstitucion or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id_entrega_consumidor then
				return true,nil,nil,nil,tranDB.id_entrega_consumidor
			elseif tranDB[1] and  tranDB[1].id_entrega_consumidor then
				return true,nil,nil,nil,tranDB[1].id_entrega_consumidor
			elseif tranDB[1] and tranDB[1][1] and tranDB[1][1].id_entrega_consumidor then
				return true,nil,nil,nil,tranDB[1][1].id_entrega_consumidor
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	}, 
	["ordenSuministro"] = {
		validacion = {numeroOrdenSuministro = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Número de orden de reposición o suministro", len = 100, req = true}, institucionRequirenteId = {rgx = "^[0-9]*$", lbl = "Identificador institución requirente", len = 10, req = true}, contratoId = {lbl = "Identificador del contrato", req = true}, fechaExpedicionOrden = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden", len = 10, req = true}, fechaEntregaOrden = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden", len = 10, req = true}, proveedorId = {rgx = "^[0-9]*$", lbl = "Identificador del proveedor", len = 10, req = true}, claveMedicamento = {rgx = "^[a-zA-Z0-9\\-. ]*$", lbl = "Clave medicamento", len = 100, req = true}, cantidadSolicitada = {rgx = "^[0-9]*$", lbl = "Cantidad solicitada", len = 7, req = true}, almacenEntregaId = {rgx = "^[0-9]*$", lbl = "Identificador del almacén de entrega", len = 10, req = true}, cluesId = {rgx = "^[0-9]*$", lbl = "Identificador Clave Unidad Médica", len = 10, req = true}, usuariodeCarga = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\- ]*$", lbl = "Usuario de Carga", len = 210, req = false} },
		getData = function (reg) 
			return reg.numeroOrdenSuministro or ngx.null, reg.institucionRequirenteId or ngx.null, reg.contratoId or ngx.null, os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrden)), os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrden)), reg.proveedorId or ngx.null, reg.usuariodeCarga or ngx.null , reg.claveMedicamento or ngx.null, reg.cantidadSolicitada or ngx.null, reg.almacenEntregaId or ngx.null, reg.cluesId or ngx.null, reg.numeroOrdenSuministro or ngx.null, reg.institucionRequirenteId or ngx.null, reg.cantidadSolicitada or ngx.null, reg.contratoId or ngx.null, reg.claveMedicamento or ngx.null  
		end,
		getResponse = function(tranDB)
			if tranDB.id_orden_suministro then
				return true,nil,nil,nil,tranDB.id_orden_suministro
			elseif tranDB[1] and tranDB[1].id_orden_suministro then
				return true,nil,nil,nil,tranDB[1].id_orden_suministro
			elseif tranDB[1] and tranDB[1][1] and tranDB[1][1].id_orden_suministro then
				return true,nil,nil,nil,tranDB[1][1].id_orden_suministro
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	}, 
	["ordenSuministroLayout"] = {
		validacion = {numeroOrdenSuministro = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Número de orden de reposición o suministro", len = 100, req = true}, institucionRequirenteId = {rgx = "^[0-9]*$", lbl = "Identificador institución requirente", len = 10, req = true}, contrato = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Número de contrato",len = 250, req = true}, fechaExpedicionOrden = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de expedición de la orden", len = 10}, fechaEntregaOrden = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega de la orden", len = 10}, proveedorRFC = {rgx = "^([A-Z,a-z,Ñ,&]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])[a-z|A-Z\\d]{3})$", lbl = "RFC del proveedor", len = 14, req = true}, claveMedicamento = {rgx = "^[a-zA-Z0-9\\-. ]*$", lbl = "Clave medicamento", len = 50, req = true}, cantidadSolicitada = {rgx = "^[0-9]*$", lbl = "Cantidad solicitada", len = 10, req = true}, almacenEntregaCodigo = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Código del almacén de entrega", len = 250, req = true}, clues = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;% ]*$", lbl = "Clave Unidad Médica", len = 100, req = true}},
		getData = function (reg) 
			return reg.numeroOrdenSuministro or ngx.null, reg.institucionRequirenteId or ngx.null, reg.contrato or ngx.null, reg.institucionRequirenteId or ngx.null, reg.numeroOrdenSuministro or ngx.null, reg.institucionRequirenteId or ngx.null, reg.fechaExpedicionOrden and reg.fechaExpedicionOrden ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaExpedicionOrden)) or ngx.null, reg.numeroOrdenSuministro or ngx.null, reg.institucionRequirenteId or ngx.null, reg.fechaEntregaOrden and reg.fechaEntregaOrden ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntregaOrden)) or ngx.null, reg.proveedorRFC or ngx.null, reg.institucionRequirenteId or ngx.null, reg.contrato or ngx.null, reg.claveMedicamento or ngx.null, reg.contrato or ngx.null,reg.institucionRequirenteId or ngx.null, reg.cantidadSolicitada or ngx.null,reg.contrato or ngx.null,reg.claveMedicamento or ngx.null,reg.cantidadSolicitada or ngx.null, reg.almacenEntregaCodigo and reg.almacenEntregaCodigo:upper() or ngx.null,reg.idTX or ngx.null, reg.clues and reg.clues:upper() or ngx.null, reg.institucionRequirenteId or ngx.null, reg.numeroOrdenSuministro or ngx.null, reg.institucionRequirenteId or ngx.null, reg.cantidadSolicitada or ngx.null, reg.contrato or ngx.null, reg.claveMedicamento or ngx.null, reg.contrato or ngx.null 
		end,
		getResponse = function(tranDB)
			if tranDB.id_orden_suministro then
				return true,nil,nil,nil,tranDB.id_orden_suministro
			elseif tranDB[1] and tranDB[1].id_orden_suministro then
				return true,nil,nil,nil,tranDB[1].id_orden_suministro
			elseif tranDB[1] and tranDB[1][1] and tranDB[1][1].id_orden_suministro then
				return true,nil,nil,nil,tranDB[1][1].id_orden_suministro
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["crearEventoAlmacenTransitorio"] = {
		validacion = {almacenId = {lbl = "Código de almacén", req = true}, descripcion = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;# ]*$", lbl = "Descripción evento", len = 255, req = true}, linkDetalle = {lbl = "Link detalle", len = 255, req = true}, fechaInicial = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4} [0-9]{1,2}[:][0-9]{1,2}[:]?[0-9]{0,4}.*$", lbl = "Fecha Inicial", len = 40, req = true}},
		getData = function (reg) 
			return reg.almacenId or ngx.null, reg.descripcion or ngx.null, reg.linkDetalle or ngx.null,  os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaInicial)), os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaInicial)), reg.almacenId or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id_almacen_evento then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			elseif tranDB[1] and tranDB[1][1] and tranDB[1][1].id then
				return true,nil,nil,nil,tranDB[1][1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	}, 
	["actualizarOrdenesSuministro"] = {
		validacion = {ids = {lbl = "Ids", req = true}, estatus = { lbl = "Estatus", req = true}, institucionId = {lbl = "Identificador institución", req = true}, processInstance = { lbl = "Process Instance", req = true}, usuario = { lbl = "Usuario"}},
		getData = function (reg) 
			ngx.log(ngx.DEBUG,(require "inspect")("entra aqui para validar ----"))
			return reg.estatus or ngx.null, reg.usuario or ngx.null, reg.ids or ngx.null, reg.usuario or ngx.null, reg.estatus == 2, reg.ids or ngx.null,  reg.institucionId or ngx.null,  reg.processInstance or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.affected_rows then
				return true,nil,nil,nil,tranDB.affected_rows
			elseif tranDB[1] and tranDB[1].affected_rows then
				return true,nil,nil,nil,tranDB[1].affected_rows
			elseif tranDB[1][1] and tranDB[1][1].affected_rows then
				return true,nil,nil,nil,tranDB[1][1].affected_rows
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	}, 
	["cancelarOrdenesSuministro"] = {
		validacion = {ids = {lbl = "Ids", req = true}, usuario = { lbl = "Usuario"}, cantidad = {lbl = "Cantidad"}},
		getData = function (reg) 
			return reg.usuario or ngx.null, reg.ids or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.affected_rows then
				return true,nil,nil,nil,tranDB.affected_rows
			elseif tranDB[1] and tranDB[1].affected_rows then
				return true,nil,nil,nil,tranDB[1].affected_rows
			elseif tranDB[1][1] and tranDB[1][1].affected_rows then
				return true,nil,nil,nil,tranDB[1][1].affected_rows
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	}, 
	["actualizarOrdenesSuministroCantidad"] = {
		validacion = {id = {lbl = "Id", req = true}, fechaEntrega = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4}$", lbl = "Fecha de entrega"}, cantidad = {rgx = "^[0-9]*$", lbl = "Cantidad"}},
		getData = function (reg) 
			return reg.fechaEntrega and reg.fechaEntrega ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaEntrega)) or ngx.null, reg.cantidad or ngx.null, reg.id
		end,
		getResponse = function(tranDB)
			if tranDB.affected_rows then
				return true,nil,nil,nil,tranDB.affected_rows
			elseif tranDB[1] and tranDB[1].affected_rows then
				return true,nil,nil,nil,tranDB[1].affected_rows
			elseif tranDB[1][1] and tranDB[1][1].affected_rows then
				return true,nil,nil,nil,tranDB[1][1].affected_rows
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	}, 
	["ordenRemision"] = {
		validacion = {numeroOrdenRemision = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;#% ]*$", lbl = "Número de orden de remisión", len = 100, req = true}, idOrdenSuministro = {lbl = "Identificador de la orden de suministro", req = true}, lote = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;#%+& ]*$", lbl = "lote", len = 100, req = true}, fechaCaducidad = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;#% ]*$", lbl = "Fecha de caducidad", len = 100, req = true}, fechaFabricacion = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;#% ]*$", lbl = "Fecha de fabricación", len = 100, req = true}, pesoEnvaseColectivo = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;#%+& ]*$", lbl = "Peso del envase colectivo", len = 100, req = true}, dimensionesEnvaseColectivoAlto = {lbl = "Dimensiones del envase colectivo alto", req = true}, dimensionesEnvaseColectivoAncho = {lbl = "Dimensiones del envase colectivo ancho", req = true}, dimensionesEnvaseColectivoProfundidad = {lbl = "Dimensiones del envase colectivo profundidad", req = true}, unidadesEnvaseColectivo = {lbl = "Unidades por envase colectivo", req = true}, codigoBarras = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;#%+& ]*$", lbl = "Código de barras", len = 100, req = true}, marcaMedicamento = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;#%+& ]*$", lbl = "Marca", len = 100, req = true}, procedenciaMedicamento = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;#%+& ]*$", lbl = "Procedencia", len = 100, req = true}, cantidadEntrega = {lbl = "Cantidad a entregar", req = true}, tarimasTotales = {lbl = "Tarimas totales", req = true}, fechaHoraEntrega = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4} [0-9]{1,2}[:][0-9]{1,2}[:]?[0-9]{0,4}.*$", lbl = "Fecha y hora de entrega", len = 100, req = true}, numeroEnvio = {rgx = "^[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ0-9\\\\\\/\\(\\)\\-.,:;#% ]*$", lbl = "Número de envío", len = 100, req = true}},
		getData = function (reg)		
			return reg.numeroOrdenRemision or ngx.null, reg.idOrdenSuministro or ngx.null, reg.lote or ngx.null, reg.fechaCaducidad or ngx.null, reg.fechaFabricacion or ngx.null, reg.pesoEnvaseColectivo or ngx.null,
			reg.dimensionesEnvaseColectivoAlto or ngx.null, reg.dimensionesEnvaseColectivoAncho or ngx.null, reg.dimensionesEnvaseColectivoProfundidad or ngx.null, reg.unidadesEnvaseColectivo or ngx.null,
			reg.codigoBarras or ngx.null, reg.marcaMedicamento or ngx.null, reg.procedenciaMedicamento or ngx.null, reg.cantidadEntrega or ngx.null,
			reg.tarimasTotales or ngx.null, os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaHoraEntrega)), reg.numeroEnvio or ngx.null, reg.estatus or 1,
			reg.codigoBarrasColectivo or ngx.null, reg.codigoBarrasGeneral or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id_orden_remision then
				return true,nil,nil,nil,tranDB.id_orden_remision
			elseif tranDB[1] and tranDB[1].id_orden_remision then
				return true,nil,nil,nil,tranDB[1].id_orden_remision
			elseif tranDB[1] and tranDB[1][1] and tranDB[1][1].id_orden_remision then
				return true,nil,nil,nil,tranDB[1][1].id_orden_remision
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["actualizarTarimas"] = {
		validacion = {ids = {lbl = "Ids",  req = true}, fechaHoraEntrega = {rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4} [0-9]{1,2}[:][0-9]{1,2}[:]?[0-9]{0,4}.*$", lbl= "Fecha y hora de entrega", req = true}, tarimasTotales = {lbl = "Tarimas totales", req = true}},
		getData = function (reg) 
			return reg.tarimasTotales or ngx.null, reg.ids or ngx.null, os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaHoraEntrega))
		end,
		getResponse = function(tranDB)
			if tranDB.affected_rows then
				return true,nil,nil,nil,tranDB.affected_rows
			elseif tranDB[1] and  tranDB[1].affected_rows then
				return true,nil,nil,nil,tranDB[1].affected_rows
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["actualizarOrdenesRemision"] = {
		validacion = {id= {lbl = "Id", req = true}, estatus = { lbl = "Estatus"}, usuario = {lbl = "Usuario", req = true}, cantidadRecibida = { lbl = "Cantidad recibida", req = true}, causasRechazo = { lbl = "Causas rechazo"}, notas = { lbl = "Notas", len = 2500}, fechaHoraRecepcion = { rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4} [0-9]{1,2}[:][0-9]{1,2}[:]?[0-9]{0,4}.*$", lbl = "Fecha hora recepción"}, almacenRecibe = {lbl = "almacenRecibe"}, userId ={lbl = "Id de Usuario"}, recepcionQR = {lbl ="Inicio Recepción QR"}},
		getData = function (reg)

			ngx.log(ngx.DEBUG,(require "inspect")(reg))

			return reg.estatus or ngx.null, reg.usuario or ngx.null, reg.cantidadRecibida or ngx.null,  reg.causasRechazo or ngx.null, reg.fechaHoraRecepcion and reg.fechaHoraRecepcion ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaHoraRecepcion)) or ngx.null, reg.notas or ngx.null, reg.almacenRecibe or ngx.null, reg.userId or ngx.null, reg.recepcionQR or ngx.null, reg.id
		end,
		getResponse = function(tranDB)
			ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			if tranDB == true or tranDB[1] == true then
				return true,nil,nil,nil,1
			end
			if tranDB.affected_rows then
				return true,nil,nil,nil,tranDB.affected_rows
			elseif tranDB[1] and tranDB[1].affected_rows then
				return true,nil,nil,nil,tranDB[1].affected_rows
			elseif tranDB[1][1] and tranDB[1][1].affected_rows then
				return true,nil,nil,nil,tranDB[1][1].affected_rows
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["actualizarOrdenesRemisionRechazo"] = {
		validacion = {id= {lbl = "Id", req = true}, estatus = { lbl = "Estatus"}, usuario = {lbl = "Usuario", req = true}, cantidadRecibida = { lbl = "Cantidad recibida", req = true}, causasRechazo = { lbl = "Causas rechazo"}, notas = { lbl = "Notas", len = 2500}, fechaHoraRecepcion = { rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4} [0-9]{1,2}[:][0-9]{1,2}[:]?[0-9]{0,4}.*$", lbl = "Fecha hora recepción"}, almacenRecibe = {lbl = "almacenRecibe"}, userId ={lbl = "Id de Usuario"}, recepcionQR = {lbl ="Inicio Recepción QR"}},
		getData = function (reg)
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.estatus or ngx.null, reg.usuario or ngx.null, reg.cantidadRecibida or ngx.null,  reg.causasRechazo or ngx.null, reg.fechaHoraRecepcion and reg.fechaHoraRecepcion ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaHoraRecepcion)) or ngx.null, reg.notas or ngx.null, reg.almacenRecibe or ngx.null, reg.userId or ngx.null, ngx.null, reg.id
		end,
		getResponse = function(tranDB)
			ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			if tranDB == true or tranDB[1] == true then
				return true,nil,nil,nil,1
			end
			if tranDB.affected_rows then
				return true,nil,nil,nil,tranDB.affected_rows
			elseif tranDB[1] and tranDB[1].affected_rows then
				return true,nil,nil,nil,tranDB[1].affected_rows
			elseif tranDB[1][1] and tranDB[1][1].affected_rows then
				return true,nil,nil,nil,tranDB[1][1].affected_rows
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["actualizarOrdenesRemisionOld"] = {
		validacion = {id= {lbl = "Id", req = true}, estatus = { lbl = "Estatus"}, usuario = {lbl = "Usuario", req = true}, cantidadRecibida = { lbl = "Cantidad recibida", req = true}, causasRechazo = { lbl = "Causas rechazo"}, notas = { lbl = "Notas", len = 2500}, fechaHoraRecepcion = { rgx = "^[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2,4} [0-9]{1,2}[:][0-9]{1,2}[:]?[0-9]{0,4}.*$", lbl = "Fecha hora recepción"}, almacenRecibe = {lbl = "almacenRecibe", req = true}},
		getData = function (reg)
			ngx.log(ngx.DEBUG,(require "inspect")(reg))

			return reg.estatus or ngx.null, reg.usuario or ngx.null, reg.cantidadRecibida or ngx.null,  reg.causasRechazo or ngx.null, reg.fechaHoraRecepcion and reg.fechaHoraRecepcion ~= cjson.null and os.date("%d/%m/%Y %H:%M:%S",util.toDate(reg.fechaHoraRecepcion)) or ngx.null, reg.notas or ngx.null, reg.almacenRecibe or ngx.null, reg.id
		end,
		getResponse = function(tranDB)
			ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			if tranDB == true or tranDB[1] == true then
				return true,nil,nil,nil,1
			end
			if tranDB.affected_rows then
				return true,nil,nil,nil,tranDB.affected_rows
			elseif tranDB[1] and tranDB[1].affected_rows then
				return true,nil,nil,nil,tranDB[1].affected_rows
			elseif tranDB[1][1] and tranDB[1][1].affected_rows then
				return true,nil,nil,nil,tranDB[1][1].affected_rows
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["obtenerIdxUsuario"] = {
		validacion = {correo= {lbl = "Usuario ", req = true}},
		getData = function (reg)
			ngx.log(ngx.DEBUG,(require "inspect")("entra obtener id"))
			ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.correo or ngx.null
		end,
		getResponse = function(tranDB)
			if tranDB.id then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and tranDB[1].id then
				return true,nil,nil,nil,tranDB[1].id
			elseif tranDB[1] and tranDB[1][1] and tranDB[1][1].id then
				return true,nil,nil,nil,tranDB[1][1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["guardarDocumento"] = {
		validacion = {},
		getData = function (reg)
			-- ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.id, reg.nombreArchivo, reg.tipo, reg.numeroEnvio, reg.mimetypeArchivo,  reg.tamanioArchivo,
			reg.sistema, reg.usuario
		end,
		getResponse = function(tranDB)
			-- ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			if tranDB.affected_rows then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and tranDB[1].affected_rows then
				return true,nil,nil,nil,tranDB[1].id
			elseif tranDB[1][1] and tranDB[1][1].affected_rows then
				return true,nil,nil,nil,tranDB[1][1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
	["eliminarDocumento"] = {
		validacion = {},
		getData = function (reg)
			-- ngx.log(ngx.DEBUG,(require "inspect")(reg))
			return reg.usuario,reg.id
		end,
		getResponse = function(tranDB)
			-- ngx.log(ngx.DEBUG,(require "inspect")(tranDB))
			if tranDB.affected_rows then
				return true,nil,nil,nil,tranDB.id
			elseif tranDB[1] and tranDB[1].affected_rows then
				return true,nil,nil,nil,tranDB[1].id
			elseif tranDB[1][1] and tranDB[1][1].affected_rows then
				return true,nil,nil,nil,tranDB[1][1].id
			else
				return false,globals.messages.DATABASE_NO_RESULTS.code,globals.messages.DATABASE_NO_RESULTS.message,nil,0
			end
		end
	},
}

return _E
