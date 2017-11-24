STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

MAX_WIDTH = 30
MAX_HEIGHT = 20

last_move = ''
game = Array.new(MAX_HEIGHT){Array.new(MAX_HEIGHT)}

def admissible_move(game, x, y, last_move)
    result = []
    result << 'UP' if (y > 1 && last_move != 'DOWN' && game[y-1][x].nil?)
    result << 'DOWN' if (y < MAX_HEIGHT - 1 && last_move != 'UP' && game[y+1][x].nil?)
    result << 'LEFT' if (x > 1 && last_move != 'RIGHT' && game[y][x-1].nil?)
    result << 'RIGHT' if (x < MAX_WIDTH - 1 && last_move != 'LEFT' && game[y][x+1].nil?)
    result
end

# game loop
loop do
    round_admissible_move = []
    player = {}
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
        player = {x: x1, y: y1} if pn == p
    end

    round_admissible_move = admissible_move(game, player[:x], player[:y], last_move)

    # Write an action using puts
    # To debug: STDERR.puts "Debug messages..."

    # move with any of the admissible moves if I can
    last_move = round_admissible_move.any? ? round_admissible_move.sample : last_move
    puts last_move # A single line with UP, DOWN, LEFT or RIGHT
end
