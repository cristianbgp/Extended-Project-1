require 'colorize'

def creation_board (arr)
    tablero = ""
    for i in (0..8)
        posicion = " " + (i+1).to_s
        case arr[i]
            when "1"
                posicion = " x".blue
            when "0"
                posicion = " o".red
        end
        
        if i < 8
            if i == 2 || i == 5
                posicion += "\n-----------\n"
            else
                posicion += " |"
            end
        end
        tablero += posicion
    end
    tablero
end
#jugadas a ganar
#posicion 0,1,2 - 3,4,5 - 6,7,8 - 0,4,8 - 2,4,6 - 0,3,6 - 1,4,7 - 2,5,8
def validate_winner (arr, last_player)
    if (arr[0..2] == Array.new(3,"1") || arr[0..2] == Array.new(3,"0")) ||
       (arr[3..5] == Array.new(3,"1") || arr[3..5] == Array.new(3,"0")) ||
       (arr[6..8] == Array.new(3,"1") || arr[6..8] == Array.new(3,"0")) ||
       ([arr[0],arr[4],arr[8]] == Array.new(3,"1") || [arr[0],arr[4],arr[8]] == Array.new(3,"0")) ||
       ([arr[2],arr[4],arr[6]] == Array.new(3,"1") || [arr[2],arr[4],arr[6]] == Array.new(3,"0")) ||
       ([arr[0],arr[3],arr[6]] == Array.new(3,"1") || [arr[0],arr[3],arr[6]] == Array.new(3,"0")) ||
       ([arr[1],arr[4],arr[7]] == Array.new(3,"1") || [arr[1],arr[4],arr[7]] == Array.new(3,"0")) ||
       ([arr[2],arr[5],arr[8]] == Array.new(3,"1") || [arr[2],arr[5],arr[8]] == Array.new(3,"0"))
        return last_player
    end
    return ""
end

#Variables generales
array_opciones = [1, 2, 3, 4, 5, 6, 7, 8, 9]
array_no_opciones = []
array_jugadas = Array.new(9,"")
step_jugadas = 0
#Juego
puts "Bievenido al juego #️⃣  🐱  !!\n\n"
puts "----------------------------------"
msj_inicio = "Elige un número del tablero para hacer tu jugada\n\n"
board = " 1 | 2 | 3\n-----------\n 4 | 5 | 6\n-----------\n 7 | 8 | 9\n\n"
puts msj_inicio + board
jugada = 0
loop do
    jugada = gets.chomp.to_i
    break if jugada > 0 && jugada <10
    puts "Ingrese un valor correcto\n" + msj_inicio + board
end
array_jugadas[jugada-1] = "1"
array_no_opciones.push(jugada)
board = creation_board (array_jugadas)
step_jugadas += 1
puts "\n" + board + "\n\n"
msj_computador = "El computador esta jugando\n\n"
msj_persona = "Continua tu jugada, elige un número del tablero\n\n"
for n in (1..4)
    system "clear"
    if step_jugadas >= 5
        result = validate_winner(array_jugadas, "1")
        if result != ""
            puts "El ganador eres tú!!! 🎉  🙌  🙌  🎉"
            break
        end
    end
    puts msj_computador
    jugada_computador = (array_opciones-array_no_opciones).sample
    array_jugadas[jugada_computador-1] = "0"
    array_no_opciones.push(jugada_computador)
    board = creation_board (array_jugadas)
    step_jugadas += 1
    puts "\n" + msj_persona + board + "\n\n"
    if step_jugadas >= 5
        result = validate_winner(array_jugadas, "0")
        if result != ""
            puts "El ganador es el computador!!! 😓  😓 Intentalo la proxima vez"
            break
        end
    end
    jugada = 0
    loop do
        jugada = gets.chomp.to_i
        if array_no_opciones.include?(jugada)
            puts "Esa posición esta usada\n"
        elsif jugada > 0 && jugada <10
            break
        end
        puts "Ingrese un valor correcto\n" + msj_persona + board
    end
    array_jugadas[jugada-1] = "1"
    array_no_opciones.push(jugada)
    board = creation_board (array_jugadas)
    step_jugadas += 1
    puts "\n" + board + "\n\n"
end
puts "Empataron!! 🤷‍♂️  🤷‍♂️" if step_jugadas == 9