STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

MAX_WIDTH = 30
MAX_HEIGHT = 20

last_move = ''

def admissible_move(x, y, last_move)
    result = []
    result << 'UP' if (y > 1 && last_move != 'DOWN')
    result << 'DOWN' if (y < MAX_HEIGHT - 1 && last_move != 'UP')
    result << 'LEFT' if (x > 1 && last_move != 'RIGHT')
    result << 'RIGHT' if (x < MAX_WIDTH - 1 && last_move != 'LEFT')
    result
end

# game loop
loop do
    round_admissible_move = []
    # n: total number of players (2 to 4).
    # p: your player number (0 to 3).
    n, p = gets.split(" ").collect {|x| x.to_i}
    n.times do |pn|
        k = gets
        STDERR.puts k
        # x0: starting X coordinate of lightcycle (or -1)
        # y0: starting Y coordinate of lightcycle (or -1)
        # x1: starting X coordinate of lightcycle (can be the same as X0 if you play before this player)
        # y1: starting Y coordinate of lightcycle (can be the same as Y0 if you play before this player)
        x0, y0, x1, y1 = k.split(" ").collect {|x| x.to_i}
        if (pn == p)
          round_admissible_move = admissible_move(x1, y1, last_move)
        end
    end

    STDERR.puts round_admissible_move

    # Write an action using puts
    # To debug: STDERR.puts "Debug messages..."

    last_move = "DOWN"
    puts last_move # A single line with UP, DOWN, LEFT or RIGHT
end
