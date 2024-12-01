-- La solución está mal en algunos lugares, me saque 8

module Library where
import PdePreludat
import Data.Char (toLower, isAlpha, isDigit)

-- --------------------- Dominio ------------------------
data Autor = UnAutor {
    nombre :: Nombre,
    obras :: [Obra]
}

-- --------------------- Definicion de Tipos ------------------------
type Nombre = String
type Obra = (Texto, Annio)

type Texto = String
type Annio = Number
type Fabricante = String

type Plagio = Obra -> Obra -> Bool
type Bot = (Fabricante, [Plagio])

-- --------------------- Modelaje (Ejemplos) ------------------------
-- -------------- Autores
pepe :: Autor
pepe = UnAutor "Pepe Gonzales" [historiaPatos]

maria :: Autor
maria = UnAutor "Maria Perez" [historiaPatos2]

samanta :: Autor
samanta = UnAutor "Samanta Lopez" [historiaMSM]

fernando :: Autor
fernando = UnAutor "Fernando Smith" [obraCientifica]

juliana :: Autor
juliana = UnAutor "Juliana Martinez" [historiaMSMCientifica]

-- -------------- Obras
historiaPatos :: Obra
historiaPatos = ("Habia una vez un pato." , 1997)

historiaPatos2 :: Obra
historiaPatos2 = ("¡Habia una vez un pato!" , 1996)

historiaMSM :: Obra
historiaMSM = ("Mirtha, Susana y Moria." , 2010)

obraCientifica :: Obra
obraCientifica = ("La semántica funcional del amoblamiento vertebral es riboficiente" , 2020)

historiaMSMCientifica :: Obra
historiaMSMCientifica = ("La semántica funcional de Mirtha, Susana y Moria." , 2022)

-- -------------- Bots
copilot :: Bot
copilot = ("OpenAI", [copiaLiteral , empiezaIgual 10 , agregaronIntro])

chatGPT :: Bot
chatGPT = ("OpenAI" , [escribieronAlReves])

-- --------------------- Funciones ------------------------
-- ------------------- Parte 1
versionCrudaTexto :: Texto -> Texto
versionCrudaTexto = map sacarTildes . filter pasarACrudo

pasarACrudo :: Char -> Bool
pasarACrudo char = isAlpha char || isDigit char

sacarTildes :: Char -> Char
sacarTildes c = snd $ (head . filter ((== c) . fst)) charSinTilde

charSinTilde :: [(Char, Char)]
charSinTilde = [
    ('á', 'a'), ('é', 'e'), ('í', 'i'), ('ó', 'o'), ('ú', 'u'),
    ('Á', 'A'), ('É', 'E'), ('Í', 'I'), ('Ó', 'O'), ('Ú', 'U')
    ]

-- ------------------- Parte 2 (Plagio)
-- Funcion 1
propIgual :: (Texto -> a) -> (a -> a -> Bool) -> Plagio
propIgual prop op plagio original = 
    prop (fst plagio) `op` prop (fst original)

publicadaDespues :: Obra -> Obra -> Bool
publicadaDespues plagio original = snd plagio > snd original

-- Funcion 2
copiaLiteral :: Plagio
copiaLiteral plagio original = 
    publicadaDespues plagio original && 
    propIgual versionCrudaTexto (==) plagio original

-- Funcion 3
empiezaIgual :: Number -> Plagio
empiezaIgual delta plagio original = 
    publicadaDespues plagio original &&  
    propIgual (take delta) (==) plagio original && 
    propIgual length (<) plagio original

-- Funcion 4
agregaronIntro :: Plagio
agregaronIntro plagio original = 
    publicadaDespues plagio original && 
    finalIgual plagio original 

finalIgual :: Plagio
finalIgual plagio original = fst plagio == drop (inicioTexto plagio original) (fst original)

inicioTexto :: Obra -> Obra -> Number
inicioTexto plagio original = length (fst original) - length (fst original)

-- Funcion 5
escribieronAlReves :: Plagio
escribieronAlReves = \ plagio original -> reversaIgual plagio original

reversaIgual :: Plagio
reversaIgual plagio original = reverse (fst plagio) == fst original

-- ------------------- Parte 3 (Bots)

botDetecta :: Bot -> Plagio
botDetecta (_, []) _ _ = False
botDetecta (_, plagio: plagios) obra1 obra2 = foldr (detectaPlagio obra1 obra2) False plagios

detectaPlagio :: Obra -> Obra -> Plagio -> Bool -> Bool
detectaPlagio obra1 obra2 plagio bool = plagio obra1 obra2 || bool

-- Funcion 1
cadenaPlagiadores :: Bot -> [Autor] ->Bool
cadenaPlagiadores _ [] = True
cadenaPlagiadores bot (a1: a2: autores) = 
    plagioEntreAutores (&&) bot (obras a1) (obras a2) && cadenaPlagiadores bot (a2:autores) 

plagioEntreAutores :: (Bool -> Bool -> Bool) -> Bot -> [Obra] -> [Obra] -> Bool
plagioEntreAutores bot _ [] _ = True
plagioEntreAutores op bot (obra1:obras1) obras2 = 
    obraPlageaObras bot obra1 obras2 `op` plagioEntreAutores op bot obras1 obras2  

obraPlageaObras :: Bot -> Obra -> [Obra] -> Bool
obraPlageaObras bot obra = any (botDetecta bot obra)

-- Funcion 2

plagiaronUnaVez :: Bot -> [Autor] -> [Autor]
plagiaronUnaVez bot (autor:autores) = 
    filter (copioUnaVez bot autores) autores

copioUnaVez :: Bot -> [Autor] -> Autor -> Bool
copioUnaVez bot autores autor = 
    any (huboPlagio bot autor) autores

huboPlagio :: Bot -> Autor -> Autor -> Bool
huboPlagio bot autor1 = 
    plagioEntreAutores (||) bot (obras autor1) . obras


-- ------------------- Parte 4 (Infinito)

obraInfinita :: Obra
obraInfinita = (textoInfinito 'a' , 2024)

textoInfinito :: Char -> Texto
textoInfinito char = char : textoInfinito char

{-

¿Qué sucede si se desea verificar si esa obra es plagio de otra con 
cada una de las formas existentes? 
Justificar conceptualmente en cada caso.

Veamos cada caso, comencemos por copiaLiteral:
    - En primer lugar evaluamos si fue publicada despues, como Haskell 
    tiene un motor de evaluacion diferida va a tomar primero la función y luego los parametros,
    como entiende que solo necesita la segunda parte de la tupla (el annio), evalua solo este
    sin tener en cuenta el texto infinito. Por lo que puede evaluar con exito. 
    - En segundo lugar evalua si las versiones crudas de las obras son iguales
    y aqui falla, se quedaría evaluando hasta siempre a menos que la interrumpas. Sucede esto
    porque la funcion "versionCrudatexto" debe evaluar la lista completa, y si está es infinita
    nunca parara de evaluar. 

empiezaIgual:
    - Ya analice publicadaDespues
    - Podría evaluar la segunda condicion ya que hace uso de la funcion take, como
    solo debe evaluar los primeros elementos, Haskell los toma (sin importarle que el resto sea infinito)
    y evalua, como ya explique debido a su condicion de lazy evaluation.
    - El problema llega con esta condicion, ya que evalua la longitud de las listas,
    como se trata de una lista infinita nunca va a poder terminar de evaluar y va a quedar así hasta el infinito
    o hasta que la interrumpas. 

agregaronIntro:
    - Ya analice publicadaDespues
    - Encontramos varios casos dependiendo de cual es la obra plageada y cual la original:
        1. Obra Plageada (Infinita) y Obra Original (Finita)
        
            Va a generar error, porque para calcular (en mi implementacion) que parte debe
            analizar, hay que restar la longitud de una a la otra, y nunca se podría restar
            infinito a algo finito. 
        
        2. Obra Plageada (Finita / Infinita) y Obra Original (Infinita)

            Va a quedarse evaluando infinitamente, debido a que en mi implementacion 
            hay que evaluar primero la longitud de la obra original para poder conseguir
            la parte del final a evaluar, nunca podría terminar de conseguir la longitud. 


escribieronAlReves: Ocurriria una situación similar a aquellas condiciones 
donde se utiliza length, como tiene que dar vuelta toda la lista para poder evaluar,
nunca generaría un resultado. 

-}
