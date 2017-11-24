STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

MAX_WIDTH = 30
MAX_HEIGHT = 20

last_move = ''
game = Array.new(MAX_HEIGHT){Array.new(MAX_WIDTH)}

def valid_cell(x, y)
    x >= 0 && x < MAX_WIDTH && y >= 0 && y < MAX_HEIGHT
end

# generate voronoi graph
def voronoi(game, player, opponent)
    results = Array.new(MAX_HEIGHT){Array.new(MAX_WIDTH)}
    STDERR.puts results[0].length
    (0..MAX_WIDTH-1).each do |tx|
        (0..MAX_HEIGHT-1).each do |ty|
            playerOffset = (player[:x] - tx).abs + (player[:y] - ty).abs
            opponentOffset = (opponent[:x] - tx).abs + (opponent[:y] - ty).abs
            results[ty][tx] = opponentOffset - playerOffset
        end
    end
    results
end

def admissible_space(game, x, y)
    # count surrounding admissible cells
    cells = 0
    (x-1..x+1).each do |tx|
        (y-1..y+1).each do |ty|
            if (valid_cell(tx, ty) && game[ty][tx].nil?)
                cells += 1
            end
        end
    end
    cells
end

def voronoi_value(game, x, y, player, opponent)
    game[y][x] = player[:id]
    value = 0
    v = voronoi(game, player, opponent)
    (0..MAX_HEIGHT-1).each do |ty|
        (0..MAX_WIDTH-1).each do |tx|
            if (game[ty][tx].nil?)
                value += v[ty][tx] > 0 ? # closer to opponent
                    -admissible_space(game, ty, tx) : (v[ty][tx] == 0) ?
                        0 : admissible_space(game, ty, tx)
            end
        end
    end
    value
end

def admissible_move(game, x, y, last_move, player, opponent)
    result = []
    result << { move: 'UP', value: voronoi_value(game, x, y-1, player, opponent) } if (y > 0 && last_move != 'DOWN' && game[y-1][x].nil?)
    result << { move: 'DOWN', value: voronoi_value(game, x, y+1, player, opponent) } if (y < MAX_HEIGHT - 1 && last_move != 'UP' && game[y+1][x].nil?)
    result << { move: 'LEFT', value: voronoi_value(game, x-1, y, player, opponent) } if (x > 0 && last_move != 'RIGHT' && game[y][x-1].nil?)
    result << { move: 'RIGHT', value: voronoi_value(game, x+1, y, player, opponent) } if (x < MAX_WIDTH - 1 && last_move != 'LEFT' && game[y][x+1].nil?)
    result.sort { |a, b| b[:value] <=> a[:value] }
end

# game loop
loop do
    round_admissible_move = []
    player = {}
    opponent = {}
    # n: total number of players (2 to 4).
    # p: your player number (0 to 3).
    n, p = gets.split(" ").collect {|x| x.to_i}
    n.times do |pn|
        # x0: starting X coordinate of lightcycle (or -1)
        # y0: starting Y coordinate of lightcycle (or -1)
        # x1: starting X coordinate of lightcycle (can be the same as X0 if you play before this player)
        # y1: starting Y coordinate of lightcycle (can be the same as Y0 if you play before this player)
        x0, y0, x1, y1 = gets.split(" ").collect {|x| x.to_i}
        game[y1][x1] = pn
        if pn == p
            player = {x: x1, y: y1, id: pn} 
        else
            opponent = {x: x1, y: y1, id: pn}
        end
    end

    STDERR.puts player, last_move
    round_admissible_moves = admissible_move(game, player[:x], player[:y], last_move, player, opponent)

    STDERR.puts round_admissible_moves.length
    STDERR.puts round_admissible_moves
    # Write an action using puts
    # To debug: STDERR.puts "Debug messages..."

    # move with any of the admissible moves if I can
    last_move = round_admissible_moves.any? ? round_admissible_moves.first[:move] : last_move
    puts last_move # A single line with UP, DOWN, LEFT or RIGHT
end
