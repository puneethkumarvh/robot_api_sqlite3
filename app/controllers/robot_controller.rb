class RobotController < ApplicationController
  def orders
    @x, @y, flag = 0
           @min, @max, @direction = 0, 4, ""

     
           @commands = params[:commands]

           count = 0
           for i in 0..@commands.length-1 do
                if @commands[i][0] == "P"
                    break
                                                   
                else
                    count+=1
                                 
               end
           end
           @commands = @commands.drop(count)
           
          # render json: @commands
    
           
           for i in 0..@commands.length-1 do
               cmd = @commands[i].downcase!.gsub(","," ").split(" ")

               if cmd[0] == 'place'
                  
                   if cmd[1].to_i <= @max && cmd[2].to_i <= @max && cmd[1].to_i >= @min && cmd[2].to_i >= @min 

                       place(cmd[1].to_i, cmd[2].to_i, cmd[3])

                   else

                       flag=1
                       break

                   end
               elsif cmd[0] == 'move'
                   move()

               elsif cmd[0] == 'left' || cmd[0] == 'right'
                   rotate(cmd[0])

               elsif cmd[0] == 'report'
                   report()

               end
           end
           #render json: cmd

           if flag==1
               render json: { "Error": "Values are incorrect" }
           end
       end

 
           
           
       
        

            
      
  
 private 
 def place(x, y, dir)
    @x, @y, @direction = x, y, dir
 end


def move
    if @direction == 'north' && @y < @max
                    @y += 1
       
    elsif @direction == 'south' && @y > @min
        
            @y -= 1
        
    elsif @direction == 'east' && @x < @max
        
            @x += 1
        
    else
        if @y > @min 
            @y -= 1
        end
    end
end
       
        def rotate(side)

            if side == 'left'

                if @direction == 'south'
                    @direction = 'east'

                elsif @direction == 'east'
                    @direction = 'north'

                elsif @direction == 'north'
                    @direction = 'west'

                else
                    @direction = 'south'
                end
            else

                if @direction == 'south'
                    @direction = 'west'

                elsif @direction == 'west'
                    @direction = 'north'

                elsif @direction == 'north'
                    @direction = 'east'

                else
                    @direction = 'south'

                end
            end
        end

   
        def report
            render json:  { location: [@x,@y,@direction.upcase] }
        end
  
end
