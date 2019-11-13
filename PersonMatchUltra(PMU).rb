class Persona
  attr_reader :caracteristicas
  attr_reader :marca
  def initialize(caracteristicas)
    @caracteristicas=caracteristicas
    @marca="";
  end
end
hombres=Array.new
mujeres=Array.new
parejas=Array.new
File.foreach("PersonasDisponibles.txt") do |line|
  c=line.split(",")
  persona=Persona.new(c)
  if persona.caracteristicas[1]=="H"
    hombres.push(persona)
  else
    mujeres.push(persona)
  end
end

class Pareja
  attr_reader :porcentaje
  attr_reader :hombre
  attr_reader :mujer
  def initialize (hombre,mujer)
    @hombre=hombre
    @mujer=mujer
    contador=0
    for i in (4..11)
      if(hombre.caracteristicas[i]==mujer.caracteristicas[i])
        contador=contador+1
      end
    end
    @porcentaje=(contador*100)/8
  end
end
#para caso 1
parejasAux=Array.new
min=[hombres.length,mujeres.length].min-1
for i in (0..min)
  pareja=Pareja.new(hombres[i],mujeres[i])
  puts "porcentaje ",pareja.porcentaje,pareja.hombre.caracteristicas[0],pareja.mujer.caracteristicas[0]
  parejasAux.push(pareja)
end

min=min-1
puts "\n CON ALGORITMO\n"
for i in (min).downto(0)
  aux=Array.new
  for c in (0..i)
      pareja=0
      max1=[parejasAux[c],parejasAux[c+1]]
      max2=[Pareja.new(parejasAux[c].hombre,parejasAux[c+1].mujer),Pareja.new(parejasAux[c+1].hombre,parejasAux[c].mujer)]
      max1=max1.sort_by(&:porcentaje).reverse
      max2=max2.sort_by(&:porcentaje).reverse
      if (max1[0].porcentaje>max2[0].porcentaje)
        aux.push(max1[0])
        pareja=max1[1]
      else
        aux.push(max2[0])
        pareja=max2[1]

      end
      parejasAux[c+1]=pareja
  end
  parejas.push(parejasAux.pop)
  parejasAux=aux

end
parejas.push(parejasAux.pop)
for a in parejas
  puts a.porcentaje,a.hombre.caracteristicas[0],a.mujer.caracteristicas[0]
end
