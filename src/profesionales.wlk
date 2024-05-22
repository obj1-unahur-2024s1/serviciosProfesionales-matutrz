class ProfesionalAsociado {
	var property universidad
	
	method provinciasDondePuedeTrabajar() { return #{"Entre Ríos", "Corrientes", "Santa Fe"} }
	
	method honorarios() = 3000
	
	method cobrar(monto){
		asociacion.recibirDonacion(monto)
	}
		
}


class ProfesionalVinculado {
	var property universidad
	
	method provinciasDondePuedeTrabajar() =
		universidad.provincia()
	
	method honorarios() = 
		universidad.honorarioRecomendado()
		
	method cobrar(monto) {
		universidad.recibirDonacion(monto / 2)
	} 
}


class ProfesionalLibre {
	var property universidad
	var property honorarios
	const property provinciasDondePuedeTrabajar = []
	
	method sumarProvincia(provincia) =
		provinciasDondePuedeTrabajar.add(provincia)
	}

class Universidad {
	const property provincia
	var property honorarioRecomendado
	
	var donaciones = 0
	
	method recibirDonacion(importe){
		donaciones += importe
	}
}

class Empresa {
	var property honorario
	
	const property profesionales = []
	
	method contratar(profesional) =
		profesionales.add(profesional)
	
	method recibidosEnXUniversidad(universidad) =
		profesionales.count({p => p.universidad() == universidad})
		
	method profesionalesCaros() =
		profesionales.filter({p => p.honorarios() > honorario}).asSet()
	
	method universidadesFormadoras(){
		profesionales.map({p => p.universidad()}).asSet()
	}
	
	method profesionalMasBarato() =
		profesionales.min({p => p.honorarios()})
		
	method esDeGenteAcotada() =
		profesionales.all({p => p.provinciasDondePuedeTrabajar().size() <= 3})

	method puedeSatisfacer(solicitante){
		profesionales.any({p => solicitante.puedeSerAtendidoPOr(p)})
	}
	
	method darServicio(solicitante){
		if(self.puedeSatisfacer(solicitante)){
			var elegido = profesionales.anyOne()
			elegido.cobrar(elegido.honorario())
			clientes.add(solicitante)
		}
	}
}

class Persona {
	var property provincia
	
	method puedeSerAtendidoPor(profesional) = 
		profesional.provinciasDondePuedeTrabajar().contains(self.provincia())
	
}

class Institucion {
	const property universidadesReconocidas = []
	
	method puedeSerAtendidoPor(profesional) = 
		universidadesReconocidas.contains(profesional.universidad())
}

class Club {
	const property provincias = []
	
	method puedeSerAtendidoPor(profesional) =
	provincias.contains(profesional.provinciasDondePuedeTrabajar())
}

object asociacion {
	var recaudado = 0
	
	method recibirDonacion(monto){
		recaudado += monto
	}
}
