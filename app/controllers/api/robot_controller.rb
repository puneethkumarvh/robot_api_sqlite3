class Api::RobotController < ApplicationController
  def orders
    @x, @y, flag = 0
    @min = 0
    @max = 4
    @direction = ''

    @commands = params[:Commands]

    count = 0
    for i in 0..@commands.length - 1 do
      if @commands[i][0] == 'P'
        break

      else
        count += 1

      end
    end
    @commands = @commands.drop(count)

    # render json: @commands

    for i in 0..@commands.length - 1 do
      cmd = @commands[i].downcase!.gsub(',', ' ').split(' ')

      if cmd[0] == 'place'

        if cmd[1].to_i <= @max && cmd[2].to_i <= @max && cmd[1].to_i >= @min && cmd[2].to_i >= @min

          place(cmd[1].to_i, cmd[2].to_i, cmd[3])

        else

          flag = 1
          break

        end
      elsif cmd[0] == 'move'
        move

      elsif cmd[0] == 'left' || cmd[0] == 'right'
        rotate(cmd[0])

      elsif cmd[0] == 'report'
        report

      end
    end
    # render json: cmd

    render json: { "Error": 'Values are incorrect' } if flag == 1
  end

  private

  def place(x, y, dir)
    @x = x
    @y = y
    @direction = dir
  end

  def move
    if @direction == 'north' && @y < @max
      @y += 1

    elsif @direction == 'south' && @y > @min

      @y -= 1

    elsif @direction == 'east' && @x < @max

      @x += 1

    elsif @direction == 'west' && @x > @min
      @x -= 1
    end
  end

  def rotate(side)
    @direction = if side == 'left'

                   if @direction == 'south'
                     'east'

                   elsif @direction == 'east'
                     'north'

                   elsif @direction == 'north'
                     'west'

                   else
                     'south'
                   end
                 elsif @direction == 'south'

                   'west'

                 elsif @direction == 'west'
                   'north'

                 elsif @direction == 'north'
                   'east'

                 else
                   'south'

                 end
  end

  def report
    render json: { location: [@x, @y, @direction.upcase] }
  end
end
